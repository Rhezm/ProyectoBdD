document.addEventListener("DOMContentLoaded", function () {
    const content = document.getElementById('content');
    content.innerHTML = `
        <h1>Gestión Productos</h1>
        <div class="form-container" style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 10px; margin-bottom: 20px;">
            <input type="text" id="id_producto" placeholder="Código Producto" style="grid-column: 1 / 2;">
            <input type="text" id="id_categoria" placeholder="Categoría" style="grid-column: 2 / 3;">
            <input type="text" id="id_promocion" placeholder="Promoción" style="grid-column: 3 / 4;">
            <input type="text" id="producto" placeholder="Producto" style="grid-column: 4 / 5;">
            <input type="text" id="descripcion" placeholder="Descripción" style="grid-column: 1 / 2;">
            <input type="number" id="precio" placeholder="Precio" style="grid-column: 2 / 3;">
            <input type="number" id="stock" placeholder="Stock" style="grid-column: 3 / 4;">
            <input type="number" id="precio_descuento" placeholder="Precio Descuento" style="grid-column: 4 / 5;">
            <button id="agregar" style="grid-column: 1 / 2; padding: 5px 10px; font-size: 12px; cursor: pointer;">Agregar</button>
        </div>
        <div class="table-container">
            <table style="width: 100%; border-collapse: collapse; text-align: left; margin: 20px 0;">
                <thead style="background-color: #f4f4f4;">
                    <tr>
                        <th style="padding: 10px; border: 1px solid #ddd;">Código Producto</th>
                        <th style="padding: 10px; border: 1px solid #ddd;">Categoría</th>
                        <th style="padding: 10px; border: 1px solid #ddd;">Promoción</th>
                        <th style="padding: 10px; border: 1px solid #ddd;">Producto</th>
                        <th style="padding: 10px; border: 1px solid #ddd;">Descripción</th>
                        <th style="padding: 10px; border: 1px solid #ddd;">Precio</th>
                        <th style="padding: 10px; border: 1px solid #ddd;">Stock</th>
                        <th style="padding: 10px; border: 1px solid #ddd;">Precio Descuento</th>
                        <th style="padding: 10px; border: 1px solid #ddd;">Acciones</th>
                    </tr>
                </thead>
                <tbody id="tablaProductos">
                    <!-- Aquí se agregarán los productos -->
                </tbody>
            </table>
        </div>
    `;

    // Función para agregar un nuevo producto
    document.getElementById('agregar').addEventListener('click', function () {
        const id_producto = document.getElementById('id_producto').value.trim();
        const id_categoria = document.getElementById('id_categoria').value.trim();
        const id_promocion = document.getElementById('id_promocion').value.trim();
        const producto = document.getElementById('producto').value.trim();
        const descripcion = document.getElementById('descripcion').value.trim();
        const precio = document.getElementById('precio').value.trim();
        const stock = document.getElementById('stock').value.trim();
        const precio_descuento = document.getElementById('precio_descuento').value.trim();

        if (id_producto && id_categoria && id_promocion && producto && descripcion && precio && stock && precio_descuento) {
            const nuevaFila = `
                <tr>
                    <td style="padding: 10px; border: 1px solid #ddd;">${id_producto}</td>
                    <td style="padding: 10px; border: 1px solid #ddd;">${id_categoria}</td>
                    <td style="padding: 10px; border: 1px solid #ddd;">${id_promocion}</td>
                    <td style="padding: 10px; border: 1px solid #ddd;">${producto}</td>
                    <td style="padding: 10px; border: 1px solid #ddd;">${descripcion}</td>
                    <td style="padding: 10px; border: 1px solid #ddd;">${precio}</td>
                    <td style="padding: 10px; border: 1px solid #ddd;">${stock}</td>
                    <td style="padding: 10px; border: 1px solid #ddd;">${precio_descuento}</td>
                    <td style="padding: 10px; border: 1px solid #ddd;">
                        <button onclick="editarFila(this)" style="background: none; border: none; cursor: pointer;">
                            ✏️
                        </button>
                        <button onclick="eliminarFila(this)" style="background: none; border: none; cursor: pointer; margin-left: 10px;">
                            🗑️
                        </button>
                    </td>
                </tr>
            `;
            document.getElementById('tablaProductos').insertAdjacentHTML('beforeend', nuevaFila);

            // Limpiar campos después de agregar
            document.getElementById('id_producto').value = '';
            document.getElementById('id_categoria').value = '';
            document.getElementById('id_promocion').value = '';
            document.getElementById('producto').value = '';
            document.getElementById('descripcion').value = '';
            document.getElementById('precio').value = '';
            document.getElementById('stock').value = '';
            document.getElementById('precio_descuento').value = '';
        } else {
            alert('Por favor, completa todos los campos antes de agregar.');
        }
    });

    // Función para editar una fila
    window.editarFila = function (boton) {
        const fila = boton.closest('tr');
        const celdas = fila.querySelectorAll('td:not(:last-child)');
        celdas.forEach((celda) => {
            const valor = celda.textContent;
            celda.innerHTML = `<input type="text" value="${valor}" style="width: 100%; box-sizing: border-box;">`;
        });
        boton.textContent = "💾"; // Cambia el ícono de lápiz a un ícono de guardar
        boton.onclick = function () {
            celdas.forEach((celda) => {
                const input = celda.querySelector('input');
                if (input) celda.textContent = input.value; // Actualiza el contenido con el valor del input
            });
            boton.textContent = "✏️"; // Cambia el ícono de guardar a un ícono de lápiz
            boton.onclick = () => editarFila(boton); // Reasigna la función para editar
        };
    };

    // Función para eliminar una fila
    window.eliminarFila = function (boton) {
        const fila = boton.closest('tr');
        fila.remove();
    };
});
