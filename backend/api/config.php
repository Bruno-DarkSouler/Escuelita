<?php
header('Content-Type: application/json; charset=utf-8');

// Datos institucionales fijos de la escuela.
// No se guardan en una tabla propia porque no cambian desde ningun panel
// y no tiene sentido una tabla sin relaciones solo para 6 valores fijos.
$config = [
    'nombre_escuela'       => 'Escuela Rural N°940 - Educación para las Primaveras',
    'cue'                  => '5400697/02',
    'frase_institucional'  => 'Ser cultos para ser libres',
    'direccion'            => 'Ruta Provincial 15 km.16 Paraje San Ramón, Colonia Primavera, El Soberbio, Misiones',
    'telefono'             => '37 5521 0802',
    'correo_contacto'      => 'martincorneil@hotmail.com'
];

echo json_encode($config, JSON_UNESCAPED_UNICODE);
?>