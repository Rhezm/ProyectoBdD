document.addEventListener("DOMContentLoaded", function() {
    const content = document.getElementById('content');
    content.innerHTML = `
        <h1>Registro de Ventas</h1>
        <p>Aquí puedes ver la información de tus ventas.</p>
        <div id="tablaContenedor" style="display:none;">
            <table id="tabla" style="margin-top:1rem;">
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
        <div class=registros>
            <a button id="mostrarTabla1">Producto más vendido</a button>
            <a button id="mostrarTabla2">Producto menos vendido</a button>
            <a button id="mostrarTabla3">Categoría más vendida</a button>
        </registros>
    `;

    // Definimos los datos de la tabla
    const datos1 = [
        { id: 1, nombre: "Producto A", precio: 100 },
        { id: 2, nombre: "Producto B", precio: 200 },
        { id: 3, nombre: "Producto C", precio: 300 }
    ];

    const datos2 = [
        { id: 4, nombre: "Producto D", precio: 100 },
        { id: 5, nombre: "Producto E", precio: 200 },
        { id: 6, nombre: "Producto F", precio: 300 },
        { id: 7, nombre: "Producto G", precio: 400 }
    ];

    const datos3 = [
        { id: 8, nombre: "Producto H", precio: 100 },
        { id: 9, nombre: "Producto I", precio: 200 }
    ];

    // Seleccionamos el botón
    const tabla1 = document.getElementById("mostrarTabla1");
    const tabla2 = document.getElementById("mostrarTabla2");
    const tabla3 = document.getElementById("mostrarTabla3");

    tabla1.addEventListener("click", function() {
        // Mostrar el contenedor de la tabla
        const tablaContenedor = document.getElementById("tablaContenedor");
        tablaContenedor.style.display = "block";
        
        // Crear el HTML de las filas de la tabla
        const tbody = document.querySelector("#tabla tbody");
        tbody.innerHTML = ""; // Limpiar la tabla antes de agregar nuevas filas

        // Agregar filas dinámicamente a la tabla
        datos1.forEach(dato => {
            tbody.innerHTML += `
                <tr>
                    <td>${dato.id}</td>
                    <td>${dato.nombre}</td>
                    <td>${dato.precio}</td>
                </tr>
            `;
        });
    });

    tabla2.addEventListener("click", function() {
        // Mostrar el contenedor de la tabla
        const tablaContenedor = document.getElementById("tablaContenedor");
        tablaContenedor.style.display = "block";
        
        // Crear el HTML de las filas de la tabla
        const tbody = document.querySelector("#tabla tbody");
        tbody.innerHTML = ""; // Limpiar la tabla antes de agregar nuevas filas

        // Agregar filas dinámicamente a la tabla
        datos2.forEach(dato => {
            tbody.innerHTML += `
                <tr>
                    <td>${dato.id}</td>
                    <td>${dato.nombre}</td>
                    <td>${dato.precio}</td>
                </tr>
            `;
        });
    });

    tabla3.addEventListener("click", function() {
        // Mostrar el contenedor de la tabla
        const tablaContenedor = document.getElementById("tablaContenedor");
        tablaContenedor.style.display = "block";
        
        // Crear el HTML de las filas de la tabla
        const tbody = document.querySelector("#tabla tbody");
        tbody.innerHTML = ""; // Limpiar la tabla antes de agregar nuevas filas

        // Agregar filas dinámicamente a la tabla
        datos3.forEach(dato => {
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
