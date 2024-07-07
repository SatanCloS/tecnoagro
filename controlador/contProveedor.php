<?php

require_once('../cado/ClsProveedor.php');

session_start();
if (!empty($_POST['accion'])) {
    $accion = $_POST['accion'];    
}

if ($accion == "Listar") {
    try {
        $obj = new ClsProveedor();
        $rsql = $obj->Listar('L', 0);

        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["codigo_pro"],
                    "nombre" => $row["nombre_pro"],
                    "direccion_pro" => $row["direccion_pro"],
                    "nombre_tip" => $row["nombre_tip"],
                    "nombre_doc" => $row["nombre_doc"],
                    "numero_doc" => $row["numero_doc"]
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
        $obj = new ClsProveedor();
        // $codigo_tdoc = 4; /* RUC */
        $codigo = $_POST['hdcod'];
        $nombre = $_POST['txtNombre'];
        $direccion_pro = $_POST['txtDireccion_pro'];
        $ciudad_pro = $_POST['txtCiudad_pro'];
        $telefono_pro = $_POST['txtTelefono_pro'];
        $codigo_tip = $_POST['cboTipoPersona'];
        $codigo_doc = $_POST['cboDocumento'];
        $numero_doc = $_POST['txtNumero_doc'];
        $observacion_pro = $_POST['txtObservacion_pro'];
        
        $rsql = $obj->Actualizar($codigo, $nombre, $direccion_pro, $ciudad_pro, $telefono_pro, $codigo_tip, $codigo_doc, $numero_doc, $observacion_pro, 0);
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
        $obj = new ClsProveedor();
        if (!empty($_POST['codigo'])) {
            $id = $_POST['codigo'];
        }
        $rsql = $obj->Listar('E', $id);
        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["codigo_pro"],
                    "nombre" => $row["nombre_pro"],
                    "direccion_pro" => $row["direccion_pro"],
                    "ciudad_pro" => $row["ciudad_pro"],
                    "telefono_pro" => $row["telefono_pro"],                    
                    "codigo_tip" => $row["codigo_tip"],  
                    // "nombre_tip" => $row["nombre_tip"],  
                    "codigo_doc" => $row["codigo_doc"],  
                    //"nombre_doc" => $row["nombre_doc"],    
                    "numero_doc" => $row["numero_doc"],   
                    "observacion_pro" => $row["observacion_pro"] 
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
        $obj = new ClsProveedor();
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


if ($accion == "ListarTodos") {
    try {
        $obj = new ClsProveedor();
        $rsql = $obj->Listar('T', 0);

        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["codigo_pro"],
                    "nombre" => $row["nombre_pro"],
                    "direccion_pro" => $row["direccion_pro"],
                    "nombre_tip" => $row["nombre_tip"],
                    "nombre_doc" => $row["nombre_doc"],
                    "numero_doc" => $row["numero_doc"]
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