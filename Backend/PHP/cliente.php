<?php
session_start();
if (!isset($_SESSION['usuario_id'])) {
    header("Location: verificacion_login.php");
    exit();
}

// Establecer los parámetros de la conexión a Oracle
$usuario = 'C##usuario';
$clave = '123';
$host = 'localhost';
$puerto = '1521';
$servicio = 'XE';

// Conexión a la base de datos Oracle
$conn = oci_connect($usuario, $clave, "//{$host}:{$puerto}/{$servicio}");

if (!$conn) {
    $error = oci_error();
    echo "Error de conexión: " . $error['message'];
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $nombre = $_POST['nombre'];
    $apellido = $_POST['apellido'];
    $telefono = $_POST['telefono'];
    $email = $_POST['email'];

    // Insertar nuevo cliente en la base de datos
    $query = 'INSERT INTO jrsg_clientes (nombre_cliente, apellido1_cliente, apellido2_cliente, telefono_cliente, email_cliente)
                    VALUES (:nombre, :apellido1, :apellido2, :telefono, :email)';
    $stid = oci_parse($conn, $query);
    oci_bind_by_name($stid, ':id_empleado', $id_cliente);
    oci_bind_by_name($stid, ':nombre', $nombre_cliente);
    oci_bind_by_name($stid, ':apellido1', $apellido1_cliente);
    oci_bind_by_name($stid, ':apellido2', $apellido2_cliente);
    oci_bind_by_name($stid, ':telefono', $telefono_cliente);
    oci_bind_by_name($stid, ':email', $email_cliente);

    if (oci_execute($stid)) {
        echo "Cliente agregado exitosamente.";
    } else {
        $error = oci_error($stid);
        echo "Error al agregar el cliente: " . $error['message'];
    }

    oci_free_statement($stid);
}

// Obtener todos los clientes para mostrarlos en la tabla
$query = 'SELECT * FROM jrsg_clientes';
$stid = oci_parse($conn, $query);
oci_execute($stid);

$clientes = [];
while ($row = oci_fetch_assoc($stid)) {
    $clientes[] = $row;
}

oci_free_statement($stid);
oci_close($conn);
?>
