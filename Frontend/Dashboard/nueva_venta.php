<?php include('session.php'); ?>
 <!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Comercial Andrades - Nueva Venta</title>
    <link rel="stylesheet" href="../CSS/estilo_principal.css">
</head>
<body>
    <div id="sidebar-placeholder"></div>
    <script src="..\Javascript\sidebar.js"></script>
    
    <div id="sidebar-placeholder"></div>
    <div class="content" id="content">
        <h1>Nueva venta</h1>
        <div class="form-container" style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 10px; margin-bottom: 20px; position: relative;">
            <div style="position: relative; grid-column: 1 / 2;">
                <input type="text" id="producto" placeholder="Producto" style="width: 98%;" oninput="buscarProducto()" autocomplete="off">
                <ul id="sugerencias" style="list-style: none; margin: 0; padding: 0; position: absolute; top: 100%; left: 0; width: 100%; max-height: 150px; overflow-y: auto; background: white; border: 1px solid #ccc; display: none; z-index: 1000;"></ul>
            </div>
            <input type="text" id="cod_producto" placeholder="Código" style="grid-column: 2 / 3;" oninput="verificarCampos()">
            <input type="number" min="0" id="cantidad" placeholder="Cantidad" style="grid-column: 3 / 4;" oninput="verificarCampos()">
            <input type="number" min="0" id="precio" placeholder="Precio" style="grid-column: 4 / 5;" oninput="verificarCampos()">
            <input type="number" min="0" id="stock" placeholder="Stock" style="grid-column: 1 / 2;" oninput="verificarCampos()">
            <button id="agregarBtn" style="grid-column: 1 / 2; padding: 5px 10px; font-size: 12px; cursor: pointer;" onclick="agregarProducto()" disabled>Agregar</button>
        </div>
        <div class="table-container">
            <table style="width: 100%; border-collapse: collapse; text-align: left; margin: 20px 0;">
                <thead style="background-color: #f4f4f4;">
                    <tr>
                        <th style="padding: 10px; border: 1px solid #ddd;">Código</th>
                        <th style="padding: 10px; border: 1px solid #ddd;">Producto</th>
                        <th style="padding: 10px; border: 1px solid #ddd;">Cantidad</th>
                        <th style="padding: 10px; border: 1px solid #ddd;">Precio</th>
                        <th style="padding: 10px; border: 1px solid #ddd;">Stock</th>
                        <th style="padding: 10px; border: 1px solid #ddd;">Acciones</th>
                    </tr>
                </thead>
                <tbody id="tablaVentas">    
                </tbody>
            </table>
        </div>
        <div class="totals">
            <div>Total Neto: $<span id="totalNeto">0</span></div>
            <div>Total IVA (19%): $<span id="totalIVA">0</span></div>
            <div>Total: $<span id="totalProducto">0</span></div>
        </div>
        <input type="number" min="0" id="cliente" placeholder="ID Cliente" style="grid-column: 1 / 2;">
        <div class="payment-section" style="display: flex; justify-content: flex-start; align-items: center; margin-top: 20px; padding: 2px;">
            <select id="metodo_pago" style="padding: 5px 10px; font-size: 12px; cursor: pointer;">
                <option value="">Seleccione método de pago</option>
                <option value="Tarjeta de Débito">Tarjeta de Débito</option>
                <option value="Tarjeta de Crédito">Tarjeta de Crédito</option>
                <option value="Efectivo">Efectivo</option>
            </select>
            <button id="mostrarTablaBtn" onclick="enviarDatosBoleta(); enviarDatosVenta();">Imprimir Boleta</button>
        </div>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            async function buscarProducto() {
                const input = document.getElementById("producto");
                const sugerencias = document.getElementById("sugerencias");
                const searchTerm = input.value.trim();

                if (searchTerm.length < 1) {
                    sugerencias.style.display = "none";
                    sugerencias.innerHTML = "";
                    return;
                }

                try {
                    const response = await fetch(`../../Backend/PHP/buscar_producto.php?term=${encodeURIComponent(searchTerm)}`);
                    const productos = await response.json();

                    sugerencias.innerHTML = "";
                    if (productos.length > 0) {
                        productos.forEach(producto => {
                            const li = document.createElement("li");
                            li.textContent = producto.NOMBRE_PRODUCTO;
                            li.style.padding = "5px";
                            li.style.cursor = "pointer";
                            li.addEventListener("click", () => {
                                seleccionarProducto(producto);
                            });
                            sugerencias.appendChild(li);
                        });
                        sugerencias.style.display = "block";
                    } else {
                        sugerencias.style.display = "none";
                    }
                } catch (error) {
                    console.error("Error al buscar productos:", error);
                }
            }

            function seleccionarProducto(producto) {
                document.getElementById("producto").value = producto.NOMBRE_PRODUCTO;
                document.getElementById("cod_producto").value = producto.ID_PRODUCTO;
                document.getElementById("precio").value = producto.PRECIO;
                document.getElementById("stock").value = producto.STOCK;

                const sugerencias = document.getElementById("sugerencias");
                sugerencias.style.display = "none";
                sugerencias.innerHTML = "";

                verificarCampos();
            }

            document.addEventListener("click", (event) => {
                const sugerencias = document.getElementById("sugerencias");
                if (!document.getElementById("producto").contains(event.target)) {
                    sugerencias.style.display = "none";
                }
            });

            document.getElementById("producto").addEventListener("input", buscarProducto);
        });

        let datos = [];
        let totalNeto = 0;
        let totalIVA = 0;
        let totalProducto = 0;

        function agregarProducto() {
            const cod_producto = document.getElementById('cod_producto').value;
            const producto = document.getElementById('producto').value;
            const cantidad = parseFloat(document.getElementById('cantidad').value);
            const precio = parseFloat(document.getElementById('precio').value);
            const stock = parseFloat(document.getElementById('stock').value);

            if (!cod_producto || !producto || isNaN(cantidad) || isNaN(precio) || isNaN(stock) || stock < cantidad) {
                alert('Por favor, completa todos los campos correctamente y asegúrate de que la cantidad no sea mayor que el stock antes de agregar el producto.');
                return;
            }

            const productoObj = {cod_producto, producto, cantidad, precio, stock};

            datos.push(productoObj);
            const tabla = document.getElementById('tablaVentas');
            const fila = document.createElement('tr');
            fila.innerHTML = `
                <td style='padding': '10px'; border='1px solid #ddd;'>${cod_producto}</td> 
              	<td style='padding': '10px'; border='1px solid #ddd;'>${producto}</td> 
              	<td style='padding': '10px'; border='1px solid #ddd;'> 
                 	<span class='cantidad'>${cantidad}</span> 
              	</td> 
              	<td style='padding': '10px'; border='1px solid #ddd;'>${precio}</td> 
              	<td style='padding': '10px'; border='1px solid #ddd;'>${stock}</td> 
              	<td style='padding': '10px'; border='1px solid #ddd;'> 
                 	<button onclick='editarCantidad(this)' 
                    	style='background:none;border:none;cursor:pointer;'>✏️</button> 
                 	<button onclick='eliminarProducto(this)' 
                    	style='background:none;border:none;margin-left=10px;'>🗑️</button> 
              	</td>`;
            
           tabla.appendChild(fila);

           document.getElementById('cod_producto').value='';
           document.getElementById('producto').value='';
           document.getElementById('cantidad').value='';
           document.getElementById('precio').value='';
           document.getElementById('stock').value='';

           actualizarTotales();

           document.getElementById('agregarBtn').disabled=true;
       }

        function editarCantidad(button) {
            const fila = button.closest('tr');
            const cantidadSpan = fila.querySelector('.cantidad');
            const valorActual = parseFloat(cantidadSpan.textContent);
            
            // Crear un input para editar
            cantidadSpan.innerHTML = `<input type='number' value='${valorActual}' style='width:50px;box-sizing:border-box;'>`;
            
            // Cambiar el botón para guardar
            button.innerHTML = "💾";
            
            button.onclick = function () {
                const input = cantidadSpan.querySelector('input');
                if (input) {
                    const nuevaCantidad = parseFloat(input.value);
                    cantidadSpan.textContent = nuevaCantidad; // Actualiza la cantidad en la tabla

                    // Actualiza el objeto en el array 'datos'
                    const index = Array.from(fila.parentNode.children).indexOf(fila);
                    datos[index].cantidad = nuevaCantidad; // Actualiza el array 'datos'

                    actualizarTotales(); // Actualiza los totales
                }
                button.innerHTML = "✏️";
                button.onclick = () => editarCantidad(button);
            };
        }

        function eliminarProducto(button) {
            const fila = button.closest('tr');
                
            // Obtener el índice del producto a eliminar
            const index = Array.from(fila.parentNode.children).indexOf(fila);
                
            // Eliminar el producto del array 'datos'
            datos.splice(index, 1);
                
            fila.remove(); // Eliminar la fila de la tabla
            actualizarTotales(); // Actualizar los totales
        }

       function verificarCampos() {
          	const cod_producto= document.getElementById('cod_producto').value;
          	const producto= document.getElementById('producto').value;
          	const cantidad= parseFloat(document.getElementById('cantidad').value);
          	const precio= parseFloat(document.getElementById('precio').value);
          	const stock= parseFloat(document.getElementById('stock').value);
          	const agregarBtn= document.getElementById('agregarBtn');
          	agregarBtn.disabled= !(cod_producto && producto && !isNaN(cantidad) && 
             	cantidad >0 && !isNaN(precio) && precio >0 && !isNaN(stock) && stock >0 &&
             	stock >= cantidad);
       }

       function actualizarTotales() {
            totalProducto = 0;
            datos.forEach(producto => {
                totalProducto += producto.cantidad * producto.precio;
            });
        
            totalNeto = totalProducto / 1.19;
            totalIVA = totalProducto - totalNeto;
        
            document.getElementById('totalNeto').textContent = totalNeto.toFixed(2);
            document.getElementById('totalIVA').textContent = totalIVA.toFixed(2);
            document.getElementById('totalProducto').textContent = totalProducto.toFixed(2);
        }

       document.addEventListener('input', (event) => {
          const target= event.target;
          if(target.matches('input[type="number"]')) {
              if(target.value<0) {
                  target.value=0;
              }
          }
       });

       function enviarDatosBoleta() {
          const metodoPago=document.getElementById('metodo_pago').value;

          if(!metodoPago) {
              alert('Por favor, seleccione un método de pago antes de imprimir la boleta.');
              return;
          }

          const datosBoleta= datos.map(producto=> ({
              cod_producto : producto.cod_producto,
              producto : producto.producto,
              cantidad : producto.cantidad,
              precio : producto.precio,
              total : producto.cantidad *producto.precio
          }));

          const boleta={
              productos : datosBoleta,
              totalNeto : totalNeto.toFixed(2),
              totalIVA : totalIVA.toFixed(2),
              totalProducto : totalProducto.toFixed(2),
              metodoPago : metodoPago
          };

          console.log(boleta);

          fetch('../../Backend/PHP/genera_boleta.php', {
              method : 'POST',
              headers : {
                  'Content-Type' : 'application/json',
              },
              body : JSON.stringify(boleta),
          })
          .then(response => response.blob())
          .then(blob => {
              const url= window.URL.createObjectURL(blob);
              const a= document.createElement('a');
              a.style.display='none';
              a.href=url;
              a.download='boleta.pdf';
              document.body.appendChild(a);
              a.click();
              window.URL.revokeObjectURL(url);
          })
          .catch(error => console.error('Error al generar la boleta:', error));
      }

      function enviarDatosVenta() {
          const idCliente=document.getElementById('cliente').value;

          if(!idCliente || datos.length===0) {
              alert('Debe ingresar un cliente y agregar al menos un producto.');
              return;
          }

          const payload={
              id_cliente:idCliente,
              productos : datos.map(producto=> ({
                  cod_producto : producto.cod_producto,
                  cantidad : producto.cantidad
              }))
          };

          console.log(payload);

          fetch('../../Backend/PHP/nueva_venta.php', {
              method:'POST',
              headers:{
                  'Content-Type':'application/json',
              },
              body : JSON.stringify(payload),
          })
          .then(response => response.json())
          .then(data => {
             if(data.success){
                 alert(data.success);
                 location.reload();
             } else{
                 alert(data.error || 'Error al registrar la venta.');
             }
         })
         .catch(error => console.error('Error al enviar los datos de la venta:', error));
     }
    </script>
</body>
</html>
