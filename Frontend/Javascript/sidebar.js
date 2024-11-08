document.addEventListener("DOMContentLoaded", function() {
    const sidebarPlaceholder = document.getElementById('sidebar-placeholder');
    fetch('..\Dashboard\sidebar.html')
        .then(response => response.text())
        .then(data => {
            sidebarPlaceholder.innerHTML = data;
        });
});
