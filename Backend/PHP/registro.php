<?php
require('fpdf/fpdf.php');

// Conexión con la base de datos Oracle
$conn = oci_connect('usuario', 'contraseña', 'localhost/XE');
if (!$conn) {
    die('Error de conexión: ' . oci_error());
}

// Consulta para el reporte (producto más vendido)
$query = "SELECT nombre_producto, SUM(cantidad) AS total_ventas 
          FROM jrsg_detalle_venta_producto dvp
          JOIN jrsg_producto p ON dvp.id_producto = p.id_producto
          GROUP BY nombre_producto
          ORDER BY total_ventas DESC";

$stmt = oci_parse($conn, $query);
oci_execute($stmt);

// Generar el PDF
$pdf = new FPDF();
$pdf->AddPage();
$pdf->SetFont('Arial', 'B', 12);
$pdf->Cell(0, 10, 'Reporte de Productos Más Vendidos', 0, 1, 'C');
$pdf->Ln(10);

$pdf->SetFont('Arial', '', 10);
while ($row = oci_fetch_assoc($stmt)) {
    $pdf->Cell(100, 10, $row['NOMBRE_PRODUCTO'], 1);
    $pdf->Cell(30, 10, $row['TOTAL_VENTAS'], 1, 1);
}

oci_free_statement($stmt);
oci_close($conn);

$pdf->Output('D', 'reporte.pdf'); // Descarga el archivo directamente
?>
