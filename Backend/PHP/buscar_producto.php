<?php
$host = "localhost";
$user = "C##usuario";
$password = "123";
$service_name = "xe";
$connection_string = "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$host)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=$service_name)))";

$conn = oci_connect($user, $password, $connection_string);
if (!$conn) {
    echo json_encode(array("error" => oci_error()));
    exit;
}

$searchTerm = strtoupper($_GET['term']); // Convertir el término a mayúsculas para comparación insensible

$query = "SELECT id_producto, nombre_producto, precio, stock 
          FROM JRSG_PRODUCTO 
          WHERE REGEXP_LIKE(nombre_producto, '^' || :term || '.*', 'i')";

$stid = oci_parse($conn, $query);
oci_bind_by_name($stid, ":term", $searchTerm);
oci_execute($stid);

$productos = array();
while (($row = oci_fetch_array($stid, OCI_ASSOC)) != false) {
    $productos[] = $row;
}

oci_free_statement($stid);
oci_close($conn);

echo json_encode($productos);
?>
