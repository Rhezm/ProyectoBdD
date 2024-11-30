<?php include('session.php'); ?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Comercial Andrades - Clientes</title>
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
        <h1>Gestión de Clientes</h1>
        <form id="clienteForm" class="form-container" style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 10px; margin-bottom: 20px;">
            <input type="number" id="id_cliente" name="id_cliente" placeholder="ID Cliente" required style="grid-column: 1 / 2;">
            <input type="text" id="nombre_cliente" name="nombre_cliente" placeholder="Nombre" required style="grid-column: 2 / 3;">
            <input type="text" id="apellido1_cliente" name="apellido1_cliente" placeholder="Apellido P" required style="grid-column: 3 / 4;">
            <input type="text" id="apellido2_cliente" name="apellido2_cliente" placeholder="Apellido M" required style="grid-column: 4 / 5;">
            <input type="number" id="telefono_cliente" name="telefono_cliente" placeholder="Teléfono" required style="grid-column: 1 / 2;">
            <input type="text" id="email_cliente" name="email_cliente" placeholder="Email" style="grid-column: 2 / 3;">
            <input type="submit" value="Agregar Cliente"  style="grid-column: 1 / 2;">
        </form>

        <div id="mensaje"></div>

        <div class="table-container">
            <table id="tablaClientes" border="1" style="width: 100%; border-collapse: collapse; text-align: left; margin: 20px 0;">
                <thead style="background-color: #f4f4f4;">
                    <tr>
                        <th style="padding: 10px; border: 1px solid #ddd;">ID Cliente</th>
                        <th style="padding: 10px; border: 1px solid #ddd;">Nombre</th>
                        <th style="padding: 10px; border: 1px solid #ddd;">Apellido P</th>
                        <th style="padding: 10px; border: 1px solid #ddd;">Apellido M</th>
                        <th style="padding: 10px; border: 1px solid #ddd;">Número de Teléfono</th>
                        <th style="padding: 10px; border: 1px solid #ddd;">Email</th>
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
        cargarClientes();

        $('#clienteForm').submit(function(event) {
            event.preventDefault();
            $.ajax({
                url: '../../Backend/PHP/gestionar_clientes.php',
                type: 'POST',
                data: $(this).serialize() + '&action=guardar',
                success: function(response) {
                    $('#mensaje').html(response);
                    cargarClientes();
                },
                error: function(xhr, status, error) {
                    $('#mensaje').html('Error: ' + xhr.responseText);
                }
            });
        });

        $('#clienteForm').keydown(function(event) {
            if (event.key === 'Enter') {
                event.preventDefault();
                $('#clienteForm').submit();
            }
        });
    });

    function cargarClientes() {
        $.ajax({
            url: '../../Backend/PHP/gestionar_clientes.php',
            type: 'POST',
            data: { action: 'obtener' },
            success: function(response) {
                $('#tablaClientes tbody').html(response);
                agregarEventosAcciones();
            },
            error: function(xhr, status, error) {
                $('#mensaje').html('Error al cargar Clientes: ' + xhr.responseText);
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
            guardarCliente(fila);
        });

        $('.eliminar').on('click', function() {
            if (confirm('¿Estás seguro de que deseas eliminar a este cliente?')) {
                var fila = $(this).closest('tr');
                var idCliente = fila.find('.id_cliente').text();
                $.ajax({
                    url: '../../Backend/PHP/gestionar_clientes.php',
                    type: 'POST',
                    data: { action: 'eliminar', id_cliente: idCliente },
                    success: function(response) {
                        $('#mensaje').html(response);
                        cargarClientes();
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
                guardarCliente(fila);
            }
        });
    }

    function guardarCliente(fila) {
        var datosCliente = {
            action: 'actualizar',
            id_cliente: fila.find('.id_cliente input').val(),
            nombre_cliente: fila.find('.nombre_cliente input').val(),
            apellido1_cliente: fila.find('.apellido1_cliente input').val(),
            apellido2_cliente: fila.find('.apellido2_cliente input').val(),
            telefono_cliente: fila.find('.telefono_cliente input').val(),
            email_cliente: fila.find('.email_cliente input').val()
        };

        $.ajax({
            url: '../../Backend/PHP/gestionar_clientes.php',
            type: 'POST',
            data: datosCliente,
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
