<?php

require_once('../cado/clsTransferenciaCuentas.php');

session_start();
if (!empty($_POST['accion'])) {
    $accion = $_POST['accion'];    
}

if ($accion == "Listar") {
    try {
        //echo var_dump($data);
        $obj = new clsTransferenciaCuentas();
        $codigo_suc = $_POST['cboSucursal'];

        $rsql = $obj->Listar("L", 0, $codigo_suc);
        $data = array();
        //echo var_dump($data);
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["codigo_moc"],
                    "fecha_moc" => $row["fecha_moc"],
                    "recibo_moc" => $row["recibo_moc"],
                    "ctaOrigen" => $row["ctaOrigen"],
                    "ctaDestino" => $row["ctaDestino"],
                    "importe_moc" => $row["importe_moc"],
                    "detalle_moc" => $row["detalle_moc"] 
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
        $obj = new clsTransferenciaCuentas();
        
        $codigoOrigen = $_POST['hdcod'];
        $codigo_suc = $_POST['cboSucursal_reg'];
        $fecha = $_POST['txtFecha_reg'];
        $importe = $_POST['txtImporte'];
        $saldo = $_POST['txtImporte'];        
        $codigo_cta_origen = $_POST['cboCuentaOrigen_reg'];
        $codigo_cta_destino = $_POST['cboCuentaDestino_reg'];
        $recibo = $_POST['txtRecibo_reg'];
        $detalle = $_POST['txtObservacion_reg'];
        $fechaVencimiento = $_POST['txtFecha_reg'];
        $dolar = 3;
        $codigo_ven = 1;
        $usuario = 0;
        $codigoDestino = $_POST['txtcodigoDestino_reg'];
        $codigosuc_Destino = $_POST['hdsucursalDestino'];
        

             
        $rsql = $obj->Actualizar($codigoOrigen, $codigo_suc, $fecha, $importe, $saldo, $codigo_cta_origen, 
                                $codigo_cta_destino, $recibo, $detalle, $fechaVencimiento, $dolar, 
                                $codigo_ven, $codigoDestino, $codigosuc_Destino, $usuario);

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
        $obj = new clsTransferenciaCuentas();

        if (!empty($_POST['codigo'])) {
            $id = $_POST['codigo'];
            $codigo_suc = $_POST['cboSucursal'];
        }

        $rsql = $obj->Listar('E',$id,$codigo_suc);
        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["codigo_moc"],
                    "fecha" => $row["fecha_moc"],
                    "recibo" => $row["recibo_moc"],
                    "ctaOrigen" => $row["ctaOrigen"],
                    "ctaDestino" => $row["ctaDestino"],
                    "importe" => $row["importe_moc"],
                    "detalle" => $row["detalle_moc"],
                    "codigo_suc" => $row["codigo_suc"],
                    "codigoDestino" => $row["codigoDestino"],
                    "codigosuc_destino" => $row["codigosuc_destino"],
                    "sucursaldestino" => $row["sucursaldestino"]
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
        $obj = new clsTransferenciaCuentas();
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