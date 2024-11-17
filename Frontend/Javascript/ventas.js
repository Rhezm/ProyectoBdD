document.addEventListener("DOMContentLoaded", function() {
    const content = document.getElementById('content');
    content.innerHTML = `
        <h1>Registros de Ventas</h1>
        <p>Aquí puedes ver la información de tus ventas.</p>
        <!-- Agrega más contenido específico para "Contacto" aquí -->
        <button id="generarReporte">Generar Reporte PDF</button>
    `;
    // script.js
document.getElementById("mostrarTablaBtn").addEventListener("click", function() {
  // Mostrar el contenedor de la tabla
  document.getElementById("tablaContenedor").style.display = "block";
  
  // Agregar filas de datos a la tabla
  const tbody = document.querySelector("#tabla tbody");
  const datos = [
    { id: 1, nombre: "Producto A", precio: 100 },
    { id: 2, nombre: "Producto B", precio: 200 },
    { id: 3, nombre: "Producto C", precio: 300 }
  ];

  // Limpiar la tabla antes de agregar nuevos datos
  tbody.innerHTML = "";

  // Insertar las filas de la tabla
  datos.forEach(dato => {
    const tr = document.createElement("tr");
    tr.innerHTML = `<td>${dato.id}</td><td>${dato.nombre}</td><td>${dato.precio}</td>`;
    tbody.appendChild(tr);
  });
});

});
