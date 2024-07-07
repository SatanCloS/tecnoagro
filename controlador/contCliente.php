<?php

require_once('../cado/ClsCliente.php');

session_start();
if (!empty($_POST['accion'])) {
    $accion = $_POST['accion'];    
}

if ($accion == "Listar") {
    try {
        $obj = new ClsCliente();
        $rsql = $obj->Listar('L', 0);

        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["codigo_cli"],
                    "nombre" => $row["nombre_cli"],
                    "direccion_cli" => $row["direccion_cli"],
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
        $obj = new ClsCliente();
        
        $codigo = $_POST['hdcod'];
        $nombre_cli = $_POST['txtNombre_cli'];
        $direccion_cli = $_POST['txtDireccion_cli'];
        $ciudad_cli = $_POST['txtCiudad_cli'];
        $telefono_cli = $_POST['txtTelefono_cli'];
        $codigo_tip = $_POST['cboTipoPersona'];
        $codigo_doc = $_POST['cboDocumento'];
        $numero_doc = $_POST['txtNumero_doc'];
        $codigo_szo = 1;
        $email_cli = $_POST['txtCorreo_cli'];
        $observacion_cli = $_POST['txtObservacion_cli'];
        $codigo_dis = $_POST['cboDistrito'];
        $estadosunat_cli = $_POST['txtEstado_cli'];
        $condicionsunat_cli = $_POST['txtCondicion_cli'];
        $usuario = $_POST['txtNumero_doc'];
            
        $rsql = $obj->Actualizar($codigo, $nombre_cli, $direccion_cli, $ciudad_cli, $telefono_cli, $codigo_tip, $codigo_doc, $numero_doc, 
                                $codigo_szo, $email_cli, $observacion_cli, $codigo_dis, $estadosunat_cli, $condicionsunat_cli, $usuario);
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
        $obj = new ClsCliente();
        if (!empty($_POST['codigo'])) {
            $id = $_POST['codigo'];
        }
        $rsql = $obj->Listar('E', $id);
        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["codigo_cli"],
                    "nombre" => $row["nombre_cli"],
                    "direccion_cli" => $row["direccion_cli"],
                    "ciudad_cli" => $row["ciudad_cli"],
                    "telefono_cli" => $row["telefono_cli"],                    
                    "codigo_tip" => $row["codigo_tip"],  
                    "codigo_doc" => $row["codigo_doc"],  
                    "numero_doc" => $row["numero_doc"],   
                    "codigo_szo" => $row["codigo_szo"],   
                    "email_cli" => $row["email_cli"],   
                    "observacion_cli" => $row["observacion_cli"],   
                    "codigo_dis" => $row["codigo_dis"],   
                    "estadosunat_cli" => $row["estadosunat_cli"],   
                    "condicionsunat_cli" => $row["condicionsunat_cli"],   
                    "codigo_pro" => $row["codigo_pro"],
                    "codigo_dep" => $row["codigo_dep"] 
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
        $obj = new ClsCliente();
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
        $obj = new ClsCliente();
        $rsql = $obj->Listar('T', 0);

        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["codigo_cli"],
                    "nombre" => $row["nombre_cli"],
                    "direccion_cli" => $row["direccion_cli"],
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