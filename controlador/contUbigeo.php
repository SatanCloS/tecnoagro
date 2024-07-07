<?php

require_once('../cado/ClsUbigeo.php');

session_start();
if (!empty($_POST['accion'])) {
    $accion = $_POST['accion'];    
    $codigo = $_POST['codigo'];   
}

if ($accion == "ListarDepartamento") {
    try {
        $obj = new ClsUbigeo();
        $rsql = $obj->ListarDepartamento('L', 0);

        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["codigo_dep"],
                    "nombre" => $row["nombre_dep"]
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

if ($accion == "ListarProvincia") {
    try {
        $obj = new ClsUbigeo();
        $rsql = $obj->ListarProvincia('L', $codigo);

        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["codigo_pro"],
                    "nombre" => $row["nombre_pro"]
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

if ($accion == "ListarDistrito") {
    try {
        $obj = new ClsUbigeo();
        $rsql = $obj->ListarDistrito('L', $codigo);

        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["codigo_dis"],
                    "nombre" => $row["nombre_dis"]
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