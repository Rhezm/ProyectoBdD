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

// Obtener datos del formulario
$id_producto = $_POST['id_producto'];
$id_categoria = $_POST['id_categoria'];
$id_promocion = !empty($_POST['id_promocion']) ? $_POST['id_promocion'] : NULL;
$nombre_producto = ucfirst(strtolower($_POST['nombre_producto']));
$descripcion_producto = ucfirst(strtolower($_POST['descripcion_producto']));
$precio = $_POST['precio'];
$precio_descuento = !empty($_POST['precio_descuento']) ? $_POST['precio_descuento'] : NULL;
$stock = $_POST['stock'];

// Preparar la consulta de actualización
$query = "UPDATE JRSG_PRODUCTO SET id_categoria = :id_categoria, id_promocion = :id_promocion, nombre_producto = :nombre_producto, descripcion_producto = :descripcion_producto, precio = :precio, precio_descuento = :precio_descuento, stock = :stock WHERE id_producto = :id_producto";
$stid = oci_parse($conn, $query);

// Vincular los parámetros
oci_bind_by_name($stid, ':id_producto', $id_producto);
oci_bind_by_name($stid, ':id_categoria', $id_categoria);
oci_bind_by_name($stid, ':id_promocion', $id_promocion);
oci_bind_by_name($stid, ':nombre_producto', $nombre_producto);
oci_bind_by_name($stid, ':descripcion_producto', $descripcion_producto);
oci_bind_by_name($stid, ':precio', $precio);
oci_bind_by_name($stid, ':precio_descuento', $precio_descuento);
oci_bind_by_name($stid, ':stock', $stock);

// Ejecutar la consulta
if (oci_execute($stid)) {
    echo "Producto actualizado exitosamente.";
} else {
    $e = oci_error($stid);
    echo "Error al actualizar el producto: " . $e['message'];
}

// Cerrar la conexión a la base de datos
oci_free_statement($stid);
oci_close($conn);
?>
