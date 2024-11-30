<?php include('session.php'); ?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Barra Lateral</title>
    <link rel="stylesheet" href="..\CSS\estilo_principal.css">
</head>
<body>
    <div class="sidebar">
        <a href="nueva_venta.php">Nueva venta</a>
        <?php if ($_SESSION['tipo_usuario'] == 'dueño'): ?>
            <a href="registros.php">Registros</a>
            <a href="gestion_empleado.php">Gestión Empleado</a>
        <?php endif; ?>
        <a href="productos.php">Producto</a>
        <a href="cliente.php">Cliente</a>
        <a href="contacto.php">Contacto</a>
        <a href="logout.php" class="logout">Cerrar sesión</a>
    </div>
</body>
</html>
