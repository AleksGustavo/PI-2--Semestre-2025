<?php
// Define que a resposta será JSON
header('Content-Type: application/json');

// Inicia a sessão (necessário para acesso seguro, embora não usado diretamente aqui)
session_start(); 

// Verifica se o método é POST
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['success' => false, 'message' => 'Método de requisição inválido.']);
    exit();
}

// Inclui a conexão com o banco de dados
require_once 'conexao.php'; // Certifique-se de que este arquivo existe e conecta

// --- 1. Coletar e Validar Dados ---
$pet_id = filter_input(INPUT_POST, 'pet_id', FILTER_VALIDATE_INT);
$servico_id = filter_input(INPUT_POST, 'servico_id', FILTER_VALIDATE_INT);
$data_agendamento = filter_input(INPUT_POST, 'data_agendamento', FILTER_SANITIZE_STRING);
$funcionario_id = filter_input(INPUT_POST, 'funcionario_id', FILTER_VALIDATE_INT);
$observacoes = filter_input(INPUT_POST, 'observacoes', FILTER_SANITIZE_STRING);

// Verifica campos obrigatórios
if (!$pet_id || !$servico_id || !$data_agendamento) {
    echo json_encode(['success' => false, 'message' => 'Campos obrigatórios (Pet, Serviço e Data/Hora) não preenchidos ou inválidos.']);
    mysqli_close($conexao);
    exit();
}

// Trata o funcionário (pode ser NULL)
$funcionario_id_db = $funcionario_id ?: NULL; 

// --- 2. Inserção no Banco de Dados (Prepared Statement) ---

// Status inicial 'agendado'
$status = 'agendado';

$sql = "INSERT INTO agendamentos (pet_id, servico_id, funcionario_id, data_agendamento, status, observacoes) 
        VALUES (?, ?, ?, ?, ?, ?)";

$stmt = mysqli_prepare($conexao, $sql);

// Bind dos parâmetros: 'i' para int, 's' para string. 'i' para funcionario_id pode ser null
// Se for NULL, o MySQL aceitará se o parâmetro for passado como NULL. 
// No bind_param, 'i' funciona para NULL em mysqli.
$tipos = "iisisss"; // i=int, s=string. (pet_id, servico_id, funcionario_id, data_agendamento, status, observacoes)
// Se funcionario_id for nulo, precisamos de uma variável auxiliar, pois bind_param não aceita NULL diretamente

$funcionario_id_to_bind = $funcionario_id_db;
if ($funcionario_id_to_bind === NULL) {
    // Se for NULL, passamos 0 e deixamos o SQL tratar o NULL. 
    // Como o campo é NULLABLE no BD, o 0 será tratado como int, mas o prepared statement
    // pode ser mais flexível, dependendo da configuração. Vamos manter o tipo 'i'.
    $tipos = "iisis"; // Remoção do funcionário para simplificar o bind no caso NULL, inserindo diretamente no SQL.

    $sql = "INSERT INTO agendamentos (pet_id, servico_id, data_agendamento, status, observacoes) 
        VALUES (?, ?, ?, ?, ?)";
    $stmt = mysqli_prepare($conexao, $sql);
    
    // Bind sem funcionario_id
    mysqli_stmt_bind_param($stmt, $tipos, $pet_id, $servico_id, $data_agendamento, $status, $observacoes);

} else {
    $tipos = "iiisss";
    $sql = "INSERT INTO agendamentos (pet_id, servico_id, funcionario_id, data_agendamento, status, observacoes) 
        VALUES (?, ?, ?, ?, ?, ?)";
    $stmt = mysqli_prepare($conexao, $sql);
    
    // Bind com funcionario_id
    mysqli_stmt_bind_param($stmt, $tipos, $pet_id, $servico_id, $funcionario_id_to_bind, $data_agendamento, $status, $observacoes);
}


if (mysqli_stmt_execute($stmt)) {
    // Sucesso
    echo json_encode(['success' => true, 'message' => 'Agendamento para o Pet ID ' . $pet_id . ' realizado com sucesso!']);
} else {
    // Erro na execução
    echo json_encode(['success' => false, 'message' => 'Erro ao agendar: ' . mysqli_error($conexao)]);
}

mysqli_stmt_close($stmt);
mysqli_close($conexao);

exit();
?>