<?php

require_once('../cado/ClsTipoDocumento.php');

session_start();
if (!empty($_POST['accion'])) {
    $accion = $_POST['accion'];  
    $accionBuscar = $_POST['accionBuscar'];  
    $tipo = $_POST['tipo'];  
    $codigo_suc = $_POST['codigo_suc'];  
}

if ($accion == "Listar") {
    try {
        $obj = new ClsTipoDocumento();
        $rsql = $obj->Listar($accionBuscar, 0, $tipo);

        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["codigo_tdo"],
                    "nombre" => $row["nombre_tdo"],
                    "abreviatura_tdo" => $row["abreviatura_tdo"],
                    "codigosunat_tdo" => $row["codigosunat_tdo"],
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
        $obj = new ClsTipoDocumento();
        // $codigo_tdoc = 4; /* RUC */
        $codigo = $_POST['hdcod'];
        $nombre = $_POST['txtNombre'];
        $abreviatura_tdo = $_POST['txtAbreviatura_tdo'];
        $codigosunat_tdo = $_POST['txtCodigoSunat_tdo'];
        
        $Compra = ($_POST['chkCompra'] == 1) ? 'I' : '';
        $Venta = ($_POST['chkVenta'] == 1) ? 'S' : '';
        $Cliente = ($_POST['chkCliente'] == 1) ? 'C' : '';
        $Proveedor = ($_POST['chkProveedor'] == 1) ? 'P' : '';
        $tipo = $Compra . $Venta . $Cliente . $Proveedor;
     
        //$rsql = $obj->Actualizar($codigo,$codigo_tdoc,$nrodoc,$nombre,$abreviatura,$direccion,$tipo,$codigo_dis,$_SESSION['cusu']);
        //$rsql = $obj->Actualizar($codigo, $nombre, $abreviatura, $_SESSION['cdusu']);
        $rsql = $obj->Actualizar($codigo, $nombre, $abreviatura_tdo, $codigosunat_tdo, $tipo, 0);
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
        $obj = new ClsTipoDocumento();
        if (!empty($_POST['codigo'])) {
            $id = $_POST['codigo'];
        }
        $rsql = $obj->Listar('E', $id, '');
        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["codigo_tdo"],
                    "nombre" => $row["nombre_tdo"],
                    "abreviatura_tdo" => $row["abreviatura_tdo"],
                    "codigosunat_tdo" => $row["codigosunat_tdo"],
                    "tipo" => $row["tipo_tdo"]
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
        $obj = new ClsTipoDocumento();
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


if ($accion == "ObtenerNrotransferencia") {
    try {
        $obj = new ClsTipoDocumento();
        $rsql = $obj->ObtenerNrotransferencia($tipo, $codigo_suc);

        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "recibo" => $row["recibo"]
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