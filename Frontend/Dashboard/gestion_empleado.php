<?php include('session.php'); ?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Comercial Andrades - Empleados</title>
    <link rel="stylesheet" href="../CSS/estilo_principal.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .editable {
            background-color: #f0f0f0;
            cursor: pointer;
            display: flex;
            flex-wrap: nowrap;
        }
        .editable input {
            flex: 1;
            min-width: 0;
            max-width: 100%;
            box-sizing: border-box;
        }
        .accion-icono {
            cursor: pointer;
        }
        .editando input {
            width: 100%;
            box-sizing: border-box;
            max-width: 200px;
        }
        .table-container {
            display: block;
            width: 100%;
        }
        .table-container table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
        }
        .table-container th, .table-container td {
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            border: 1px solid #ddd;
        }
    </style>
</head>
<body>
    <div id="sidebar-placeholder"></div>
    <script src="..\Javascript\sidebar.js"></script>

    <div class="content">
        <h1>Gestión de Empleados</h1>
        <form id="empleadoForm" class="form-container" style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 10px; margin-bottom: 20px;">
            <input type="number" id="id_empleado" name="id_empleado" placeholder="ID Empleado" required style="grid-column: 1 / 2;">
            <input type="text" id="nombre_empleado" name="nombre_empleado" placeholder="Nombre" required style="grid-column: 2 / 3;">
            <input type="text" id="apellido1_empleado" name="apellido1_empleado" placeholder="Apellido P" required style="grid-column: 3 / 4;">
            <input type="text" id="apellido2_empleado" name="apellido2_empleado" placeholder="Apellido M" required style="grid-column: 4 / 5;">
            <input type="number" id="telefono_empleado" name="telefono_empleado" placeholder="Teléfono" required style="grid-column: 1 / 2;">
            <input type="text" id="email_empleado" name="email_empleado" placeholder="Email" style="grid-column: 2 / 3;">
            <input type="text" id="contrasena" name="contrasena" placeholder="Contrasena" required style="grid-column: 3 / 4;">
            <input type="submit" value="Agregar Empleado"  style="grid-column: 1 / 2;">
        </form>

        <div id="mensaje"></div>

        <div class="table-container">
            <table id="tablaEmpleados" border="1" style="width: 100%; border-collapse: collapse; text-align: left; margin: 20px 0;">
                <thead style="background-color: #f4f4f4;">
                    <tr>
                        <th style="padding: 10px; border: 1px solid #ddd;">ID Empleado</th>
                        <th style="padding: 10px; border: 1px solid #ddd;">Nombre</th>
                        <th style="padding: 10px; border: 1px solid #ddd;">Apellido P</th>
                        <th style="padding: 10px; border: 1px solid #ddd;">Apellido M</th>
                        <th style="padding: 10px; border: 1px solid #ddd;">Número de Teléfono</th>
                        <th style="padding: 10px; border: 1px solid #ddd;">Email</th>
                        <th style="padding: 10px; border: 1px solid #ddd;">Contraseña</th>
                        <th style="padding: 10px; border: 1px solid #ddd;">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>

    <script>
    $(document).ready(function() {
        cargarEmpleados();

        $('#empleadoForm').submit(function(event) {
            event.preventDefault();
            $.ajax({
                url: '../../Backend/PHP/gestionar_empleados.php',
                type: 'POST',
                data: $(this).serialize() + '&action=guardar',
                success: function(response) {
                    $('#mensaje').html(response);
                    cargarEmpleados();
                },
                error: function(xhr, status, error) {
                    $('#mensaje').html('Error: ' + xhr.responseText);
                }
            });
        });

        $('#empleadoForm').keydown(function(event) {
            if (event.key === 'Enter') {
                event.preventDefault();
                $('#empleadoForm').submit();
            }
        });
    });

    function cargarEmpleados() {
        $.ajax({
            url: '../../Backend/PHP/gestionar_empleados.php',
            type: 'POST',
            data: { action: 'obtener' },
            success: function(response) {
                $('#tablaEmpleados tbody').html(response);
                agregarEventosAcciones();
            },
            error: function(xhr, status, error) {
                $('#mensaje').html('Error al cargar empleados: ' + xhr.responseText);
            }
        });
    }

    function agregarEventosAcciones() {
        $('.editar').on('click', function() {
            var fila = $(this).closest('tr');
            fila.find('td:not(:last-child)').each(function() {
                var valor = $(this).text();
                $(this).html('<input type="text" value="' + valor + '">');
            });
            $(this).hide();
            fila.find('.guardar').show();
        });

        $('.guardar').on('click', function() {
            var fila = $(this).closest('tr');
            guardarEmpleado(fila);
        });

        $('.eliminar').on('click', function() {
            if (confirm('¿Estás seguro de que deseas eliminar a este empleado?')) {
                var fila = $(this).closest('tr');
                var idEmpleado = fila.find('.id_empleado').text();
                $.ajax({
                    url: '../../Backend/PHP/gestionar_empleados.php',
                    type: 'POST',
                    data: { action: 'eliminar', id_empleado: idEmpleado },
                    success: function(response) {
                        $('#mensaje').html(response);
                        cargarEmpleados();
                    },
                    error: function(xhr, status, error) {
                        $('#mensaje').html('Error: ' + xhr.responseText);
                    }
                });
            }
        });

        $('tr').on('keydown', 'input', function(event) {
            if (event.key === 'Enter') {
                event.preventDefault();
                var fila = $(this).closest('tr');
                guardarEmpleado(fila);
            }
        });
    }

    function guardarEmpleado(fila) {
        var datosEmpleado = {
            action: 'actualizar',
            id_empleado: fila.find('.id_empleado input').val(),
            nombre_empleado: fila.find('.nombre_empleado input').val(),
            apellido1_empleado: fila.find('.apellido1_empleado input').val(),
            apellido2_empleado: fila.find('.apellido2_empleado input').val(),
            telefono_empleado: fila.find('.telefono_empleado input').val(),
            email_empleado: fila.find('.email_empleado input').val(),
            contrasena: fila.find('.contrasena input').val()
        };

        $.ajax({
            url: '../../Backend/PHP/gestionar_empleados.php',
            type: 'POST',
            data: datosEmpleado,
            success: function(response) {
                $('#mensaje').html(response);
                fila.find('td:not(:last-child)').each(function() {
                    var input = $(this).find('input');
                    $(this).text(input.val());
                });
                fila.find('.guardar').hide();
                fila.find('.editar').show();
            },
            error: function(xhr, status, error) {
                $('#mensaje').html('Error: ' + xhr.responseText);
            }
        });
    }
    </script>
</body>
</html>
