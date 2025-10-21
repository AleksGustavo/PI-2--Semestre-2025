<?php
// Arquivo: home.php (Corrigido para usar a conexão MySQLi $conexao)
require_once 'conexao.php'; // Esta linha agora inclui o $conexao

// Inicialização das variáveis
$total_clientes = 0;
$total_produtos = 0;
$produtos_baixo_estoque = 0;

// Garantimos que $conexao é um objeto de conexão válido antes de tentar usá-lo
if (isset($conexao) && $conexao) {
    try {
        // --- 1. Busca total de Clientes Ativos ---
        $sql_clientes = "SELECT COUNT(id) AS total FROM clientes WHERE ativo = 1";
        $result_clientes = mysqli_query($conexao, $sql_clientes);
        
        if ($result_clientes && $row = mysqli_fetch_assoc($result_clientes)) {
            $total_clientes = $row['total'];
        }
        
        // --- 2. Busca total de Produtos Ativos ---
        $sql_produtos = "SELECT COUNT(id) AS total FROM produtos WHERE ativo = 1";
        $result_produtos = mysqli_query($conexao, $sql_produtos);
        
        if ($result_produtos && $row = mysqli_fetch_assoc($result_produtos)) {
            $total_produtos = $row['total'];
        }
        
        // --- 3. Busca de Produtos em Estoque Crítico ---
        $sql_baixo_estoque = "SELECT COUNT(id) AS total FROM produtos WHERE quantidade_estoque <= estoque_minimo AND ativo = 1";
        $result_baixo_estoque = mysqli_query($conexao, $sql_baixo_estoque);

        if ($result_baixo_estoque && $row = mysqli_fetch_assoc($result_baixo_estoque)) {
            $produtos_baixo_estoque = $row['total'];
        }

    } catch (Exception $e) {
        // Usamos error_log em vez de um die() para não quebrar a interface
        error_log("Erro ao buscar contadores na home: " . $e->getMessage());
        // Aqui, as variáveis de contagem permanecerão em 0 ou seu valor inicial
    }
} else {
    // Se a conexão falhou no conexao.php, este bloco garante que as variáveis continuem a 0
    error_log("Variável \$conexao não está definida ou é inválida na home.php.");
}

// Não é necessário fechar a conexão aqui se ela for usada em todo o dashboard, 
// mas se for fechar, deve-se usar: mysqli_close($conexao);
?>

<div class="row mb-4">
    <div class="col-12">
        <h3 class="mb-3">Bem-vindo(a) ao Painel de Controle!</h3>
        <p class="text-muted">Visão geral rápida e atalhos para as operações mais comuns do dia a dia.</p>
    </div>
</div>

<div class="row">
    
    <div class="col-lg-4 col-md-6 mb-4">
        <div class="card h-100 shadow-sm border-primary">
            <div class="card-body text-center">
                <i class="fas fa-users fa-3x text-primary mb-3"></i>
                <h5 class="card-title">Clientes Ativos</h5>
                <p class="card-text">
                    Total de <span class="fs-4"><?= $total_clientes ?></span> clientes cadastrados.
                </p>
                <a href="#" class="btn btn-primary btn-sm item-menu-ajax" data-pagina="clientes_listar.php">
                    <i class="fas fa-search me-1"></i> Pesquisar
                </a>
            </div>
        </div>
    </div>
    
    <div class="col-lg-4 col-md-6 mb-4">
        <div class="card h-100 shadow-sm border-info">
            <div class="card-body text-center">
                <i class="fas fa-calendar-alt fa-3x text-info mb-3"></i>
                <h5 class="card-title">Novo Agendamento</h5>
                <p class="card-text text-muted">Registre banhos, tosas, ou consultas.</p>
                <a href="#" class="btn btn-info btn-sm item-menu-ajax" data-pagina="servicos_agendar_banhotosa.php">
                    <i class="fas fa-clock me-1"></i> Agendar
                </a>
            </div>
        </div>
    </div>
    
    <div class="col-lg-4 col-md-6 mb-4">
        <div class="card h-100 shadow-sm border-danger">
            <div class="card-body text-center">
                <i class="fas fa-box-open fa-3x text-danger mb-3"></i>
                <h5 class="card-title">Estoque Crítico</h5>
                <p class="card-text">
                    <span class="fs-4"><?= $produtos_baixo_estoque ?></span> produtos precisam de reposição.
                </p>
                <a href="#" class="btn btn-danger btn-sm item-menu-ajax" data-pagina="produtos_listar.php?filtro=critico">
                    <i class="fas fa-exclamation-triangle me-1"></i> Repor Agora
                </a>
            </div>
        </div>
    </div>
    
    <div class="col-lg-4 col-md-6 mb-4">
        <div class="card h-100 shadow-sm border-success">
            <div class="card-body text-center">
                <i class="fas fa-user-plus fa-3x text-success mb-3"></i>
                <h5 class="card-title">Cadastrar Novo Cliente</h5>
                <p class="card-text text-muted">Acesso rápido ao formulário de cadastro.</p>
                <a href="#" class="btn btn-success btn-sm item-menu-ajax" data-pagina="clientes_cadastro.php">
                    <i class="fas fa-address-card me-1"></i> Cadastrar
                </a>
            </div>
        </div>
    </div>
    
    <div class="col-lg-4 col-md-6 mb-4">
        <div class="card h-100 shadow-sm border-warning">
            <div class="card-body text-center">
                <i class="fas fa-chart-bar fa-3x text-warning mb-3"></i>
                <h5 class="card-title">Relatórios e Estatísticas</h5>
                <p class="card-text text-muted">Vendas, Pets mais atendidos, etc.</p>
                <a href="#" class="btn btn-warning btn-sm item-menu-ajax" data-pagina="relatorios_listar.php">
                    <i class="fas fa-arrow-right me-1"></i> Visualizar
                </a>
            </div>
        </div>
    </div>
</div>