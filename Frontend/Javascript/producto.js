document.addEventListener("DOMContentLoaded", function() {
    const content = document.getElementById('content');
    content.innerHTML = `
                <h1>Nueva venta</h1>
                <div class="totals">
                    <div>Total Neto: $<span id="totalNeto">0</span></div>
                    <div>Total IVA (19%): $<span id="totalIVA">0</span></div>
                    <div>Total: $<span id="totalProducto">0</span></div>
                 </div>
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

function actualizarTotales() {           
    const totalIVA = totalNeto * 0.19;
    const totalProducto = totalNeto + totalIVA;

    document.getElementById('totalNeto').textContent = totalNeto.toFixed(2);
    document.getElementById('totalIVA').textContent = totalIVA.toFixed(2);
    document.getElementById('totalProducto').textContent = totalProducto.toFixed(2);
}

function verificarCampos() {
    const codigo = document.getElementById('cod_producto').value;
    const producto = document.getElementById('producto').value;
    const cantidad = document.getElementById('cantidad').value;
    const precio = document.getElementById('precio').value;
    const stock = document.getElementById('stock').value;
    const agregarBtn = document.getElementById('agregarBtn');
    
    if (codigo && producto && cantidad && precio && stock) {
        agregarBtn.disabled = false;
    } else {
        agregarBtn.disabled = true;
    }
}