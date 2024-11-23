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

// Consultar productos
$query = "SELECT id_producto, id_categoria, id_promocion, nombre_producto, descripcion_producto, precio, precio_descuento, stock FROM JRSG_PRODUCTO";
$stid = oci_parse($conn, $query);
oci_execute($stid);

// Generar filas de la tabla
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
oci_close($conn);

echo $filas;
?>
