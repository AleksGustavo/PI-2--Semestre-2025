<?php
// Arquivo: servicos_agendamentos_cadastro.php - Formulário de Cadastro Condicional
require_once 'conexao.php'; 

// ==============================================================================
// 1. Configuração e Busca de Dados Essenciais
// ==============================================================================

// O ID que representa o serviço de Aplicação de Vacina
// IMPORTANTE: AJUSTE ESTE ID PARA O VALOR CORRETO DO SEU BANCO DE DADOS!
$ID_SERVICO_VACINA = 6; 

$servicos_db = [];
$tipos_vacina = ['V8/V10', 'Raiva', 'Gripe', 'Leishmaniose']; // Dados estáticos para exemplo

if (isset($conexao) && $conexao) {
    // Busca os serviços no banco de dados
    $sql_servicos = "SELECT id, nome FROM servicos WHERE ativo = 1 ORDER BY nome ASC";
    $result_servicos = mysqli_query($conexao, $sql_servicos);
    if ($result_servicos) {
        $servicos_db = mysqli_fetch_all($result_servicos, MYSQLI_ASSOC);
        mysqli_free_result($result_servicos);
    }
    
    // Fecha a conexão após a busca
    mysqli_close($conexao);
}
?>

<div class="container mt-4">
    <h2><i class="fas fa-calendar-plus me-2"></i> Novo Agendamento</h2>

    <form id="form-agendamento" action="agendamento_processar.php" method="POST">
        
        <div class="row mb-3">
            <div class="col-md-6">
                <label for="servico_id" class="form-label">Serviço <span class="text-danger">*</span></label>
                <select class="form-select" id="servico_id" name="servico_id" required>
                    <option value="">Selecione o Serviço</option>
                    <?php foreach ($servicos_db as $servico): ?>
                        <option value="<?php echo $servico['id']; ?>"><?php echo htmlspecialchars($servico['nome']); ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
        </div>

        <div id="bloco-servico-padrao" style="display: none;">
            <h5 class="mt-4 mb-3">Dados de Agendamento (Banho, Tosa, etc.)</h5>
            
            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="cliente_id_padrao" class="form-label">Cliente (Pesquisa)</label>
                    <input type="text" class="form-control" id="cliente_id_padrao" name="cliente_id" placeholder="Pesquisar Cliente...">
                </div>
                <div class="col-md-6">
                    <label for="pet_id_padrao" class="form-label">Pet</label>
                    <select class="form-select" id="pet_id_padrao" name="pet_id">
                        <option value="">Selecione o Pet</option>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="data_agendamento" class="form-label">Data e Hora</label>
                    <input type="datetime-local" class="form-control" id="data_agendamento" name="data_agendamento">
                </div>
            </div>

            <div class="mb-3">
                <label for="observacoes_padrao" class="form-label">Observações</label>
                <textarea class="form-control" id="observacoes_padrao" name="observacoes" rows="3"></textarea>
            </div>

            <button type="submit" class="btn btn-primary"><i class="fas fa-calendar-alt me-2"></i> Confirmar Agendamento</button>
        </div>

        <div id="bloco-vacina" style="display: none;">
            <h5 class="mt-4 mb-3 text-success">Registro de Vacina</h5>
            
            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="cliente_id_vacina" class="form-label">Cliente (Pesquisa)</label>
                    <input type="text" class="form-control" id="cliente_id_vacina" name="cliente_id_vacina" placeholder="Pesquisar Cliente...">
                </div>
                <div class="col-md-6">
                    <label for="pet_id_vacina" class="form-label">Pet</label>
                    <select class="form-select" id="pet_id_vacina" name="pet_id_vacina">
                        <option value="">Selecione o Pet</option>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                 <div class="col-md-4">
                    <label for="nome_vacina" class="form-label">Tipo de Vacina</label>
                    <select class="form-select" id="nome_vacina" name="nome_vacina">
                        <option value="">Selecione o Tipo</option>
                        <?php foreach ($tipos_vacina as $vacina): ?>
                            <option value="<?php echo $vacina; ?>"><?php echo htmlspecialchars($vacina); ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="col-md-4">
                    <label for="data_aplicacao" class="form-label">Data da Aplicação</label>
                    <input type="date" class="form-control" id="data_aplicacao" name="data_aplicacao" value="<?php echo date('Y-m-d'); ?>">
                </div>
                <div class="col-md-4">
                    <label for="data_proxima" class="form-label">Próxima Dose (Previsão)</label>
                    <input type="date" class="form-control" id="data_proxima" name="data_proxima">
                </div>
            </div>
            
            <div class="mb-3">
                <label for="veterinario" class="form-label">Veterinário Responsável</label>
                <input type="text" class="form-control" id="veterinario" name="veterinario" placeholder="Nome do Veterinário">
            </div>

            <div class="mb-3">
                <label for="observacoes_vacina" class="form-label">Observações da Vacina</label>
                <textarea class="form-control" id="observacoes_vacina" name="observacoes_vacina" rows="3"></textarea>
            </div>

            <button type="submit" class="btn btn-success"><i class="fas fa-syringe me-2"></i> Registrar na Carteira de Vacinas</button>
        </div>
    </form>
</div>

<script>
    $(document).ready(function() {
        const ID_SERVICO_VACINA = <?php echo $ID_SERVICO_VACINA; ?>; 
        const form = $("#form-agendamento");
        const blocoPadrao = $("#bloco-servico-padrao");
        const blocoVacina = $("#bloco-vacina");
        
        // Mapeamento de todos os campos com nomes de forma
        const allFields = form.find('input, select, textarea').filter('[name]');

        // Salva o nome original de cada campo para poder restaurar
        allFields.each(function() {
            if (!$(this).attr('data-original-name')) {
                 $(this).attr('data-original-name', $(this).attr('name'));
            }
        });

        function alternarBlocos(servicoId) {
            // Converte para número ou 0 se for vazio/nulo
            const id = parseInt(servicoId) || 0; 
            const isVacina = id == ID_SERVICO_VACINA;
            
            // 1. Esconde tudo primeiro
            blocoPadrao.slideUp(200);
            blocoVacina.slideUp(200);
            
            // 2. Remove o atributo 'name' de TODOS os campos (evita envio duplicado)
            allFields.attr('name', '');


            if (id === 0) {
                // Se nada for selecionado, apenas esconde e mantém o action padrão
                form.attr("action", "agendamento_processar.php");
                
            } else if (isVacina) {
                // Se for Vacina: Mostra o bloco de Vacina
                blocoVacina.slideDown(200);
                form.attr("action", "carteira_vacina_registrar.php"); 
                
                // Restaura o 'name' apenas para os campos de Vacina e o select do serviço
                blocoVacina.find('[data-original-name]').each(function() {
                    $(this).attr('name', $(this).attr('data-original-name'));
                });
                $('#servico_id').attr('name', 'servico_id');

            } else {
                // Se for outro serviço: Mostra o bloco padrão
                blocoPadrao.slideDown(200);
                form.attr("action", "agendamento_processar.php");
                
                // Restaura o 'name' apenas para os campos Padrões e o select do serviço
                blocoPadrao.find('[data-original-name]').each(function() {
                    $(this).attr('name', $(this).attr('data-original-name'));
                });
                 $('#servico_id').attr('name', 'servico_id');
            }
        }

        // Ouve o evento de mudança na seleção de serviço
        $("#servico_id").change(function() {
            const servicoSelecionado = $(this).val();
            alternarBlocos(servicoSelecionado);
        });

        // Executa na carga para garantir que tudo comece escondido e o nome do select esteja ativo
        alternarBlocos($("#servico_id").val());
    });
</script>