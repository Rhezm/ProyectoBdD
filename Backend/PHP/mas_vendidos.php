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
    $e = oci_error();
    echo "Error de conexión: " . $e['message'];
    exit;
}

// Llamar al procedimiento almacenado
$stid = oci_parse($conn, "BEGIN jrsg_pro_obtener_mas_vendidos(:p_cursor); END;");
$cursor = oci_new_cursor($conn);
oci_bind_by_name($stid, ":p_cursor", $cursor, -1, OCI_B_CURSOR);
oci_execute($stid);
oci_execute($cursor);

// Generar filas de la tabla
$filas = '';
while (($row = oci_fetch_array($cursor, OCI_ASSOC + OCI_RETURN_NULLS)) != false) {
    $filas .= "<tr> <td class='id_producto'>{$row['A']}</td> <td class='nombre_producto'>{$row['AA']}</td> <td class='total_vendido'>{$row['TOTAL_VENDIDO']}</td> </tr>";
}

oci_free_statement($stid);
oci_free_statement($cursor);
oci_close($conn);

echo $filas;
?>
