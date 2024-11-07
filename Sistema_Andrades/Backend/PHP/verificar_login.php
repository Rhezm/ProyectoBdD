<?php
// Establecer los parámetros de la conexión a Oracle
$usuario = 'BD_Comercial_Andrades1';
$clave = 'comercial123';
$host = 'localhost';
$puerto = '1521';
$servicio = 'tu_servicio';

// Conexión a la base de datos Oracle
$conn = oci_connect($usuario, $clave, "//{$host}:{$puerto}/{$servicio}");

if (!$conn) {
    $error = oci_error();
    echo "Error de conexión: " . $error['message'];
    exit;
}

// Obtener los datos del formulario
$rut = $_POST['rut'];
$password = $_POST['password'];

// Preparar la consulta para verificar las credenciales
$query = 'SELECT * FROM usuarios WHERE rut = :rut AND password = :password';
$stid = oci_parse($conn, $query);

// Vincular los parámetros
oci_bind_by_name($stid, ":rut", $rut);
oci_bind_by_name($stid, ":password", $password);

// Ejecutar la consulta
oci_execute($stid);

// Verificar si la consulta devuelve resultados
if ($row = oci_fetch_assoc($stid)) {
    echo "Bienvenido, " . $row['NOMBRE']; // Muestra el nombre del usuario
} else {
    echo "Credenciales incorrectas.";
}

// Cerrar la conexión
oci_free_statement($stid);
oci_close($conn);
?>
