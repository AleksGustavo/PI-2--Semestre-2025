<?php

$servidor = "localhost"; 
$banco = "petepet";
$usuario = "root";       
$senha = "";             
 
try {
   
    $pdo = new PDO("mysql:host=$servidor;dbname=$banco;charset=utf8", $usuario, $senha);
    
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
   
} catch (PDOException $e) {
    die("Erro de conexão: " . $e->getMessage());
}

?>