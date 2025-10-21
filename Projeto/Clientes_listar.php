<?php
// Arquivo: clientes_listar.php
// Tela de listagem de clientes, AGORA com a barra de busca no topo.

// Nota: Você precisará da conexão com o banco de dados aqui se 
// for carregar a lista completa de clientes por padrão (sem AJAX).
?>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2><i class="fas fa-list me-2"></i> Lista de Clientes</h2>
    
    <div>
        <a href="#" class="btn btn-success item-menu-ajax" data-pagina="clientes_cadastro.php">
            <i class="fas fa-user-plus me-2"></i> Novo Cliente
        </a>
    </div>
</div>

<div class="card mb-4 shadow-sm">
    <div class="card-header bg-secondary text-white">
        <i class="fas fa-search me-2"></i> Pesquisar Cliente
    </div>
    <div class="card-body">
        <form id="form-busca-cliente-rapida"> 
            <div class="input-group">
                <input type="text" id="termo_busca" name="termo_busca" class="form-control" placeholder="Digite Nome ou CPF do cliente para pesquisar..." required>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-search me-1"></i> Buscar
                </button>
            </div>
        </form>
    </div>
</div>

<div id="resultado-busca-rapida" class="mt-4">
    
    <div class="alert alert-info">
        Use a barra de pesquisa acima para filtrar clientes por nome ou CPF.
        Se não houver termo de busca, a lista completa deve ser carregada por um script padrão.
    </div>

</div>