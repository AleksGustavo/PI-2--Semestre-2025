<?php
// Arquivo: clientes_buscar_rapido.php
// Script que processa a busca rápida de clientes por NOME ou CPF e retorna o HTML.

require_once 'conexao.php'; 

$termo = trim($_GET['termo_busca'] ?? '');

// ==================================================================================
// CONFIGURAÇÃO DE CAMINHOS WEB: AJUSTE SE NECESSÁRIO
// ==================================================================================
$BASE_PATH = '/PHP_PI/'; 
$URL_UPLOADS = $BASE_PATH . 'uploads/fotos_pets/'; 
$URL_PLACEHOLDER = $BASE_PATH . 'assets/img/pet_placeholder.png'; 
// ==================================================================================

if (empty($termo)) {
    echo '<p class="alert alert-warning">Digite um termo de busca (Nome ou CPF).</p>';
    exit();
}

if (!isset($conexao) || !$conexao) {
    echo '<p class="alert alert-danger">Erro crítico: Falha na conexão com o banco de dados.</p>';
    exit();
}

try {
    // 1. Busca clientes cujo nome OU CPF contenham o termo.
    $termo_like = '%' . $termo . '%';
    $sql = "SELECT id, nome, cpf, telefone 
            FROM clientes 
            WHERE (nome LIKE ? OR cpf LIKE ?) 
            AND ativo = 1
            LIMIT 10"; 
            
    $stmt = mysqli_prepare($conexao, $sql);
    // Bind: ss (duas strings)
    mysqli_stmt_bind_param($stmt, "ss", $termo_like, $termo_like);
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);
    $clientes = mysqli_fetch_all($result, MYSQLI_ASSOC);
    mysqli_stmt_close($stmt);

    if (empty($clientes)) {
        echo '<p class="alert alert-info">Nenhum cliente ativo encontrado com o termo "' . htmlspecialchars($termo) . '".</p>';
    } else {
        
        // 2. Monta a tabela de resultados
        echo '<h4>Resultados da Busca:</h4>';
        echo '<div class="table-responsive">';
        echo '<table class="table table-striped table-hover table-sm shadow-sm">';
        echo '<thead class="table-dark"><tr><th>Cliente (Dono)</th><th>CPF</th><th>Telefone</th><th style="min-width: 380px;">Ações</th></tr></thead>';
        echo '<tbody>';
        
        foreach ($clientes as $cliente) {
            $cliente_id = $cliente['id'];
            $nome_completo = htmlspecialchars($cliente['nome']);

            // LINHA DO CLIENTE
            echo '<tr>';
            echo '<td>' . $nome_completo . '</td>';
            echo '<td>' . htmlspecialchars($cliente['cpf']) . '</td>';
            echo '<td>' . htmlspecialchars($cliente['telefone']) . '</td>';
            echo '<td>';
            
            // BOTÃO CORRIGIDO: VER PETS (QUE LEVA PARA clientes_detalhes.php)
            echo '<a href="#" class="btn btn-sm btn-info item-menu-ajax me-2" data-pagina="clientes_detalhes.php?id=' . $cliente_id . '" title="Ver a lista de Pets cadastrados">';
            echo '<i class="fas fa-paw me-1"></i> Ver Pets'; 
            echo '</a>';
            
            // Botão ADICIONAR PET
            echo '<a href="#" class="btn btn-sm btn-success item-menu-ajax me-2" data-pagina="pets_cadastro.php?cliente_id=' . $cliente_id . '" title="Adicionar um novo Pet">';
            echo '<i class="fas fa-plus me-1"></i> Add Pet';
            echo '</a>';
            
            // Botão EDITAR
            echo '<a href="#" class="btn btn-sm btn-primary item-menu-ajax me-2" data-pagina="clientes_editar.php?id=' . $cliente_id . '" title="Editar Cliente">';
            echo '<i class="fas fa-user-edit"></i> Editar';
            echo '</a>';
            
            // Botão EXCLUIR
            echo '<a href="#" class="btn btn-sm btn-danger excluir-cliente" data-id="' . $cliente_id . '" title="Excluir Cliente">';
            echo '<i class="fas fa-trash-alt"></i>';
            echo '</a>';
            
            echo '</td>';
            echo '</tr>';
            
        } // Fim foreach clientes
        
        echo '</tbody>';
        echo '</table>';
        echo '</div>';
    }

} catch (Exception $e) {
    echo '<p class="alert alert-danger">Erro ao buscar clientes: ' . htmlspecialchars($e->getMessage()) . '</p>';
}

if (isset($conexao)) {
    mysqli_close($conexao);
}
?>