<?php
header('Content-Type: application/json; charset=utf-8');

// Incluir conexión a la base de datos
require_once __DIR__ . '/../db.php';

try {
    // Consulta para obtener todos los proyectos con su categoría, ordenados por fecha_publicacion
    $sql = "SELECT p.id_proyecto, p.titulo, p.resumen, p.descripcion_completa, p.url_imagen, p.destacado, p.fecha_publicacion, c.nombre AS categoria 
            FROM proyectos p 
            JOIN categorias_proyecto c ON p.id_categoria_proyecto = c.id_categoria_proyecto 
            ORDER BY p.fecha_publicacion DESC";
            
    $stmt = $pdo->prepare($sql);
    $stmt->execute();
    $proyectos = $stmt->fetchAll();

    echo json_encode($proyectos, JSON_UNESCAPED_UNICODE);
} catch (PDOException $e) {
    header('HTTP/1.1 500 Internal Server Error');
    echo json_encode([
        'error' => 'Error al consultar los proyectos',
        'mensaje' => $e->getMessage()
    ]);
}
?>
