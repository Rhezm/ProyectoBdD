document.addEventListener("DOMContentLoaded", function() {
    const content = document.getElementById('content');
     content.innerHTML = `
        <h1>Contacto</h1>
        <p>Aquí puedes ver la información de contacto.</p>
        <!-- Agrega más contenido específico para "Contacto" aquí -->
    `;
    fetch('sidebar.html')
            .then(response => response.text())
            .then(data => {
                document.getElementById('sidebar').innerHTML = data;
            })
            .catch(error => console.error('Error al cargar la barra lateral:', error));
});