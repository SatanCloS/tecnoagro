<?php

require_once('../cado/clsMovimientoIngresoEgreso.php');

session_start();
if (!empty($_POST['accion'])) {
    $accion = $_POST['accion'];    
}

if ($accion == "Listar") {
    try {
        //echo var_dump($data);
        $obj = new clsMovimientoIngresoEgreso();
        $fecha_ini = $_POST['txtFecha_ini'];
        $fecha_fin = $_POST['txtFecha_fin'];
        $codigo_cta = $_POST['cboCuenta'];
        $codigo_suc = $_POST['cboSucursal'];

        $rsql = $obj->Listar($fecha_ini, $fecha_fin, $codigo_cta, $codigo_suc);
        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "fecha" => $row["fecha"],
                    "documento" => $row["documento"],
                    "persona" => $row["detalle"],
                    "ingreso" => $row["ingreso"],
                    "salida" => $row["salida"],
                    "saldo" => $row["saldo"],
                    "referencia" => $row["referencia"],
                    "fila" => $row["fila"],
                    "codigo" => $row["codigo"],
                    "tipo_mov" => $row["tipo_mov"],
                    "tabla" => $row["tabla"]                    
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
        $obj = new clsMovimientoIngresoEgreso();
        
        $codigo = $_POST['hdcod'];
        $codigo_suc = $_POST['cboSucursal_reg'];
        $codigo_pso = ($_POST['cboListaPersona'] == 1) ? $_POST['cboCliente_reg'] : (($_POST['cboListaPersona'] == 2) ? $_POST['cboProveedor_reg'] : null);
        $fecha = $_POST['txtFecha_reg'];
        $importe = $_POST['txtImporte'];
        $saldo = $_POST['txtImporte'];        
        
        //$tipo = $_POST['cboTipoMovimiento'] == 'I' ? 'P' : 'C';     
        if ($_POST['cboListaPersona'] == 0 || $_POST['cboListaPersona'] == 1) {
            $tipo = ($_POST['cboTipoMovimiento'] == 'I') ? 'P' : 'C';
        } else if ($_POST['cboListaPersona'] == 2) {
            $tipo = ($_POST['cboTipoMovimiento'] == 'E') ? 'C' : 'P';
        }
        $codigo_cta = $_POST['cboCuenta_reg'];
        $recibo = $_POST['txtRecibo_reg'];
        $codigo_mon = 1;
        $detalle = $_POST['txtObservacion_reg'];
        $codigo_con = $_POST['cboConcepto_reg'];
        $fechaVencimiento = $_POST['txtFecha_reg'];
        $dolar = 3;
        $codigo_ven = 1;
        $usuario = 0;
        $tipoMovimiento = $_POST['cboTipoMovimiento'];
        $persona =  $_POST['cboListaPersona'];

        $rsql = $obj->Actualizar($codigo, $codigo_suc, $codigo_pso, $fecha, $importe, $saldo, $tipo, 
                                $codigo_cta, $recibo, $codigo_mon, $detalle, $codigo_con, $fechaVencimiento, 
                                $dolar, $codigo_ven, $usuario, $tipoMovimiento, $persona);
        
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
        $obj = new clsMovimientoIngresoEgreso();
        if (!empty($_POST['codigo'])) {
            $id = $_POST['codigo'];
            $tipo_mov = $_POST['tipo_mov'];
            $tabla = $_POST['tabla'];
        }

        $rsql = $obj->Editar($id,$tipo_mov, $tabla);
        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["codigo"],
                    "tipo" => $row["tipo"],
                    "fecha" => $row["fecha"],
                    "codigo_suc" => $row["codigo_suc"],
                    "codigo_cta" => $row["codigo_cta"],
                    "recibo" => $row["recibo"],
                    "codigo_con" => $row["codigo_con"],
                    "importe" => $row["importe"],
                    "detalle" => $row["detalle"],
                    "direccionadoa" => $row["direccionadoa"],
                    "persona" => $row["persona"]
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
        $obj = new clsMovimientoIngresoEgreso();
        $codigo = $_POST['codigo'];
        $tabla = $_POST['tabla'];
     
        //$rsql = $obj->Eliminar($codigo, $_SESSION['cdusu']);
        $rsql = $obj->Eliminar($codigo, $tabla, 0);
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