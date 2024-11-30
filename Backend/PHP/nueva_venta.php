<?php
header('Content-Type: application/json');

$host = "localhost";
$user = "C##usuario";
$password = "123";
$service_name = "xe";
$connection_string = "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$host)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=$service_name)))";

$conexion = oci_connect($user, $password, $connection_string);

if (!$conexion) {
    $e = oci_error();
    echo json_encode(['error' => 'Error al conectar con la base de datos: ' . $e['message']]);
    exit;
}

$input = file_get_contents("php://input");
$data = json_decode($input, true);

if (!$data || !isset($data['productos'], $data['id_cliente'])) {
    echo json_encode(['error' => 'Datos inválidos recibidos.']);
    exit;
}

$id_cliente = $data['id_cliente'];
$productos = $data['productos'];

try {
    // Iniciar transacción
    oci_execute(oci_parse($conexion, 'BEGIN;'));

    // Insertar la venta
    $stmt = oci_parse($conexion, "begin JRSG_Pro_Crear_Venta(:id_cliente, sysdate); end;");
    oci_bind_by_name($stmt, ':id_cliente', $id_cliente);
    
    if (!oci_execute($stmt)) {
        throw new Exception('Error al insertar la venta: ' . oci_error($stmt)['message']);
    }

    // Insertar los detalles de la venta
    foreach ($productos as $producto) {
        $stmt_detalle = oci_parse($conexion, "begin JRSG_Pro_Crear_Detalle_Venta_Producto(:id_producto, :cantidad); end;");
        oci_bind_by_name($stmt_detalle, ':id_producto', $producto['cod_producto']);
        oci_bind_by_name($stmt_detalle, ':id_venta', $id_venta);
        oci_bind_by_name($stmt_detalle, ':cantidad', $producto['cantidad']);

        if (!oci_execute($stmt_detalle)) {
            throw new Exception('Error al insertar detalle de venta: ' . oci_error($stmt_detalle)['message']);
        }
    }

    // Confirmar transacción
    oci_commit($conexion);

    // Respuesta exitosa
    echo json_encode(['success' => true, 'message' => 'Venta registrada correctamente']);
} catch (Exception $e) {
    // Manejar errores
    if (oci_in_transaction($conexion)) {
        oci_rollback($conexion);
    }

    echo json_encode(['success' => false, 'message' => 'Error: ' . $e->getMessage()]);
}

// Cerrar conexión
oci_close($conexion);
?>
