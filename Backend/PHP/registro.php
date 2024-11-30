<?php
$host = "localhost";
$user = "C##usuario";
$password = "123";
$service_name = "xe";
$connection_string = "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$host)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=$service_name)))";

$conn = oci_connect($user, $password, $connection_string);
if (!$conn) {
    $e = oci_error();
    echo "Error de conexión: " . $e['message'];
    exit;
}

$stid = oci_parse($conn, "BEGIN jrsg_pro_registro_ventas(:p_cursor); END;");
$cursor = oci_new_cursor($conn);
oci_bind_by_name($stid, ":p_cursor", $cursor, -1, OCI_B_CURSOR);
oci_execute($stid);
oci_execute($cursor);

$ventas = [];
while (($row = oci_fetch_array($cursor, OCI_ASSOC + OCI_RETURN_NULLS)) != false) {
    $ventas[$row['A']][$row['AAAA']][] = $row;
}

oci_free_statement($stid);
oci_free_statement($cursor);
oci_close($conn);

$filas = '';
foreach ($ventas as $id_venta => $fechas) {
    $ventaPrimeraFila = true;
    foreach ($fechas as $fecha_venta => $productos) {
        $fechaRowspan = count($productos);
        $fechaPrimeraFila = true;
        foreach ($productos as $producto) {
            $filas .= '<tr>';
            if ($ventaPrimeraFila) {
                $filas .= '<td style="text-align: center"; class="id_venta" rowspan="' . array_sum(array_map('count', $fechas)) . '">' . $producto['A'] . '</td>';
                $ventaPrimeraFila = false;
            }
            $filas .= '<td class="nombre_producto">' . $producto['AA'] . '</td>';
            $filas .= '<td class="cantidad">' . $producto['AAA'] . '</td>';
            if ($fechaPrimeraFila) {
                $filas .= '<td style="text-align: center"; class="fecha_venta" rowspan="' . $fechaRowspan . '">' . $producto['AAAA'] . '</td>';
                $fechaPrimeraFila = false;
            }
            $filas .= '</tr>';
        }
    }
}

echo $filas;
?>
