<?php
// Inclui o arquivo de conexão e verifica a sessão, se necessário (boa prática)
require_once 'conexao.php'; 

// --- 1. Busca de Dados Necessários ---

// A. Buscar todos os PETs (para o dropdown)
$sql_pets = "SELECT p.id, p.nome, c.nome AS nome_cliente 
             FROM pet p
             JOIN clientes c ON p.cliente_id = c.id
             WHERE p.ativo = 1
             ORDER BY p.nome ASC";
$result_pets = mysqli_query($conexao, $sql_pets);
$pets = mysqli_fetch_all($result_pets, MYSQLI_ASSOC);

// B. Buscar Serviços de Banho/Tosa E VACINA
// IDs: 1, 2, 3 (Banho/Tosa) E 6 (Vacina) <--- ATENÇÃO: Confirme o ID 6 para Vacina na sua tabela!
$sql_servicos = "SELECT id, nome, preco FROM servicos WHERE id IN (1, 2, 3, 6) AND ativo = 1 ORDER BY nome ASC"; 
$result_servicos = mysqli_query($conexao, $sql_servicos);
$servicos = mysqli_fetch_all($result_servicos, MYSQLI_ASSOC);

// C. Buscar Funcionários (para o agendamento)
$sql_funcionarios = "SELECT f.id, f.nome
                     FROM funcionarios f
                     JOIN usuarios u ON f.usuario_id = u.id
                     WHERE u.ativo = 1 
                     ORDER BY f.nome ASC";
$result_funcionarios = mysqli_query($conexao, $sql_funcionarios);
$funcionarios = mysqli_fetch_all($result_funcionarios, MYSQLI_ASSOC);

mysqli_close($conexao);
?>

<div class="container mt-4">
    <div class="row">
        <div class="col-md-10 offset-md-1">
            <h2 class="mb-4"><i class="fas fa-calendar-check me-2"></i> Agendar Serviços (Banho, Tosa e Vacinas)</h2>
            
            <div id="status-message-area"></div>

            <div class="card shadow">
                <div class="card-body">
                    <form id="form-agendar-servico" action="servicos_processar_agendamento.php" method="POST">
                        
                        <div class="mb-3">
                            <label for="pet_id" class="form-label">Pet a ser Agendado *</label>
                            <select class="form-select" id="pet_id" name="pet_id" required>
                                <option value="" disabled selected>Selecione o Pet (e seu Cliente)</option>
                                <?php foreach ($pets as $pet): ?>
                                    <option value="<?php echo htmlspecialchars($pet['id']); ?>">
                                        <?php echo htmlspecialchars($pet['nome']); ?> (Dono: <?php echo htmlspecialchars($pet['nome_cliente']); ?>)
                                    </option>
                                <?php endforeach; ?>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label for="servico_id" class="form-label">Serviço *</label>
                            <select class="form-select" id="servico_id" name="servico_id" required>
                                <option value="" disabled selected>Selecione o Serviço</option>
                                <?php foreach ($servicos as $servico): ?>
                                    <option value="<?php echo htmlspecialchars($servico['id']); ?>" data-preco="<?php echo htmlspecialchars($servico['preco']); ?>">
                                        <?php echo htmlspecialchars($servico['nome']); ?> (R$ <?php echo number_format($servico['preco'], 2, ',', '.'); ?>)
                                    </option>
                                <?php endforeach; ?>
                            </select>
                        </div>
                        
                        <div class="mb-3">
                            <label for="data_agendamento" class="form-label">Data e Hora *</label>
                            <input type="datetime-local" class="form-control" id="data_agendamento" name="data_agendamento" required
                                min="<?php echo date('Y-m-d\TH:i'); ?>" > 
                            <div class="form-text">Escolha a data e o horário para o serviço.</div>
                        </div>

                        <div class="mb-3">
                            <label for="funcionario_id" class="form-label">Funcionário Responsável (Opcional)</label>
                            <select class="form-select" id="funcionario_id" name="funcionario_id">
                                <option value="">Nenhum Funcionário Atribuído</option>
                                <?php foreach ($funcionarios as $funcionario): ?>
                                    <option value="<?php echo htmlspecialchars($funcionario['id']); ?>">
                                        <?php echo htmlspecialchars($funcionario['nome']); ?>
                                    </option>
                                <?php endforeach; ?>
                            </select>
                        </div>
                        
                        <div class="mb-3">
                            <label for="observacoes" class="form-label">Observações</label>
                            <textarea class="form-control" id="observacoes" name="observacoes" rows="3"></textarea>
                        </div>

                        <button type="submit" class="btn btn-success"><i class="fas fa-check-circle me-2"></i> Confirmar Agendamento</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>