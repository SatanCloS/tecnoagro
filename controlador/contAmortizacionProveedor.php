<?php

require_once('../cado/ClsAmortizacionProveedor.php');

session_start();
if (!empty($_POST['accion'])) {
    $accion = $_POST['accion'];    
}

if ($accion == "Listar") {
    try {
        //echo var_dump($data);
        $obj = new ClsAmortizacionProveedor();
        $tipo = $_POST['cboTipo'];
        $fecha_ini = $_POST['txtFecha_ini'];
        $fecha_fin = $_POST['txtFecha_fin'];
        $codigo_pro = $_POST['cboProveedor'];
        $codigo_suc = $_POST['cboSucursal'];

        $rsql = $obj->Listar($tipo, 0, $fecha_ini, $fecha_fin, $codigo_pro, $codigo_suc);
        $data = array();
        //echo var_dump($data);

        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["codigo_mop"],
                    "fecha_mop" => $row["fecha_mop"],
                    "documento" => $row["documento"],
                    "nombre_pro" => $row["nombre_pro"],
                    "moneda" => $row["moneda"],
                    "importe_mop" => $row["importe_mop"],
                    "pago_mop" => $row["pago_mop"],
                    "saldo_mop" => $row["saldo_mop"],
                    "tipo" => $row["tipo_mop"]
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
        $obj = new ClsAmortizacionProveedor();
        
        $codigo = $_POST['hdcod'];
        $codigo_suc = $_POST['cboSucursal_reg'];
        $codigo_tdo = $_POST['hdcodigo_tdo'];
        $serie_mop = $_POST['hdnumero_ser'];
        $numero_mop = $_POST['hdnumero_doc'];
        $codigo_pro = $_POST['txtCodigo_pro'];
        $fecha_mop = $_POST['txtfecha_mop'];
        $importe_mop = $_POST['txtImporte_mop'];        
        $codigo_cta = $_POST['cboCuenta_reg'];
        $recibo = $_POST['txtRecibo_reg'];
        $codigo_mon = $_POST['txtCodigo_mon'];
        $detalle_mop = $_POST['txtObservacion_mop'];
        $dolar_mop = $_POST['txtDolar_reg'];
        $codigo_ven = 1;
        $referencia = $_POST['hdreferencia'];
        $usuario = 0;

        $rsql = $obj->Actualizar($codigo, $codigo_suc, $codigo_tdo, $serie_mop, $numero_mop, $codigo_pro, 
                                $fecha_mop, $importe_mop, $codigo_cta, $recibo, $codigo_mon, $detalle_mop, 
                                $dolar_mop, $codigo_ven, $referencia, $usuario);
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
        $obj = new ClsAmortizacionProveedor();
        if (!empty($_POST['codigo'])) {
            $id = $_POST['codigo'];
        }

        $rsql = $obj->Listar('ED', $id,'', '','', '');
        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["codigo_mop"],
                    "codigo_suc" => $row["codigo_suc"],
                    "sucursal" => $row["nombre_suc"],
                    "codigo_tdo" => $row["codigo_tdo"],
                    "documento" => $row["nombre_tdo"],
                    "serie_mop" => $row["serie_mop"],
                    "numero_mop" => $row["numero_mop"],
                    "codigo_pro" => $row["codigo_pro"],
                    "proveedor" => $row["nombre_pro"],                    
                    "fecha_mop" => $row["fecha_mop"],  
                    "importe_mop" => $row["importe_mop"],  
                    "saldo_mop" => $row["saldo_mop"], 
                    "fechaVencimiento_mop" => $row["fechaVencimiento_mop"],  
                    "codigo_mon" => $row["codigo_mon"],
                    "moneda" => $row["nombre_mon"],    
                    "detalle_mop" => $row["detalle_mop"],    
                    "dolar_mop" => $row["dolar_mop"],   
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
        $obj = new ClsAmortizacionProveedor();
        if (!empty($_POST['codigo'])) {
            $id = $_POST['codigo'];
        }

        $rsql = $obj->Listar('EP', $id,'', '','', '');
        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["codigo_mop"],
                    "fecha_mop" => $row["fecha_mop"],  
                    "codigo_suc" => $row["codigo_suc"],
                    "codigo_cta" => $row["codigo_cta"],
                    "codigo_mon" => $row["codigo_mon"],
                    "moneda" => $row["moneda"],
                    "codigo_ban" => $row["codigo_ban"],
                    "banco" => $row["banco"],
                    "recibo_mop" => $row["recibo_mop"],
                    "dolar_mop" => $row["dolar_mop"],
                    "codigo_pro" => $row["codigo_pro"],
                    "proveedor" => $row["proveedor"],
                    "importe_mop" => $row["importe_mop"],  
                    "saldo_mop" => $row["saldo_mop"], 
                    "detalle_mop" => $row["detalle_mop"],    
                    "codigo_ven" => $row["codigo_ven"], 
                    "codigo_tdo" => $row["codigo_tdo"],
                    "serie_mop" => $row["serie_mop"],
                    "numero_mop" => $row["numero_mop"],
                    "referencia_mop" => $row["referencia_mop"], 
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
        $obj = new ClsAmortizacionProveedor();
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