<?php
session_start();

if (!isset($_SESSION['logado']) || $_SESSION['logado'] !== true) {
    header("Location: login.php");
    exit();
}

$usuario_logado = htmlspecialchars($_SESSION['username']);
?>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gerenciamento - Dashboard</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    
    <style>
        .sidebar {
            height: 100vh;
            background-color: #343a40; 
            color: white;
            padding-top: 20px;
        }
        .nav-link {
            color: rgba(255, 255, 255, 0.75);
            transition: all 0.2s;
        }
        .nav-link:hover {
            color: white;
            background-color: rgba(255, 255, 255, 0.1);
        }
        .collapse.show .nav-link {
            padding-left: 2rem;
            font-size: 0.95em;
        }
        .nav-link.active {
            color: white;
            background-color: rgba(255, 255, 255, 0.2);
            border-radius: 5px;
        }
    </style>
</head>
<body>

<div class="container-fluid">
    <div class="row">
        
        <nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block sidebar collapse">
            <div class="position-sticky pt-3">
                <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted text-uppercase">
                    <span>Menu Principal</span>
                </h6>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link active item-menu-ajax" data-pagina="home.php" href="#">
                            <i class="fas fa-home me-2"></i> Dashboard
                        </a>
                    </li>
                    
                    <li class="nav-item">
                        <a class="nav-link dropdown-toggle" data-bs-toggle="collapse" href="#clientesSubmenu" role="button" aria-expanded="false" aria-controls="clientesSubmenu">
                            <i class="fas fa-users me-2"></i> Gerenciar Clientes
                        </a>
                        <div class="collapse" id="clientesSubmenu">
                            <ul class="nav flex-column ms-3">
                                <li class="nav-item">
                                    <a class="nav-link item-menu-ajax" data-pagina="clientes_cadastro.php" href="#">
                                        <i class="fas fa-user-plus me-2"></i> Cadastrar Cliente
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link item-menu-ajax" data-pagina="clientes_listar.php" href="#">
                                        <i class="fas fa-list me-2"></i> Listar Clientes
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </li>
                    
                    <li class="nav-item">
                        <a class="nav-link dropdown-toggle" data-bs-toggle="collapse" href="#produtosSubmenu" role="button" aria-expanded="false" aria-controls="produtosSubmenu">
                            <i class="fas fa-box me-2"></i> Gerenciar Produtos
                        </a>
                        <div class="collapse" id="produtosSubmenu">
                            <ul class="nav flex-column ms-3">
                                <li class="nav-item">
                                    <a class="nav-link item-menu-ajax" data-pagina="produtos_cadastro.php" href="#">
                                        <i class="fas fa-plus me-2"></i> Cadastrar Produto
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link item-menu-ajax" data-pagina="produtos_listar.php" href="#">
                                        <i class="fas fa-cubes me-2"></i> Listar Produtos
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </li>
                    
                    <li class="nav-item">
                        <a class="nav-link dropdown-toggle" data-bs-toggle="collapse" href="#servicosSubmenu" role="button" aria-expanded="false" aria-controls="servicosSubmenu">
                            <i class="fas fa-cut me-2"></i> Gerenciar Serviços
                        </a>
                        <div class="collapse" id="servicosSubmenu">
                            <ul class="nav flex-column ms-3">
                                <li class="nav-item">
                                    <a class="nav-link item-menu-ajax" data-pagina="servicos_agendar_banhotosa.php" href="#">
                                        <i class="fas fa-calendar-check me-2"></i> Agendar Banho/Tosa
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link item-menu-ajax" data-pagina="servicos_vacinas.php" href="#">
                                        <i class="fas fa-syringe me-2"></i> Registrar Vacina
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link item-menu-ajax" data-pagina="servicos_agendamentos_listar.php" href="#">
                                        <i class="fas fa-calendar-alt me-2"></i> Listar Agendamentos
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link item-menu-ajax" data-pagina="usuarios_listar.php" href="#">
                            <i class="fas fa-user-lock me-2"></i> Listar Usuários
                        </a>
                    </li>
                </ul>
                
                <hr class="my-3 text-white-50">
                
                <ul class="nav flex-column mb-2">
                    <li class="nav-item">
                        <a class="nav-link" href="logout.php">
                            <i class="fas fa-sign-out-alt me-2"></i> Sair (Logout)
                        </a>
                    </li>
                </ul>
            </div>
        </nav>
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2">Painel de Gerenciamento</h1>
                <div class="btn-toolbar mb-2 mb-md-0">
                    <div class="me-2 text-muted">
                        Bem-vindo(a), <strong class="text-primary"><?php echo $usuario_logado; ?></strong>!
                    </div>
                </div>
            </div>

            <div id="conteudo-dinamico">
                </div>

        </main>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<script>
    
    // FUNÇÃO DE NAVEGAÇÃO
    function carregarConteudo(pagina) {
        // Oculta o conteúdo atual e mostra o loader
        $('#conteudo-dinamico').html('<div class="text-center mt-5"><i class="fas fa-spinner fa-spin fa-3x text-primary"></i><p class="mt-2 text-muted">Carregando...</p></div>');
        
        // Faz a requisição AJAX
        $.ajax({
            url: pagina, 
            type: 'GET',
            success: function(data) {
                // Insere o HTML retornado (o conteúdo da página)
                $('#conteudo-dinamico').html(data);
            },
            error: function(xhr, status, error) {
                // Em caso de erro
                $('#conteudo-dinamico').html('<div class="alert alert-danger">Erro ao carregar o conteúdo da página ' + pagina + '. Status: ' + xhr.status + ' (' + status + ')</div>');
                console.error("Erro no AJAX de Navegação:", status, error, xhr.responseText);
            }
        });
    }

