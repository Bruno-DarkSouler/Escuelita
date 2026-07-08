<?php
header('Content-Type: application/json; charset=utf-8');

// Incluir conexión a la base de datos
require_once __DIR__ . '/../db.php';

try {
    // Consulta para obtener testimonios publicados (publicado = 1)
    $sql = "SELECT id_testimonio, nombre_autor, contenido, fecha_publicacion 
            FROM testimonios 
            WHERE publicado = 1 
            ORDER BY fecha_publicacion DESC";
            
    $stmt = $pdo->prepare($sql);
    $stmt->execute();
    $testimonios = $stmt->fetchAll();

    echo json_encode($testimonios, JSON_UNESCAPED_UNICODE);
} catch (PDOException $e) {
    header('HTTP/1.1 500 Internal Server Error');
    echo json_encode([
        'error' => 'Error al consultar los testimonios',
        'mensaje' => $e->getMessage()
    ]);
}
?>
