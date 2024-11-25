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

// Determinar la acción a realizar
$action = $_POST['action'];

switch ($action) {
    case 'obtener':
        obtenerProductos($conn);
        break;
    case 'guardar':
        guardarProducto($conn);
        break;
    case 'actualizar':
        actualizarProducto($conn);
        break;
    case 'eliminar':
        eliminarProducto($conn);
        break;
    default:
        echo "Acción no válida.";
        break;
}

oci_close($conn);

// Función para obtener productos
function obtenerProductos($conn) {
    $query = "SELECT id_producto, id_categoria, id_promocion, nombre_producto, descripcion_producto, precio, precio_descuento, stock FROM JRSG_PRODUCTO";
    $stid = oci_parse($conn, $query);
    oci_execute($stid);

    $filas = '';
    while (($row = oci_fetch_array($stid, OCI_ASSOC)) != false) {
        $id_promocion = isset($row['ID_PROMOCION']) ? $row['ID_PROMOCION'] : '';
        $precio_descuento = isset($row['PRECIO_DESCUENTO']) ? $row['PRECIO_DESCUENTO'] : '';
        $filas .= "<tr>
                    <td class='id_producto'>{$row['ID_PRODUCTO']}</td>
                    <td class='id_categoria'>{$row['ID_CATEGORIA']}</td>
                    <td class='id_promocion'>{$id_promocion}</td>
                    <td class='nombre_producto'>{$row['NOMBRE_PRODUCTO']}</td>
                    <td class='descripcion_producto'>{$row['DESCRIPCION_PRODUCTO']}</td>
                    <td class='precio'>{$row['PRECIO']}</td>
                    <td class='precio_descuento'>{$precio_descuento}</td>
                    <td class='stock'>{$row['STOCK']}</td>
                    <td>
                        <span class='accion-icono editar' title='Editar'>&#9998;</span>
                        <span class='accion-icono guardar' title='Guardar' style='display:none;'>&#128190;</span>
                        <span class='accion-icono eliminar' title='Eliminar'>&#128465;</span>
                    </td>
                   </tr>";
    }
    oci_free_statement($stid);
    echo $filas;
}

// Función para guardar un producto
function guardarProducto($conn) {
    $id_producto = $_POST['id_producto'];
    $id_categoria = $_POST['id_categoria'];
    $id_promocion = !empty($_POST['id_promocion']) ? $_POST['id_promocion'] : NULL;
    $nombre_producto = ucfirst(strtolower($_POST['nombre_producto']));
    $descripcion_producto = ucfirst(strtolower($_POST['descripcion_producto']));
    $precio = $_POST['precio'];
    $precio_descuento = !empty($_POST['precio_descuento']) ? $_POST['precio_descuento'] : NULL;
    $stock = $_POST['stock'];

    $query = "INSERT INTO JRSG_PRODUCTO (id_producto, id_categoria, id_promocion, nombre_producto, descripcion_producto, precio, precio_descuento, stock)
              VALUES (:id_producto, :id_categoria, :id_promocion, :nombre_producto, :descripcion_producto, :precio, :precio_descuento, :stock)";
    $stid = oci_parse($conn, $query);

    oci_bind_by_name($stid, ':id_producto', $id_producto);
    oci_bind_by_name($stid, ':id_categoria', $id_categoria);
    oci_bind_by_name($stid, ':id_promocion', $id_promocion);
    oci_bind_by_name($stid, ':nombre_producto', $nombre_producto);
    oci_bind_by_name($stid, ':descripcion_producto', $descripcion_producto);
    oci_bind_by_name($stid, ':precio', $precio);
    oci_bind_by_name($stid, ':precio_descuento', $precio_descuento);
    oci_bind_by_name($stid, ':stock', $stock);

    if (oci_execute($stid)) {
        echo "Producto guardado exitosamente.";
    } else {
        $e = oci_error($stid);
        echo "Error al guardar el producto: " . $e['message'];
    }

    oci_free_statement($stid);
}

// Función para actualizar un producto
function actualizarProducto($conn) {
    $id_producto = $_POST['id_producto'];
    $id_categoria = $_POST['id_categoria'];
    $id_promocion = !empty($_POST['id_promocion']) ? $_POST['id_promocion'] : NULL;
    $nombre_producto = ucfirst(strtolower($_POST['nombre_producto']));
    $descripcion_producto = ucfirst(strtolower($_POST['descripcion_producto']));
    $precio = $_POST['precio'];
    $precio_descuento = !empty($_POST['precio_descuento']) ? $_POST['precio_descuento'] : NULL;
    $stock = $_POST['stock'];

    $query = "UPDATE JRSG_PRODUCTO SET id_categoria = :id_categoria, id_promocion = :id_promocion, nombre_producto = :nombre_producto, descripcion_producto = :descripcion_producto, precio = :precio, precio_descuento = :precio_descuento, stock = :stock WHERE id_producto = :id_producto";
    $stid = oci_parse($conn, $query);

    oci_bind_by_name($stid, ':id_producto', $id_producto);
    oci_bind_by_name($stid, ':id_categoria', $id_categoria);
    oci_bind_by_name($stid, ':id_promocion', $id_promocion);
    oci_bind_by_name($stid, ':nombre_producto', $nombre_producto);
    oci_bind_by_name($stid, ':descripcion_producto', $descripcion_producto);
    oci_bind_by_name($stid, ':precio', $precio);
    oci_bind_by_name($stid, ':precio_descuento', $precio_descuento);
    oci_bind_by_name($stid, ':stock', $stock);

    if (oci_execute($stid)) {
        echo "Producto actualizado exitosamente.";
    } else {
        $e = oci_error($stid);
        echo "Error al actualizar el producto: " . $e['message'];
    }

    oci_free_statement($stid);
}

// Función para eliminar un producto
function eliminarProducto($conn) {
    $id_producto = $_POST['id_producto'];

    $query = "DELETE FROM JRSG_PRODUCTO WHERE id_producto = :id_producto";
    $stid = oci_parse($conn, $query);

    oci_bind_by_name($stid, ':id_producto', $id_producto);

    if (oci_execute($stid)) {
        echo "Producto eliminado exitosamente.";
    } else {
        $e = oci_error($stid);
        echo "Error al eliminar el producto: " . $e['message'];
    }

    oci_free_statement($stid);
}
?>
