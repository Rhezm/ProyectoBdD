<?php
date_default_timezone_set('America/Santiago');
session_start();
require_once('../../tcpdf/tcpdf.php');

// Configuración de la base de datos
$usuario = 'C##usuario';
$clave = '123';
$host = 'localhost';
$puerto = '1521';
$servicio = 'XE';
$conn = oci_connect($usuario, $clave, "//{$host}:{$puerto}/{$servicio}");
if (!$conn) {
    $error = oci_error();
    echo "Error de conexión: " . $error['message'];
    exit;
}

// Obtener el siguiente valor de la secuencia para el ID de la boleta
$query_id_boleta = "SELECT jrsg_sec_genera_id_boleta.NEXTVAL AS id_boleta FROM dual";
$stmt = oci_parse($conn, $query_id_boleta);
oci_execute($stmt);
$row = oci_fetch_assoc($stmt);
$id_boleta = $row['ID_BOLETA'];


// Obtener los datos enviados desde JavaScript
$json = file_get_contents('php://input');
$datos = json_decode($json, true);

// Verificar si los datos se han recibido correctamente
if (is_null($datos)) {
    error_log("Contenido recibido: " . $json);
    die('Error: No se recibieron datos o los datos no son válidos.');
}

// Crear un nuevo documento PDF
$pdf = new TCPDF(PDF_PAGE_ORIENTATION, PDF_UNIT, array(170, 200), true, 'UTF-8', false);

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
$fecha_actual = date('Y-m-d H:i:s');
$vendedor = isset($_SESSION['id_empleado']) ? $_SESSION['id_empleado'] : 'No asignado';
$metodo_pago = isset($datos['metodoPago']) ? $datos['metodoPago'] : 'No especificado'; // Cambia aquí para asegurarte de que el método de pago se extraiga correctamente

$pdf->Cell(0, 5, "Boleta Electrónica: $id_boleta", 0, 1);
$pdf->Cell(0, 5, "Fecha: $fecha_actual", 0, 1);
$pdf->Cell(0, 5, "Vendedor: $vendedor", 0, 1);
$pdf->Cell(0, 5, "Método de Pago: $metodo_pago", 0, 1); // Ahora se debe mostrar correctamente
$pdf->Ln(5);

// Línea divisoria
$pdf->Line(10, $pdf->GetY(), 160, $pdf->GetY());
$pdf->Ln(5);

// Añadir los productos al PDF
$pdf->Cell(0, 5, 'Cantidad     Producto                       Precio      Total', 0, 1);
$total = 0;
foreach ($datos['productos'] as $producto) {
    $cantidad = $producto['cantidad'];
    $nombre_producto = $producto['producto'];
    $precio = number_format($producto['precio'], 0);
    $subtotal_p = number_format($cantidad * $producto['precio'], 0);
    $total += $cantidad * $producto['precio'];

    // Calcular espacios necesarios para alinear precios
    $espacio1 = str_repeat(' ', 13 - strlen($cantidad));
    $espacio2 = str_repeat(' ', 31 - strlen($nombre_producto));
    $espacio3 = str_repeat(' ', 12 - strlen($precio));
    $pdf->Cell(0, 5, "$cantidad$espacio1$nombre_producto$espacio2$precio$espacio3$subtotal_p", 0, 1);
}

// Calcular el IVA y el Subtotal
$iva = number_format($total - ($total / 1.19), 0);
$total_neto = number_format($total / 1.19, 0);

// Totales
$pdf->Ln(5);
$pdf->Line(10, $pdf->GetY(), 160, $pdf->GetY());
$pdf->Ln(5);
$pdf->Cell(0, 5, "TOTAL NETO: $total_neto", 0, 1);
$pdf->Cell(0, 5, "IVA (19%): $iva", 0, 1);
$total_a_pagar = number_format($total, 0);
$pdf->Cell(0, 5, "TOTAL A PAGAR: $total_a_pagar", 0, 1);

// Salida del PDF
$pdf->Output('boleta.pdf', 'I');
?>
