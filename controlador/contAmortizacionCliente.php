<?php

require_once('../cado/ClsAmortizacionCliente.php');

session_start();
if (!empty($_POST['accion'])) {
    $accion = $_POST['accion'];    
}

if ($accion == "Listar") {
    try {
        //echo var_dump($data);
        $obj = new ClsAmortizacionCliente();
        $tipo = $_POST['cboTipo'];
        $fecha_ini = $_POST['txtFecha_ini'];
        $fecha_fin = $_POST['txtFecha_fin'];
        $codigo_cli = $_POST['cboCliente'];
        $codigo_suc = $_POST['cboSucursal'];

        $rsql = $obj->Listar($tipo, 0, $fecha_ini, $fecha_fin, $codigo_cli, $codigo_suc);
        $data = array();
        //echo var_dump($data);

        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["codigo_moc"],
                    "fecha_moc" => $row["fecha_moc"],
                    "documento" => $row["documento"],
                    "nombre_cli" => $row["nombre_cli"],
                    "moneda" => $row["moneda"],
                    "importe_moc" => $row["importe_moc"],
                    "pago_moc" => $row["pago_moc"],
                    "saldo_moc" => $row["saldo_moc"],
                    "tipo" => $row["tipo_moc"]
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
        $obj = new ClsAmortizacionCliente();
        
        $codigo = $_POST['hdcod'];
        $codigo_suc = $_POST['cboSucursal_reg'];
        $codigo_tdo = $_POST['hdcodigo_tdo'];
        $serie_moc = $_POST['hdnumero_ser'];
        $numero_moc = $_POST['hdnumero_doc'];
        $codigo_cli = $_POST['txtCodigo_cli'];
        $fecha_moc = $_POST['txtfecha_moc'];
        $importe_moc = $_POST['txtImporte_moc'];        
        $codigo_cta = $_POST['cboCuenta_reg'];
        $recibo = $_POST['txtRecibo_reg'];
        $codigo_mon = $_POST['txtCodigo_mon'];
        $detalle_moc = $_POST['txtObservacion_moc'];
        $dolar_moc = $_POST['txtDolar_reg'];
        $codigo_ven = 1;
        $referencia = $_POST['hdreferencia'];
        $usuario = 0;

        $rsql = $obj->Actualizar($codigo, $codigo_suc, $codigo_tdo, $serie_moc, $numero_moc, $codigo_cli, 
                                $fecha_moc, $importe_moc, $codigo_cta, $recibo, $codigo_mon, $detalle_moc, 
                                $dolar_moc, $codigo_ven, $referencia, $usuario);
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



if ($accion == "EditarDeuda") {
    try {
        $obj = new ClsAmortizacionCliente();
        if (!empty($_POST['codigo'])) {
            $id = $_POST['codigo'];
        }

        $rsql = $obj->Listar('ED', $id,'', '','', '');
        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["codigo_moc"],
                    "codigo_suc" => $row["codigo_suc"],
                    "sucursal" => $row["nombre_suc"],
                    "codigo_tdo" => $row["codigo_tdo"],
                    "documento" => $row["nombre_tdo"],
                    "serie_moc" => $row["serie_moc"],
                    "numero_moc" => $row["numero_moc"],
                    "codigo_cli" => $row["codigo_cli"],
                    "cliente" => $row["nombre_cli"],                    
                    "fecha_moc" => $row["fecha_moc"],  
                    "importe_moc" => $row["importe_moc"],  
                    "saldo_moc" => $row["saldo_moc"], 
                    "fechaVencimiento_moc" => $row["fechaVencimiento_moc"],  
                    "codigo_mon" => $row["codigo_mon"],
                    "moneda" => $row["nombre_mon"],    
                    "detalle_moc" => $row["detalle_moc"],    
                    "dolar_moc" => $row["dolar_moc"],   
                    "codigo_ven" => $row["codigo_ven"]
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


if ($accion == "EditarPago") {
    try {
        $obj = new ClsAmortizacionCliente();
        if (!empty($_POST['codigo'])) {
            $id = $_POST['codigo'];
        }

        $rsql = $obj->Listar('EP', $id,'', '','', '');
        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["codigo_moc"],
                    "fecha_moc" => $row["fecha_moc"],  
                    "codigo_suc" => $row["codigo_suc"],
                    "codigo_cta" => $row["codigo_cta"],
                    "codigo_mon" => $row["codigo_mon"],
                    "moneda" => $row["moneda"],
                    "codigo_ban" => $row["codigo_ban"],
                    "banco" => $row["banco"],
                    "recibo_moc" => $row["recibo_moc"],
                    "dolar_moc" => $row["dolar_moc"],
                    "codigo_cli" => $row["codigo_cli"],
                    "cliente" => $row["cliente"],
                    "importe_moc" => $row["importe_moc"],  
                    "saldo_moc" => $row["saldo_moc"], 
                    "detalle_moc" => $row["detalle_moc"],    
                    "codigo_ven" => $row["codigo_ven"], 
                    "codigo_tdo" => $row["codigo_tdo"],
                    "serie_moc" => $row["serie_moc"],
                    "numero_moc" => $row["numero_moc"],
                    "referencia_moc" => $row["referencia_moc"], 
                    "importe_ref" => $row["importe_ref"], 
                    "saldo_ref" => $row["saldo_ref"] 
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
        $obj = new ClsAmortizacionCliente();
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

?>