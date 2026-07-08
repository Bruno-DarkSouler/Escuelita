<?php
header('Content-Type: application/json; charset=utf-8');

// Incluir conexión a la base de datos
require_once __DIR__ . '/../db.php';

try {
    // Consulta para obtener todas las fotos con su categoría
    $sql = "SELECT g.id_foto, g.titulo, g.texto_alternativo, g.url_imagen, g.fecha_subida, c.nombre AS categoria 
            FROM galeria_fotos g 
            JOIN categorias_galeria c ON g.id_categoria_galeria = c.id_categoria_galeria 
            ORDER BY g.fecha_subida DESC";
            
    $stmt = $pdo->prepare($sql);
    $stmt->execute();
    $fotos = $stmt->fetchAll();

    echo json_encode($fotos, JSON_UNESCAPED_UNICODE);
} catch (PDOException $e) {
    header('HTTP/1.1 500 Internal Server Error');
    echo json_encode([
        'error' => 'Error al consultar la galería de fotos',
        'mensaje' => $e->getMessage()
    ]);
}
?>