$(document).ready(function() {
    
    // 1. LÓGICA DE NAVEGAÇÃO POR MENU E CARDS (DELEGAÇÃO)
    $(document).on('click', '.item-menu-ajax', function(e) {
        e.preventDefault(); 
        
        var $this = $(this);
        
        // 1.1 Limpa a classe 'active' e define no menu lateral (se aplicável)
        $('.nav-link[data-pagina]').removeClass('active');
        
        if ($this.closest('#sidebarMenu').length) {
            $this.addClass('active');
        } else {
            $('.nav-link[data-pagina="home.php"]').removeClass('active');
        }

        // 1.2 Pega o nome do arquivo e carrega
        var pagina = $this.data('pagina');
        if (pagina) {
            carregarConteudo(pagina);
        }
    });

    // 2. LÓGICA DE ENVIO DE FORMULÁRIOS (ADICIONADO NOVO FORMULÁRIO DE SERVIÇOS AQUI)
    // Inclui: #form-cadastro-cliente, #form-cadastro-produto, #form-cadastro-pet, #form-agendar-servico, #form-registrar-vacina
    $(document).on('submit', '#form-cadastro-cliente, #form-cadastro-produto, #form-cadastro-pet, #form-agendar-servico, #form-registrar-vacina', function(e) {
        e.preventDefault(); 
        
        var form = $(this);
        var url = form.attr('action');
        var dados = form.serialize();
        var formId = form.attr('id');
        
        // Determina a página de listagem para redirecionamento após o sucesso
        var paginaRedirecionamento;
        if (formId === 'form-cadastro-cliente' || formId === 'form-cadastro-pet') {
            paginaRedirecionamento = 'clientes_listar.php';
        } else if (formId === 'form-cadastro-produto') {
            paginaRedirecionamento = 'produtos_listar.php';
        } else if (formId === 'form-agendar-servico' || formId === 'form-registrar-vacina') {
             // Redireciona para a lista de agendamentos ou para a lista de clientes para ver a carteira
             paginaRedirecionamento = 'servicos_agendamentos_listar.php'; 
        }
        
        $('#status-message-area').html('<div class="alert alert-info text-center"><i class="fas fa-spinner fa-spin me-2"></i> Enviando dados...</div>');

        $.ajax({
            type: 'POST',
            url: url,
            data: dados,
            dataType: 'json', 
            success: function(response) {
                
                if (response.success === true) { 
                    $('#status-message-area').html('<div class="alert alert-success">' + response.message + '</div>');
                    form[0].reset();
                    
                    setTimeout(function() { 
                        // Carrega a página de listagem após o sucesso
                        carregarConteudo(paginaRedirecionamento);
                    }, 2000); 

                } else {
                    $('#status-message-area').html('<div class="alert alert-danger">' + response.message + '</div>');
                }
            },
            error: function(xhr, status, error) {
                $('#status-message-area').html('<div class="alert alert-danger">Erro de comunicação ou resposta inválida. Status: ' + xhr.status + '</div>');
                console.error("Erro no AJAX de Envio:", xhr.responseText);
            }
        });
    });

    // 3. LÓGICA DE BUSCA RÁPIDA DE CLIENTES (AGORA DELEGADA PARA clientes_listar.php)
    $(document).on('submit', '#form-busca-cliente-rapida', function(e) {
        e.preventDefault(); 
        
        var form = $(this);
        var dados = form.serialize(); 
        var resultadoArea = $('#resultado-busca-rapida'); 

        resultadoArea.html('<div class="text-center mt-3"><i class="fas fa-spinner fa-spin me-2 text-primary"></i> Buscando...</div>');

        $.ajax({
            type: 'GET', 
            url: 'clientes_buscar_rapido.php', 
            data: dados,
            dataType: 'html', 
            success: function(data) {
                resultadoArea.html(data);
            },
            error: function(xhr, status, error) {
                resultadoArea.html('<div class="alert alert-danger mt-3">Erro ao buscar clientes. Status: ' + xhr.status + '</div>');
                console.error("Erro no AJAX de Busca:", xhr.responseText);
            }
        });
    });

    // CARREGAMENTO INICIAL
    carregarConteudo('home.php'); 
});
</script>

</body>
</html>