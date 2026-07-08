
<?php
// Archivo para cargar imagenes desde la consola (CMD) hacia la galeria o los proyectos.
// Corregido para la base de datos reducida (sin usuarios, sin noticias).
require_once __DIR__ . '/../db.php';
 
// Funcion auxiliar para leer la entrada del usuario desde la consola
function leerEntrada($mensaje) {
    echo $mensaje . ": ";
    $entrada = fgets(STDIN);
    return trim($entrada);
}
 
echo "Cargador de Imagenes - Escuela Rural N.940\n";
echo "-------------------------------------------\n";
 
// Bucle para asegurar que se elija una tabla valida
$tabla = "";
while (!in_array($tabla, ['galeria_fotos', 'proyectos'])) {
    $tabla = leerEntrada("Ingrese la tabla destino (galeria_fotos, proyectos)");
}
 
$rutaLocal = leerEntrada("Ingrese la ruta local absoluta del archivo de imagen a subir");
 
if (!file_exists($rutaLocal)) {
    die("Error: El archivo no existe en la ruta local proporcionada.\n");
}
 
// Crear directorio de destino si no existe
$directorioDestino = __DIR__ . '/../../src/img/uploads/';
if (!is_dir($directorioDestino)) {
    mkdir($directorioDestino, 0777, true);
}
 
// Generar nombre de archivo unico para evitar colisiones
$extension = pathinfo($rutaLocal, PATHINFO_EXTENSION);
$nombreUnico = uniqid() . '_' . time() . '.' . $extension;
$rutaDestinoAbsoluta = $directorioDestino . $nombreUnico;
 
// Ruta relativa que se almacena en la base de datos (asi la ven las paginas HTML)
$rutaRelativaDB = '../src/img/uploads/' . $nombreUnico;
 
// Copiar el archivo fisico a la carpeta de subidas
if (!copy($rutaLocal, $rutaDestinoAbsoluta)) {
    die("Error: No se pudo copiar el archivo al directorio de subidas.\n");
}
 
echo "Archivo copiado exitosamente a: " . $rutaDestinoAbsoluta . "\n";
 
// Solicitar los datos requeridos e insertar el registro segun la tabla elegida
try {
    if ($tabla === 'galeria_fotos') {
        $titulo = leerEntrada("Ingrese titulo de la foto");
        $textoAlternativo = leerEntrada("Ingrese texto alternativo");
        $idCategoria = leerEntrada("Ingrese ID de categoria de galeria (1 Escuela, 2 Huerta, 3 Arte, 4 Comunidad, 5 Eventos)");
 
        $sql = "INSERT INTO galeria_fotos (titulo, texto_alternativo, url_imagen, id_categoria_galeria) VALUES (?, ?, ?, ?)";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$titulo, $textoAlternativo, $rutaRelativaDB, $idCategoria]);
 
    } elseif ($tabla === 'proyectos') {
        $titulo = leerEntrada("Ingrese titulo del proyecto");
        $resumen = leerEntrada("Ingrese resumen del proyecto");
        $descripcion = leerEntrada("Ingrese descripcion completa");
        $idCategoria = leerEntrada("Ingrese ID de categoria de proyecto (1 Agroecologia, 2 Arte y Cultura, 3 Comunidad)");
        $destacado = leerEntrada("Es un proyecto destacado? (1 = si, 0 = no)");
 
        $sql = "INSERT INTO proyectos (titulo, resumen, descripcion_completa, url_imagen, id_categoria_proyecto, destacado) VALUES (?, ?, ?, ?, ?, ?)";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$titulo, $resumen, $descripcion, $rutaRelativaDB, $idCategoria, $destacado]);
    }
 
    $idInsertado = $pdo->lastInsertId();
    echo "Exito: Registro insertado correctamente en la tabla '$tabla' con el ID: $idInsertado\n";
 
} catch (PDOException $e) {
    echo "Error de base de datos al intentar insertar el registro: " . $e->getMessage() . "\n";
}
