document.addEventListener("DOMContentLoaded", function() {
    const content = document.getElementById('content');
    content.innerHTML = `
        <h1>Registros</h1>
        <div id="tablaContenedor" style="display:none;">
            <table id="tabla" style="table-layout: auto;">
                <thead>
                    <tr id="tabla-encabezado">
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
        <div class="registros">
            <a button id="mostrarTabla1">Registro de ventas</a button>
            <a button id="mostrarTabla2">Productos más vendidos</a button>
            <a button id="mostrarTabla3">Productos menos vendidos</a button>
            <a button id="mostrarTabla4">Categorías más vendidas</a button>
        </div>
    `;

    function actualizarEncabezados(encabezados) {
        const encabezado = document.getElementById("tabla-encabezado");
        encabezado.innerHTML = "";
        encabezados.forEach(enc => {
            const th = document.createElement("th");
            th.innerText = enc;
            encabezado.appendChild(th);
        });
    }

    function registroventas() {
        $.ajax({
            url: '../../Backend/PHP/registro_ventas.php',
            type: 'GET',
            success: function(response) {
                $('#tabla tbody').html(response);
                actualizarEncabezados(["ID Ventaㅤ", "Nombre de Productoㅤㅤ", "Cantidadㅤㅤㅤㅤㅤ", "Fecha de venta"]);
                const tablaContenedor = document.getElementById("tablaContenedor");
                tablaContenedor.style.display = "block";
            },
            error: function(xhr, status, error) {
                $('#mensaje').html('Error al cargar productos: ' + xhr.responseText);
            }
        });
    }

    function masvendidos() {
        $.ajax({
            url: '../../Backend/PHP/mas_vendidos.php',
            type: 'GET',
            success: function(response) {
                $('#tabla tbody').html(response);
                actualizarEncabezados(["ID Producto", "Nombre de Producto", "Cantidad de ventas"]);
                const tablaContenedor = document.getElementById("tablaContenedor");
                tablaContenedor.style.display = "block";
            },
            error: function(xhr, status, error) {
                $('#mensaje').html('Error al cargar productos: ' + xhr.responseText);
            }
        });
    }

    function menosvendidos() {
        $.ajax({
            url: '../../Backend/PHP/menos_vendidos.php',
            type: 'GET',
            success: function(response) {
                $('#tabla tbody').html(response);
                actualizarEncabezados(["ID Producto", "Nombre de Producto", "Cantidad de ventas"]);
                const tablaContenedor = document.getElementById("tablaContenedor");
                tablaContenedor.style.display = "block";
            },
            error: function(xhr, status, error) {
                $('#mensaje').html('Error al cargar productos: ' + xhr.responseText);
            }
        });
    }

    function catmasvendidas() {
        $.ajax({
            url: '../../Backend/PHP/cat_mas_vendidas.php',
            type: 'GET',
            success: function(response) {
                $('#tabla tbody').html(response);
                actualizarEncabezados(["ID Categoría", "Nombre de Categoría", "Cantidad de ventas"]);
                const tablaContenedor = document.getElementById("tablaContenedor");
                tablaContenedor.style.display = "block";
            },
            error: function(xhr, status, error) {
                $('#mensaje').html('Error al cargar productos: ' + xhr.responseText);
            }
        });
    }

    // Seleccionamos el botón
    const tabla1 = document.getElementById("mostrarTabla1");
    const tabla2 = document.getElementById("mostrarTabla2");
    const tabla3 = document.getElementById("mostrarTabla3");
    const tabla4 = document.getElementById("mostrarTabla4");

    // Corregir el evento click
    tabla1.addEventListener("click", registroventas);
    tabla2.addEventListener("click", masvendidos);
    tabla3.addEventListener("click", menosvendidos);
    tabla4.addEventListener("click", catmasvendidas);
});
