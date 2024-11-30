<?php

$host = "localhost";
$user = "C##usuario";
$password = "123";
$service_name = "XE";
$connection_string = "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$host)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=$service_name)))";

$conn = oci_connect($user, $password, $connection_string, 'AL32UTF8');
if (!$conn) {
    echo "Error de conexión: " . oci_error();
    exit;
}

$action = $_POST['action'];

switch ($action) {
    case 'obtener':
        obtenerEmpleados($conn);
        break;
    case 'guardar':
        guardarEmpleado($conn);
        break;
    case 'actualizar':
        actualizarEmpleado($conn);
        break;
    case 'eliminar':
        eliminarEmpleado($conn);
        break;
    default:
        echo "Acción no válida.";
        break;
}

oci_close($conn);

function obtenerEmpleados($conn) {
    $query = "SELECT *
              FROM jrsg_empleado
              ORDER BY id_empleado";
    $stid = oci_parse($conn, $query);
    oci_execute($stid);

    $filas = '';
    while (($row = oci_fetch_array($stid, OCI_ASSOC)) != false) {
        $filas .= "<tr>
                    <td class='id_empleado'>{$row['ID_EMPLEADO']}</td>
                    <td class='nombre_empleado'>{$row['NOMBRE_EMPLEADO']}</td>
                    <td class='apellido1_empleado'>{$row['APELLIDO1_EMPLEADO']}</td>
                    <td class='apellido2_empleado'>{$row['APELLIDO2_EMPLEADO']}</td>
                    <td class='telefono_empleado'>{$row['TELEFONO_EMPLEADO']}</td>
                    <td class='email_empleado'>{$row['EMAIL_EMPLEADO']}</td>
                    <td class='contrasena'>{$row['CONTRASENA']}</td>
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

function guardarEmpleado($conn) {
    $id_empleado = $_POST['id_empleado'];
    $nombre_empleado = ucfirst(strtolower($_POST['nombre_empleado']));
    $apellido1_empleado = ucfirst(strtolower($_POST['apellido1_empleado']));
    $apellido2_empleado = ucfirst(strtolower($_POST['apellido2_empleado']));
    $telefono_empleado = $_POST['telefono_empleado'];
    $email_empleado = $_POST['email_empleado'];
    $contrasena = $_POST['contrasena'];

    $query = "INSERT INTO jrsg_empleado(id_empleado, nombre_empleado, apellido1_empleado, apellido2_empleado, telefono_empleado, email_empleado, contrasena)
              VALUES (:id_empleado, :nombre_empleado, :apellido1_empleado, :apellido2_empleado, :telefono_empleado, :email_empleado, :contrasena)";
    $stid = oci_parse($conn, $query);

    oci_bind_by_name($stid, ':id_empleado', $id_empleado);
    oci_bind_by_name($stid, ':nombre_empleado', $nombre_empleado);
    oci_bind_by_name($stid, ':apellido1_empleado', $apellido1_empleado);
    oci_bind_by_name($stid, ':apellido2_empleado', $apellido2_empleado);
    oci_bind_by_name($stid, ':telefono_empleado', $telefono_empleado);
    oci_bind_by_name($stid, ':email_empleado', $email_empleado);
    oci_bind_by_name($stid, ':contrasena', $contrasena);

    @oci_execute($stid);
    if ($error = oci_error($stid)) {
        if ($error['code'] == 1) {
            echo "Error: El ID de empleado ya existe. Por favor, use un ID diferente.";
        } else {
            echo "Error al guardar el empleado: " . $error['message'];
        }
    } else {
        echo "Empleado guardado exitosamente.";
    }


    oci_free_statement($stid);
}

function actualizarEmpleado($conn) {
    $id_empleado = $_POST['id_empleado'];
    $nombre_empleado = ucfirst(strtolower($_POST['nombre_empleado']));
    $apellido1_empleado = ucfirst(strtolower($_POST['apellido1_empleado']));
    $apellido2_empleado = ucfirst(strtolower($_POST['apellido2_empleado']));
    $telefono_empleado = $_POST['telefono_empleado'];
    $email_empleado = $_POST['email_empleado'];
    $contrasena = $_POST['contrasena'];

    $query = "UPDATE jrsg_empleado 
                SET nombre_empleado = :nombre_empleado, apellido1_empleado = :apellido1_empleado, 
                        apellido2_empleado = :apellido2_empleado, telefono_empleado = :telefono_empleado, 
                        email_empleado = :email_empleado, contrasena = :contrasena
            WHERE id_empleado = :id_empleado";
    $stid = oci_parse($conn, $query);

    oci_bind_by_name($stid, ':id_empleado', $id_empleado);
    oci_bind_by_name($stid, ':nombre_empleado', $nombre_empleado);
    oci_bind_by_name($stid, ':apellido1_empleado', $apellido1_empleado);
    oci_bind_by_name($stid, ':apellido2_empleado', $apellido2_empleado);
    oci_bind_by_name($stid, ':telefono_empleado', $telefono_empleado);
    oci_bind_by_name($stid, ':email_empleado', $email_empleado);
    oci_bind_by_name($stid, ':contrasena', $contrasena);

    if (oci_execute($stid)) {
        echo "Empleado actualizado exitosamente.";
    } else {
        $e = oci_error($stid);
        echo "Error al actualizar el empleado: " . $e['message'];
    }

    oci_free_statement($stid);
}

function eliminarEmpleado($conn) {
    $id_empleado = $_POST['id_empleado'];

    $query = "DELETE FROM jrsg_empleado 
                WHERE id_empleado = :id_empleado";
    $stid = oci_parse($conn, $query);

    oci_bind_by_name($stid, ':id_empleado', $id_empleado);

    if (oci_execute($stid)) {
        echo "Empleado eliminado exitosamente.";
    } else {
        $e = oci_error($stid);
        echo "Error al eliminar el empleado: " . $e['message'];
    }

    oci_free_statement($stid);
}
?>
