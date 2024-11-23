<?php
require_once('../../tcpdf/tcpdf.php');

// Crear un nuevo documento PDF
$pdf = new TCPDF(PDF_PAGE_ORIENTATION, PDF_UNIT, array(170,250), true, 'UTF-8', false);

// Establecer la información del documento
$pdf->SetCreator(PDF_CREATOR);
$pdf->SetAuthor('Tu Nombre');
$pdf->SetTitle('Boleta Electrónica');
$pdf->SetSubject('Detalle de la Boleta');

// Establecer las márgenes
$pdf->SetMargins(PDF_MARGIN_LEFT, PDF_MARGIN_TOP, PDF_MARGIN_RIGHT);

// Añadir una página
$pdf->AddPage();

// Título de la boleta
$pdf->SetFont('courier', 'B', 14);
$pdf->Cell(0, 0, 'Boleta Electrónica', 0, 1, 'C');
$pdf->Ln(12);

// Datos del negocio
$pdf->SetFont('courier', '', 10);
$pdf->Cell(0, 5, 'Odette Patricia Andrades Oyarzun', 0, 1);
$pdf->Cell(0, 5, 'RUT: 11562557-8', 0, 1);
$pdf->Cell(0, 5, 'Giro: Cordoneria - Lanas - Hilos y Bordados', 0, 1);
$pdf->Cell(0, 5, '8 Oriente 1068, Talca, Talca', 0, 1);

// Detalles de la boleta
$id_boleta = 12345;
$fecha_actual = date('Y-m-d H:i:s');
$vendedor = 'Nombre del Vendedor';
$metodo_pago = 'Tarjeta de Crédito';

$pdf->Cell(0, 5, "Boleta Electronica: $id_boleta", 0, 1);
$pdf->Cell(0, 5, "Fecha: $fecha_actual", 0, 1);
$pdf->Cell(0, 5, "Vendedor: $vendedor", 0, 1);
$pdf->Cell(0, 5, "Metodo de Pago: $metodo_pago", 0, 1);
$pdf->Ln(5);
// Línea
$pdf->Line(10, $pdf->GetY(), 160, $pdf->GetY());
$pdf->Ln(5); // Salto de línea

// Conexión a la base de datos
$host = "localhost";
$user = "C##usuario";
$password = "123";
$service_name = "xe"; // Alias definido en tnsnames.ora
$connection_string = "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$host)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=$service_name)))";

$conn = oci_connect($user, $password, $connection_string);
if (!$conn) {
    die("Error de conexión: " . oci_error());
}

// Consulta para obtener los productos con id_producto 1 y 2
$query = 'SELECT cantidad, nombre_producto, precio FROM JRSG_PRODUCTO p inner join jrsg_detalle_venta_producto dvp on dvp.id_producto = p.id_producto WHERE dvp.id_venta = 1';
$stid = oci_parse($conn, $query);
oci_execute($stid);

$productos = [];
$total = 0;
while ($row = oci_fetch_assoc($stid)) {
    $productos[] = $row;
}

// Añadir los productos al PDF
$pdf->Cell(0, 5, 'Cantidad     Producto                         Precio   Total', 0, 1);
foreach ($productos as $producto) {
    $cantidad = $producto['CANTIDAD'];
    $nombre_producto = $producto['NOMBRE_PRODUCTO'];
    $precio = number_format($producto['PRECIO'], 0);
    $subtotal_p = number_format($cantidad * $producto['PRECIO'], 0);
    $total += $cantidad * $producto['PRECIO'];
    
    // Calcular espacios necesarios para alinear precios
    $espacio1 = str_repeat(' ', 13 - strlen($cantidad));
    $espacio2 = str_repeat(' ', 31 - strlen($nombre_producto));
    $pdf->Cell(0, 5, "$cantidad$espacio1$nombre_producto$espacio2  $precio    $subtotal_p", 0, 1);
}

// Calcular el IVA y el Subtotal
$iva = number_format($total - ($total / 1.19), 0);
$total_neto = number_format($total / 1.19, 0);

// Totales
$pdf->Ln(5); // Salto de línea
$pdf->Line(10, $pdf->GetY(), 160, $pdf->GetY());
$pdf->Ln(5); // Salto de línea

$pdf->Cell(0, 5, "TOTAL NETO: $total_neto", 0, 1);
$pdf->Cell(0, 5, "IVA (19%): $iva", 0, 1);
$total_a_pagar = number_format($total, 0);
$pdf->Cell(0, 5, "TOTAL A PAGAR: $total_a_pagar", 0, 1);

// Cerrar la conexión a la base de datos
oci_free_statement($stid);
oci_close($conn);

// Salida del PDF
$pdf->Output('boleta.pdf', 'I');
?>
