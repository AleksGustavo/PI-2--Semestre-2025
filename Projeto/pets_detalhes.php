<?php
// Arquivo: pets_detalhes.php - Ficha Detalhada do Pet
require_once 'conexao.php'; // Garante a conexão com o banco de dados

$pet_id = filter_input(INPUT_GET, 'id', FILTER_VALIDATE_INT);
$pet = null;

// ==================================================================================
// CAMINHOS WEB: AJUSTE ESTES CAMINHOS PARA ONDE ESTÃO SUAS PASTAS
// ==================================================================================
$URL_UPLOADS = 'uploads/fotos_pets/'; 
$URL_PLACEHOLDER = 'assets/img/pet_placeholder.png'; // Caminho para uma imagem padrão
// ==================================================================================

if (isset($conexao) && $conexao && $pet_id) {
    try {
        // 1. Busca os detalhes do Pet (INCLUINDO JOIN COM RACAS PARA PEGAR O NOME) e do Dono
        $sql_pet = "SELECT 
                        p.id, p.nome, p.data_nascimento, p.foto AS foto_path, p.castrado,
                        r.nome AS raca_nome, -- <--- CORREÇÃO AQUI: PEGANDO O NOME DA RAÇA DA TABELA 'racas'
                        c.id AS cliente_id, c.nome AS cliente_nome, c.telefone AS cliente_telefone
                    FROM 
                        pet p
                    JOIN 
                        clientes c ON p.cliente_id = c.id
                    LEFT JOIN -- LEFT JOIN para pets sem raça_id cadastrada (NULL)
                        racas r ON p.raca_id = r.id
                    WHERE 
                        p.id = ?";
                        
        $stmt_pet = mysqli_prepare($conexao, $sql_pet);
        mysqli_stmt_bind_param($stmt_pet, "i", $pet_id);
        mysqli_stmt_execute($stmt_pet);
        $result_pet = mysqli_stmt_get_result($stmt_pet);
        $pet = mysqli_fetch_assoc($result_pet);
        mysqli_stmt_close($stmt_pet);

        // 2. Verifica se o Pet tem vacinas na carteira
        $sql_vacina = "SELECT COUNT(id) AS total_vacinas FROM carteira_vacinas WHERE pet_id = ?";
        $stmt_vacina = mysqli_prepare($conexao, $sql_vacina);
        mysqli_stmt_bind_param($stmt_vacina, "i", $pet_id);
        mysqli_stmt_execute($stmt_vacina);
        $result_vacina = mysqli_stmt_get_result($stmt_vacina);
        $dados_vacina = mysqli_fetch_assoc($result_vacina);
        mysqli_stmt_close($stmt_vacina);
        
        $total_vacinas = $dados_vacina['total_vacinas'];
        
    } catch (Exception $e) {
        // Agora, se houver erro, loga e exibe uma mensagem genérica ou o erro para debug
        error_log("Erro ao carregar detalhes do Pet: " . $e->getMessage());
        echo '<div class="alert alert-danger">Erro crítico ao carregar a ficha do Pet. Tente novamente.</div>';
        $pet = null;
    }
    // Não feche a conexão aqui se você for reutilizá-la em outros arquivos incluídos.
    // Se este é o final do script, pode fechar.
    // mysqli_close($conexao); 
}

if (!$pet) {
    echo '<div class="alert alert-danger">Pet não encontrado ou ID inválido.</div>';
    exit();
}

// Configurações de Status
$is_castrado = (bool)$pet['castrado'];
$status_castracao = $is_castrado ? 'Castrado' : 'Não Castrado';
$castracao_class = $is_castrado ? 'badge bg-success' : 'badge bg-warning text-dark';

$is_vacinado = $total_vacinas > 0;
$status_vacina = $is_vacinado ? 'Com Histórico' : 'Sem Histórico';
$vacina_class = $is_vacinado ? 'badge bg-primary' : 'badge bg-secondary';

// Determina o caminho da foto
$foto_path = $pet['foto_path'] ?? '';
// O caminho da foto no banco é o nome do arquivo. Precisamos do caminho completo.
$foto_url = (!empty($foto_path) && file_exists($URL_UPLOADS . $foto_path)) 
            ? $URL_UPLOADS . $foto_path
            : $URL_PLACEHOLDER;
?>

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2><i class="fas fa-paw me-2"></i> Ficha do Pet: <?php echo htmlspecialchars($pet['nome']); ?></h2>
        
        <a href="#" class="btn btn-warning item-menu-ajax" 
            data-pagina="pets_carteira_vacinas.php?pet_id=<?php echo $pet_id; ?>" 
            title="Ver Histórico de Vacinas">
            <i class="fas fa-file-invoice me-1"></i> Ver Carteira de Vacinas
        </a>
    </div>

    <div class="card shadow-lg mb-4">
        <div class="card-body">
            <div class="row">
                <div class="col-md-3 text-center">
                    <img src="<?php echo $foto_url; ?>" class="img-fluid rounded-circle border border-4 border-light shadow-sm mb-3" style="width: 180px; height: 180px; object-fit: cover;" alt="Foto do Pet">
                </div>
                
                <div class="col-md-9">
                    <h5 class="mb-3 text-secondary">Informações do Pet</h5>
                    <ul class="list-group list-group-flush mb-4">
                        <li class="list-group-item"><strong>Nome:</strong> <?php echo htmlspecialchars($pet['nome']); ?></li>
                        <li class="list-group-item"><strong>Raça:</strong> <?php echo htmlspecialchars($pet['raca_nome'] ?? 'Não informada'); ?></li>
                        <li class="list-group-item"><strong>Nascimento:</strong> <?php echo date('d/m/Y', strtotime($pet['data_nascimento'])); ?></li>
                    </ul>
                    
                    <h5 class="mb-3 text-secondary">Status</h5>
                    <div class="d-flex flex-wrap gap-2">
                        <div>
                            <span class="fw-bold me-2">Castrado:</span>
                            <span class="<?php echo $castracao_class; ?> p-2"><?php echo $status_castracao; ?></span>
                        </div>
                        <div>
                            <span class="fw-bold me-2">Vacinação:</span>
                            <span class="<?php echo $vacina_class; ?> p-2"><?php echo $status_vacina; ?></span>
                        </div>
                    </div>
                    
                    <h5 class="mt-4 mb-3 text-secondary">Detalhes do Dono</h5>
                    <p class="mb-1">
                        <strong>Nome:</strong> 
                        <a href="#" class="item-menu-ajax" data-pagina="clientes_detalhes.php?id=<?php echo $pet['cliente_id']; ?>">
                            <?php echo htmlspecialchars($pet['cliente_nome']); ?>
                        </a>
                    </p>
                    <p><strong>Telefone:</strong> <?php echo htmlspecialchars($pet['cliente_telefone']); ?></p>
                </div>
            </div>
        </div>
    </div>
</div>