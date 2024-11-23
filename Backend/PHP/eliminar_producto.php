<?php
// Configuración de la base de datos
$host = "localhost";
$user = "C##usuario";
$password = "123";
$service_name = "xe";
$connection_string = "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$host)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=$service_name)))";

// Conexión a la base de datos
$conn = oci_connect($user, $password, $connection_string);
if (!$conn) {
    echo "Error de conexión: " . oci_error();
    exit;
}

// Obtener el ID del producto a eliminar
$id_producto = $_POST['id_producto'];

// Preparar la consulta de eliminación
$query = "DELETE FROM JRSG_PRODUCTO WHERE id_producto = :id_producto";
$stid = oci_parse($conn, $query);

// Vincular los parámetros
oci_bind_by_name($stid, ':id_producto', $id_producto);

// Ejecutar la consulta
if (oci_execute($stid)) {
    echo "Producto eliminado exitosamente.";
} else {
    $e = oci_error($stid);
    echo "Error al eliminar el producto: " . $e['message'];
}

// Cerrar la conexión a la base de datos
oci_free_statement($stid);
oci_close($conn);
?>
