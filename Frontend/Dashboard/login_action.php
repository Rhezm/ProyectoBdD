<?php
session_start();
header('Content-Type: application/json');

$host = "localhost";
$user = "C##usuario";
$password = "123";
$service_name = "XE";
$connection_string = "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$host)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=$service_name)))";

// Conexión a la base de datos
$conn = oci_connect($user, $password, $connection_string, 'AL32UTF8');
if (!$conn) {
    echo json_encode(['success' => false, 'message' => 'Error de conexión: ' . oci_error()]);
    exit;
}

$id_empleado = str_replace(array('.', '-'), '', $_POST['id_empleado']);
$password = $_POST['password'];

$query = "SELECT id_empleado FROM jrsg_empleado WHERE id_empleado = :id_empleado AND contrasena = :contrasena";
$stid = oci_parse($conn, $query);

oci_bind_by_name($stid, ':id_empleado', $id_empleado);
oci_bind_by_name($stid, ':contrasena', $password);
if (!oci_execute($stid)) {
    echo json_encode(['success' => false, 'message' => 'Error al ejecutar la consulta.']);
    exit;
}

$row = oci_fetch_array($stid, OCI_ASSOC);

if ($row) {
    $_SESSION['loggedin'] = true;
    $_SESSION['id_empleado'] = $row['ID_EMPLEADO'];

    if ($row['ID_EMPLEADO'] == '1') {
        $_SESSION['tipo_usuario'] = 'dueño';
    } else {
        $_SESSION['tipo_usuario'] = 'empleado';
    }

    echo json_encode(['success' => true]);
} else {
    echo json_encode(['success' => false, 'message' => 'ID de empleado o contraseña incorrectos.']);
}

oci_free_statement($stid);
oci_close($conn);
?>
