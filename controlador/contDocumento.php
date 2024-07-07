<?php

require_once('../cado/ClsDocumento.php');

session_start();
if (!empty($_POST['accion'])) {
    $accion = $_POST['accion'];    
}

if ($accion == "Listar") {
    try {
        $obj = new ClsDocumento();
        $rsql = $obj->Listar('L', 0);

        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["codigo_doc"],
                    "nombre" => $row["nombre_doc"],
                    "codigosunat" => $row["codigosunat_doc"]
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
        $obj = new ClsDocumento();
        // $codigo_tdoc = 4; /* RUC */
        $codigo = $_POST['hdcod'];
        $nombre = $_POST['txtNombre'];
        $codigosunat = $_POST['txtCodigoSunat'];
        
        //$rsql = $obj->Actualizar($codigo,$codigo_tdoc,$nrodoc,$nombre,$abreviatura,$direccion,$tipo,$codigo_dis,$_SESSION['cusu']);
        //$rsql = $obj->Actualizar($codigo, $nombre, $abreviatura, $_SESSION['cdusu']);
        $rsql = $obj->Actualizar($codigo, $nombre, $codigosunat, 0);
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
        $obj = new ClsDocumento();
        if (!empty($_POST['codigo'])) {
            $id = $_POST['codigo'];
        }
        $rsql = $obj->Listar('E', $id);
        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["codigo_doc"],
                    "nombre" => $row["nombre_doc"],
                    "codigosunat" => $row["codigosunat_doc"]           
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
        $obj = new ClsDocumento();
        $codigo = $_POST['codigo'];
        //$rsql = $obj->Eliminar($codigo, $_SESSION['cdusu']);
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

?>