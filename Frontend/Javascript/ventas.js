document.addEventListener("DOMContentLoaded", function() {
    const content = document.getElementById('content');
    content.innerHTML = `
        <h1>Registros de Ventas</h1>
         <p>Aquí puedes ver la información de tus ventas.</p>
        <!-- Agrega más contenido específico para "Contacto" aquí -->
        <button id="generarReporte">Generar Reporte PDF</button>
        document.getElementById('generarReporte').addEventListener('click', function () {
    window.open('reporte.php', '_blank');
});
