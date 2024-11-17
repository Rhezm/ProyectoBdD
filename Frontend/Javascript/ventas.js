document.addEventListener("DOMContentLoaded", function() {
    const content = document.getElementById('content');
    content.innerHTML = `
        <h1>Registros de Ventas</h1>
        <p>Aquí puedes ver la información de tus ventas.</p>
        <!-- Agrega más contenido específico para "Contacto" aquí -->
        <button id="generarReporte">Generar Reporte PDF</button>
    `;
   document.addEventListener("DOMContentLoaded", function() {
    // Crear el contenido HTML
    const contenidoHTML = `
        <h1>Registros de Ventas</h1>
        <p>Aquí puedes ver la información de tus ventas.</p>
        <button id="mostrarTablaBtn">Mostrar Tabla</button>
        <div id="tablaContenedor" style="display:none;">
            <table border="1">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Precio</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Las filas de la tabla serán agregadas aquí -->
                </tbody>
            </table>
        </div>
    `;

    // Insertamos el contenido HTML en el body
    document.body.innerHTML = contenidoHTML;

    // Definimos los datos de la tabla
    const datos = [
        { id: 1, nombre: "Producto A", precio: 100 },
        { id: 2, nombre: "Producto B", precio: 200 },
        { id: 3, nombre: "Producto C", precio: 300 }
    ];

    // Seleccionamos el botón
    const boton = document.getElementById("mostrarTablaBtn");

    boton.addEventListener("click", function() {
        // Mostrar el contenedor de la tabla
        const tablaContenedor = document.getElementById("tablaContenedor");
        tablaContenedor.style.display = "block";
        
        // Crear el HTML de las filas de la tabla
        const tbody = document.querySelector("#tabla tbody");
        tbody.innerHTML = ""; // Limpiar la tabla antes de agregar nuevas filas

        // Agregar filas dinámicamente a la tabla
        datos.forEach(dato => {
            tbody.innerHTML += `
                <tr>
                    <td>${dato.id}</td>
                    <td>${dato.nombre}</td>
                    <td>${dato.precio}</td>
                </tr>
            `;
        });
    });
});

});
