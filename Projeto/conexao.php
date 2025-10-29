<?php
// Arquivo: conexao.php - Conexão Dupla (MySQLi para $conexao e PDO para $pdo)

// Configurações do Banco de Dados
$host = 'localhost:3306';
$user = 'root';
$pass = ''; // **ATENÇÃO: Insira a sua senha se houver!**
$banco = 'pet_e_pet_db'; 

// --- 1. CONEXÃO MySQLi (Variável: $conexao) ---
// Usada pelos scripts mais recentes.
$conexao = @mysqli_connect($host, $user, $pass, $banco);
if (!$conexao) {
    die("Erro crítico: Falha na conexão com o banco de dados."); 
}
mysqli_set_charset($conexao, "utf8mb4");


// --- 2. CONEXÃO PDO (Variável: $pdo) ---
// Adicionada para suportar scripts antigos como clientes_buscar_rapido.php.
$dsn = "mysql:host={$host};dbname={$banco};charset=utf8mb4";
$options = [
    PDO::ATTR_ERRMODE           => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE   => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES     => false,
];
try {
     $pdo = new PDO($dsn, $user, $pass, $options);
} catch (\PDOException $e) {
     // Apenas para que a variável exista se a conexão MySQLi funcionar, mas a PDO falhar.
     error_log("Falha na conexão PDO: " . $e->getMessage());
     $pdo = null; 
}