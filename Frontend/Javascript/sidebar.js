document.addEventListener("DOMContentLoaded", function() {
    const sidebarPlaceholder = document.getElementById('sidebar-placeholder');
    fetch('../Dashboard/sidebar.php')
        .then(response => response.text())
        .then(data => {
            sidebarPlaceholder.innerHTML = data;
        });
});
