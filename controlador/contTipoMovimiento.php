<?php

require_once('../cado/ClsTipoMovimiento.php');

session_start();
if (!empty($_POST['accion'])) {
    $accion = $_POST['accion'];    
}

if ($accion == "Listar") {
    try {
        //echo var_dump($data);
        $obj = new ClsTipoMovimiento();
        $rsql = $obj->Listar('L', 0);
        $data = array();

        //echo var_dump($data);

        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["codigo_tmo"],
                    "nombre_tmo" => $row["nombre_tmo"]
                ));
            }
        } else {
            $data = "";
        }
        echo json_encode($data);
    } catch (Exception $e) {
        $json = $e->getMessage();
        $data['data'] = $json;
        echo json_encode($data);
    }
}






?>