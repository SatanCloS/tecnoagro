<?php

require_once('../cado/ClsLinea.php');

session_start();
if (!empty($_POST['accion'])) {
    $accion = $_POST['accion'];    
}

if ($accion == "Listar") {
    try {
        $obj = new ClsLinea();
        $rsql = $obj->Listar('L', 0);

        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["codigo_lin"],
                    "nombre" => $row["nombre_lin"],
                    "serviciotecnico" => $row["serviciotecnico_lin"]
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



if ($accion == "Actualizar") {

    try {
        $obj = new ClsLinea();
        $codigo = $_POST['hdcod'];
        $nombre = $_POST['txtNombre'];
        //$serviciotecnico = $_POST['cboServicioTecnico'];
        $serviciotecnico = ($_POST['cboServicioTecnico'] == 'S') ? 'S' : 'N';

        $rsql = $obj->Actualizar($codigo, $nombre, $serviciotecnico, 0);
        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "rpta" => $row["Respuesta"],
                    "msj" => $row["Mensaje"],
                ));
            }
        } else {
            array_push($data, array(
                "rpta" => "0",
                "msj" => "No se pudo realizar la operación",
            ));
        }
        echo json_encode($data);
    } catch (Exception $e) {
        $json = $e->getMessage();
        $data['data'] = $json;
        echo json_encode($data);
    }
}


if ($accion == "Editar") {
    try {
        $obj = new ClsLinea();
        if (!empty($_POST['codigo'])) {
            $id = $_POST['codigo'];
        }
        $rsql = $obj->Listar('E', $id);
        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["codigo_lin"],
                    "nombre" => $row["nombre_lin"],
                    "serviciotecnico" => $row["serviciotecnico_lin"]
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

if ($accion == "Eliminar") {
    try {
        $obj = new ClsLinea();
        $codigo = $_POST['codigo'];
        $rsql = $obj->Eliminar($codigo, 0);
        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "rpta" => $row["Respuesta"],
                    "msj" => $row["Mensaje"],
                ));
            }
        } else {
            array_push($data, array(
                "rpta" => "0",
                "msj" => "No se pudo realizar la operación",
            ));
        }
        echo json_encode($data);
    } catch (Exception $e) {
        echo $e->getMessage();
    }
}

if ($accion == "ListarTodos") {
    try {
        $obj = new ClsLinea();
        $rsql = $obj->Listar('T', 0);

        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["codigo_lin"],
                    "nombre" => $row["nombre_lin"],
                    "serviciotecnico" => $row["serviciotecnico_lin"]
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