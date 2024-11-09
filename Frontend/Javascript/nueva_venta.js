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
                    <input type="number" id="cantidad" placeholder="Cantidad" oninput="verificarCampos()">
                    <input type="number" id="precio" placeholder="Precio" oninput="verificarCampos()">
                    <input type="number" id="stock" placeholder="Stock" oninput="verificarCampos()">
                    <button id="agregarBtn" onclick="agregarProducto()" disabled>Agregar</button>
                </div>
                <table>
                    <thead>
                         <tr>
                            <th>Código</th>
                            <th>Producto</th>
                            <th>Cantidad</th>
                            <th>Precio</th>
                            <th>Stock</th>
                        </tr>
                    </thead>
                    <tbody id="tablaProductos">
                        <tr>
                            <td>101</td>
                            <td>Hilo</td>
                            <td>10</td>
                            <td>2500</td>
                            <td>100</td>
                        </tr>
                        <tr>
                            <td>102</td>
                            <td>Botón</td>
                            <td>20</td>
                            <td>3500</td>
                            <td>200</td>
                        </tr>
                        <tr>
                            <td>103</td>
                            <td>Aguja</td>
                            <td>30</td>
                            <td>4500</td>
                            <td>300</td>
                        </tr>
                    </tbody>
                </table>
                `;
});

let totalNeto = 0;

function agregarProducto() {
    const cod_producto = document.getElementById('cod_producto').value;
    const producto = document.getElementById('producto').value;
    const cantidad = parseFloat(document.getElementById('cantidad').value);
    const precio = parseFloat(document.getElementById('precio').value);
    const stock = parseFloat(document.getElementById('stock').value);

    const tabla = document.getElementById('tablaProductos');
    const fila = document.createElement('tr');

    fila.innerHTML = `
        <td>${cod_producto}</td>
        <td>${producto}</td>
        <td>${cantidad}</td>
        <td>${precio}</td>
        <td>${stock}</td>
    `;

    tabla.appendChild(fila);

    totalNeto += cantidad * precio;
    actualizarTotales();
    
    document.getElementById('cod_producto').value = '';   /*Hace que los valores se limpien*/
    document.getElementById('producto').value = '';
    document.getElementById('cantidad').value = '';
    document.getElementById('precio').value = '';
    document.getElementById('stock').value = '';

    verificarCampos();
}

function inicializarTotales() {
    const filas = document.querySelectorAll('#tablaProductos tr');
    filas.forEach(fila => {
        const celdas = fila.querySelectorAll('td');
        if (celdas.length > 0) {
            const cantidad = parseFloat(celdas[2].textContent);
            const precio = parseFloat(celdas[3].textContent);
            totalNeto += cantidad * precio;
        }
    });
    actualizarTotales();
}

 function actualizarTotales() {           
    const totalIVA = totalNeto * 0.19;
    const totalProducto = totalNeto + totalIVA;

    document.getElementById('totalNeto').textContent = totalNeto.toFixed(2);
    document.getElementById('totalIVA').textContent = totalIVA.toFixed(2);
    document.getElementById('totalProducto').textContent = totalProducto.toFixed(2);
}

function verificarCampos() {
    const cod_producto = document.getElementById('cod_producto').value;
    const producto = document.getElementById('producto').value;
    const cantidad = document.getElementById('cantidad').value;
    const precio = document.getElementById('precio').value;
    const stock = document.getElementById('stock').value;
    const agregarBtn = document.getElementById('agregarBtn');
    
    if (cod_producto && producto && cantidad && precio && stock) {
        agregarBtn.disabled = false;
    } else {
        agregarBtn.disabled = true;
    }
}