<?php

// 1. Configura o cabeçalho para JSON
header('Content-Type: application/json');

session_start();
require_once 'conexao.php'; // Inclui a conexão PDO ($pdo)

$response = [
    'success' => false,
    'message' => 'Erro desconhecido.'
];

// 2. Verifica a conexão e o método
if (!isset($pdo)) {
    $response['message'] = "Erro crítico: Falha na conexão com o banco de dados.";
    goto final_json;
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    $response['message'] = "Método de requisição inválido.";
    goto final_json;
}

try {
    // 3. Coleta e sanitiza dados do POST
    $nome = trim($_POST['nome'] ?? '');
    $descricao = trim($_POST['descricao'] ?? '');
    $categoria_id = (int)($_POST['categoria_id'] ?? 0);
    $fornecedor_padrao_id = !empty($_POST['fornecedor_padrao_id']) ? (int)$_POST['fornecedor_padrao_id'] : null;
    
    // Tratamento de valores decimais
    $preco_custo = filter_var($_POST['preco_custo'] ?? '0', FILTER_SANITIZE_NUMBER_FLOAT, FILTER_FLAG_ALLOW_FRACTION);
    $preco_venda = filter_var($_POST['preco_venda'] ?? '0', FILTER_SANITIZE_NUMBER_FLOAT, FILTER_FLAG_ALLOW_FRACTION);
    
    // Tratamento de valores inteiros
    $quantidade_estoque = (int)($_POST['quantidade_estoque'] ?? 0);
    $estoque_minimo = (int)($_POST['estoque_minimo'] ?? 5);
    $codigo_barras = trim($_POST['codigo_barras'] ?? '');

    // 4. Validação
    if (empty($nome) || $categoria_id <= 0 || $preco_venda <= 0) {
        $response['message'] = "Os campos Nome, Categoria e Preço de Venda são obrigatórios.";
        goto final_json;
    }
    
    // 5. Inserção no Banco de Dados (PDO e Prepared Statement)
    $sql = "INSERT INTO produto (nome, descricao, categoria_id, fornecedor_padrao_id, preco_custo, preco_venda, quantidade_estoque, estoque_minimo, codigo_barras, ativo) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 1)";
            
    $stmt = $pdo->prepare($sql);
    
    $stmt->execute([
        $nome, 
        $descricao ?: null, // Permite NULL
        $categoria_id, 
        $fornecedor_padrao_id,
        $preco_custo ?: null,
        $preco_venda,
        $quantidade_estoque,
        $estoque_minimo,
        $codigo_barras ?: null // Permite NULL
    ]);

    $response['success'] = true;
    $response['message'] = "Produto **" . htmlspecialchars($nome) . "** cadastrado com sucesso!";

} catch (\PDOException $e) {
    // 6. Trata erros do banco de dados (Ex: Chave estrangeira, violação de NOT NULL)
    
    // Em caso de erro de Foreign Key (ex: categoria_id não existe)
    if ($e->getCode() == '23000' || strpos($e->getMessage(), 'foreign key') !== false) {
        $response['message'] = "Erro de BD: A Categoria ou Fornecedor selecionado não é válido. Verifique se os dados auxiliares estão corretos.";
    } else {
        $response['message'] = "Erro de BD inesperado. Detalhes: " . $e->getMessage();
    }
}


// 7. Bloco de saída JSON final
final_json:
echo json_encode($response);
exit();