<?php include('session.php'); ?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Comercial Andrades - Productos</title>
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
        .placeholder {
            color: gray;
            font-style: italic;
        }
    </style>
</head>
<body>
    <div id="sidebar-placeholder"></div>
    <script src="..\Javascript\sidebar.js"></script>

    <div class="content">
        <h1>Gestión Productos</h1>
        <form id="productoForm" class="form-container" style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 10px; margin-bottom: 20px;">
            <input type="number" id="id_producto" name="id_producto" placeholder="ID Producto" required style="grid-column: 1 / 2;">
            <input type="number" id="id_categoria" name="id_categoria" placeholder="ID Categoría" required style="grid-column: 2 / 3;">
            <input type="text" id="nombre_producto" name="nombre_producto" placeholder="Nombre del Producto" maxlength="60" required style="grid-column: 3 / 4;">
            <input type="text" id="descripcion_producto" name="descripcion_producto" placeholder="Descripción del Producto" maxlength="200" required style="grid-column: 4 / 5;">
            <input type="number" step="0.01" id="precio" name="precio" placeholder="Precio" required style="grid-column: 1 / 2;">
            <input type="number" id="stock" name="stock" placeholder="Stock" required style="grid-column: 2 / 3;">
            <input type="submit" value="Guardar Producto" style="grid-column: 1 / 2;">
        </form>

        <div id="mensaje"></div>

        <div class="table-container">
            <table id="tablaProductos" border="1" style="width: 100%; border-collapse: collapse; text-align: left; margin: 20px 0;">
                <thead>
                    <tr>
                        <th>ID Producto</th>
                        <th>ID Categoría</th>
                        <th>Nombre del Producto</th>
                        <th>Descripción del Producto</th>
                        <th>Precio</th>
                        <th>Stock</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>

    <script>
    $(document).ready(function() {
        cargarProductos();

        $('#productoForm').submit(function(event) {
            event.preventDefault();

            $.ajax({
                url: '../../Backend/PHP/gestionar_productos.php',
                type: 'POST',
                data: $(this).serialize() + '&action=guardar',
                success: function(response) {
                    $('#mensaje').html(response);
                    cargarProductos();
                },
                error: function(xhr, status, error) {
                    $('#mensaje').html('Error: ' + xhr.responseText);
                }
            });
        });

        $('#productoForm').keydown(function(event) {
            if (event.key === 'Enter') {
                event.preventDefault();
                $('#productoForm').submit();
            }
        });
    });

    function cargarProductos() {
        $.ajax({
            url: '../../Backend/PHP/gestionar_productos.php',
            type: 'POST',
            data: { action: 'obtener' },
            success: function(response) {
                $('#tablaProductos tbody').html(response);
                agregarEventosAcciones();
                actualizarPlaceholders();
            },
            error: function(xhr, status, error) {
                $('#mensaje').html('Error al cargar productos: ' + xhr.responseText);
            }
        });
    }

    function agregarEventosAcciones() {
        $('.editar').on('click', function() {
            var fila = $(this).closest('tr');
            fila.addClass('editando');
            fila.find('td:not(:last-child)').each(function() {
                var valor = $(this).text();
                if(valor !== 'No se presenta') {
                    $(this).html('<input type="text" value="' + valor + '">');
                } else {
                    $(this).html('<input type="text" value="">');
                }
            });
            $(this).hide();
            fila.find('.guardar').show();
        });

        $('.guardar').on('click', function() {
            var fila = $(this).closest('tr');
            guardarProducto(fila);
        });

        $('.eliminar').on('click', function() {
            if (confirm('¿Estás seguro de que deseas eliminar este producto?')) {
                var fila = $(this).closest('tr');
                var idProducto = fila.find('.id_producto').text();

                $.ajax({
                    url: '../../Backend/PHP/gestionar_productos.php',
                    type: 'POST',
                    data: { action: 'eliminar', id_producto: idProducto },
                    success: function(response) {
                        $('#mensaje').html(response);
                        cargarProductos();
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
                guardarProducto(fila);
            }
        });
    }

    function guardarProducto(fila) {
        var datosProducto = {
            action: 'actualizar',
            id_producto: fila.find('.id_producto input').val(),
            id_categoria: fila.find('.id_categoria input').val(),
            nombre_producto: fila.find('.nombre_producto input').val(),
            descripcion_producto: fila.find('.descripcion_producto input').val(),
            precio: fila.find('.precio input').val(),
            stock: fila.find('.stock input').val()
        };

        $.ajax({
            url: '../../Backend/PHP/gestionar_productos.php',
            type: 'POST',
            data: datosProducto,
            success: function(response) {
                $('#mensaje').html(response);
                fila.find('td:not(:last-child)').each(function() {
                    var input = $(this).find('input');
                    $(this).text(input.val());
                });
                fila.removeClass('editando');
                fila.find('.guardar').hide();
                fila.find('.editar').show();
                actualizarPlaceholders();
            },
            error: function(xhr, status, error) {
                $('#mensaje').html('Error: ' + xhr.responseText);
            }
        });
    }
    </script>
</body>
</html>
