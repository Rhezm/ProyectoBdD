<?php

// Configuración de la base de datos
$host = "localhost";
$user = "C##usuario";
$password = "123";
$service_name = "XE";
$connection_string = "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$host)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=$service_name)))";

// Conexión a la base de datos
$conn = oci_connect($user, $password, $connection_string, 'AL32UTF8');
if (!$conn) {
    echo "Error de conexión: " . oci_error();
    exit;
}

// Determinar la acción a realizar
$action = $_POST['action'];

switch ($action) {
    case 'obtener':
        obtenerClientes($conn);
        break;
    case 'guardar':
        guardarCliente($conn);
        break;
    case 'actualizar':
        actualizarCliente($conn);
        break;
    case 'eliminar':
        eliminarCliente($conn);
        break;
    default:
        echo "Acción no válida.";
        break;
}

oci_close($conn);

// Función para obtener clientes
function obtenerClientes($conn) {
    $query = "SELECT id_cliente, nombre_cliente, apellido1_cliente, apellido2_cliente, telefono_cliente, email_cliente
              FROM jrsg_cliente
              ORDER BY id_cliente";
    $stid = oci_parse($conn, $query);
    oci_execute($stid);

    $filas = '';
    while (($row = oci_fetch_array($stid, OCI_ASSOC)) != false) {
        $filas .= "<tr>
                    <td class='id_cliente'>{$row['ID_CLIENTE']}</td>
                    <td class='nombre_cliente'>{$row['NOMBRE_CLIENTE']}</td>
                    <td class='apellido1_cliente'>{$row['APELLIDO1_CLIENTE']}</td>
                    <td class='apellido2_cliente'>{$row['APELLIDO2_CLIENTE']}</td>
                    <td class='telefono_cliente'>{$row['TELEFONO_CLIENTE']}</td>
                    <td class='email_cliente'>{$row['EMAIL_CLIENTE']}</td>
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

// Función para guardar un cliente
function guardarCliente($conn) {
    $id_cliente = $_POST['id_cliente'];
    $nombre_cliente = ucfirst(strtolower($_POST['nombre_cliente']));
    $apellido1_cliente = ucfirst(strtolower($_POST['apellido1_cliente']));
    $apellido2_cliente = ucfirst(strtolower($_POST['apellido2_cliente']));
    $telefono_cliente = $_POST['telefono_cliente'];
    $email_cliente = $_POST['email_cliente'];

    $query = "INSERT INTO jrsg_cliente(id_cliente, nombre_cliente, apellido1_cliente, apellido2_cliente, telefono_cliente, email_cliente)
              VALUES (:id_cliente, :nombre_cliente, :apellido1_cliente, :apellido2_cliente, :telefono_cliente, :email_cliente)";
    $stid = oci_parse($conn, $query);

    oci_bind_by_name($stid, ':id_cliente', $id_cliente);
    oci_bind_by_name($stid, ':nombre_cliente', $nombre_cliente);
    oci_bind_by_name($stid, ':apellido1_cliente', $apellido1_cliente);
    oci_bind_by_name($stid, ':apellido2_cliente', $apellido2_cliente);
    oci_bind_by_name($stid, ':telefono_cliente', $telefono_cliente);
    oci_bind_by_name($stid, ':email_cliente', $email_cliente);

    @oci_execute($stid);
    if ($error = oci_error($stid)) {
        if ($error['code'] == 1) {
            echo "Error: El ID de cliente ya existe. Por favor, use un ID diferente.";
        } else {
            echo "Error al guardar el cliente: " . $error['message'];
        }
    } else {
        echo "Cliente guardado exitosamente.";
    }


    oci_free_statement($stid);
}

// Función para actualizar un cliente
function actualizarCliente($conn) {
    $id_cliente = $_POST['id_cliente'];
    $nombre_cliente = ucfirst(strtolower($_POST['nombre_cliente']));
    $apellido1_cliente = ucfirst(strtolower($_POST['apellido1_cliente']));
    $apellido2_cliente = ucfirst(strtolower($_POST['apellido2_cliente']));
    $telefono_cliente = $_POST['telefono_cliente'];
    $email_cliente = $_POST['email_cliente'];

    $query = "UPDATE jrsg_cliente 
                SET (nombre_cliente = :nombre_cliente, apellido1_cliente = :apellido1_cliente, 
                        apellido2_cliente = :apellido2_cliente, telefono_cliente = :telefono_cliente, 
                        email_cliente = :email_cliente)
            WHERE id_cliente = :id_cliente";
    $stid = oci_parse($conn, $query);

    oci_bind_by_name($stid, ':id_cliente', $id_cliente);
    oci_bind_by_name($stid, ':nombre_cliente', $nombre_cliente);
    oci_bind_by_name($stid, ':apellido1_cliente', $apellido1_cliente);
    oci_bind_by_name($stid, ':apellido2_cliente', $apellido2_cliente);
    oci_bind_by_name($stid, ':telefono_cliente', $telefono_cliente);
    oci_bind_by_name($stid, ':email_cliente', $email_cliente);

    if (oci_execute($stid)) {
        echo "Cliente actualizado exitosamente.";
    } else {
        $e = oci_error($stid);
        echo "Error al actualizar el cliente: " . $e['message'];
    }

    oci_free_statement($stid);
}

// Función para eliminar un cliente
function eliminarCliente($conn) {
    $id_cliente = $_POST['id_cliente'];

    $query = "DELETE FROM jrsg_cliente 
                WHERE id_cliente = :id_cliente";
    $stid = oci_parse($conn, $query);

    oci_bind_by_name($stid, ':id_cliente', $id_cliente);

    if (oci_execute($stid)) {
        echo "Cliente eliminado exitosamente.";
    } else {
        $e = oci_error($stid);
        echo "Error al eliminar el cliente: " . $e['message'];
    }

    oci_free_statement($stid);
}
?>
