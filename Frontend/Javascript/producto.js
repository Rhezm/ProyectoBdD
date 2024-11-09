document.addEventListener("DOMContentLoaded", function() {
    const content = document.getElementById('content');
    content.innerHTML = `
                <h1>Nueva venta</h1>
                <div class="form-container">
                    <input type="text" id="cod_producto" placeholder="Código" oninput="verificarCampos()">
                    <input type="text" id="producto" placeholder="Producto" oninput="verificarCampos()">
                    <input type="text" id="proveedor" placeholder="Proveedor" oninput="verificarCampos()">
                    <button id="agregarBtn" onclick="agregarProducto()" disabled>Agregar</button>
                </div>
                <table>
                    <thead>
                         <tr>
                            <th>Código</th>
                            <th>Producto</th>
                            <th>Proveedor</th>
                        </tr>
                    </thead>
                    <tbody id="tablaProductos">
                    </tbody>
                </table>
                `;
});

let totalNeto = 0;

function agregarProducto() {
    const cod_producto = document.getElementById('cod_producto').value;
    const producto = document.getElementById('producto').value;
    const proveedor = document.getElementById('producto').value;

    const tabla = document.getElementById('tablaProductos');
    const fila = document.createElement('tr');

    fila.innerHTML = `
        <td>${cod_producto}</td>
        <td>${producto}</td>
        <td>${proveedor}</td>
    `;

    tabla.appendChild(fila);

    totalNeto += cantidad * precio;
    actualizarTotales();
    
    document.getElementById('cod_producto').value = '';   /*Hace que los valores se limpien*/
    document.getElementById('producto').value = '';
    document.getElementById('proveedor').value = '';

    verificarCampos();
}

function verificarCampos() {
    const codigo = document.getElementById('cod_producto').value;
    const producto = document.getElementById('producto').value;
    const proveedor = document.getElementById('cantidad').value;
    const agregarBtn = document.getElementById('agregarBtn');
    
    if (codigo && producto && proveedor) {
        agregarBtn.disabled = false;
    } else {
        agregarBtn.disabled = true;
    }
}