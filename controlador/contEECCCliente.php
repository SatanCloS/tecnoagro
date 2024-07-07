<?php

require_once('../cado/ClsEECCCliente.php');

session_start();
if (!empty($_POST['accion'])) {
    $accion = $_POST['accion'];    
}

if ($accion == "EstadoCuentaCliente") {
    try {
        //echo var_dump($data);
        $obj = new ClsEECCCliente();
        $desde = $_POST['txtDesde'];
        $hasta = $_POST['txtHasta'];
        $codigo_cli = $_POST['cboCliente'];
        $codigo_suc = $_POST['cboSucursal'];
        $rsql = $obj->EstadoCuentaCliente($desde, $hasta, $codigo_cli, $codigo_suc);
        //echo var_dump($rsql);

        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "fecha" => $row["fecha"],
                    "documento" => $row["documento"],
                    "detalle" => $row["detalle"],
                    "ingreso_soles" => $row["ingreso_soles"],
                    "salida_soles" => $row["salida_soles"],
                    "saldo_soles" => $row["saldo_soles"],
                    "ingreso_dolar" => $row["ingreso_dolar"],
                    "salida_dolar" => $row["salida_dolar"],
                    "saldo_dolar" => $row["saldo_dolar"],
                    "fila" => $row["fila"]                    
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

if ($accion == "CuentasxCobrar") {
    try {
        //echo var_dump($data);
        $obj = new ClsEECCCliente();
        $hasta = $_POST['txtHasta'];
        $codigo_tip = $_POST['cboTipoPersona'];
        $codigo_suc = $_POST['cboSucursal'];
        $rsql = $obj->CuentasxCobrar($hasta, $codigo_tip, $codigo_suc);
        //echo var_dump($rsql);

        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo_cli" => $row["codigo_cli"],
                    "nombre_cli" => $row["nombre_cli"],
                    "direccion_cli" => $row["direccion_cli"],
                    "tipoPersona" => $row["tipoPersona"],
                    "saldoSoles" => $row["saldoSoles"],
                    "saldoDolar" => $row["saldoDolar"]             
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



if ($accion == "conceptoIndividual") {
    try {
        //echo var_dump($data);
        $obj = new ClsEECCCliente();
        $fecha_ini = $_POST['txtfecha_ini'];
        $fecha_fin = $_POST['txtfecha_fin'];
        $codigo_con = $_POST['cboConcepto'];
        $codigo_suc = $_POST['cboSucursal'];
        $rsql = $obj->conceptoIndividual($fecha_ini, $fecha_fin, $codigo_con, $codigo_suc);
        //echo var_dump($rsql);

        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "fecha" => $row["fecha_moc"],
                    "documento" => $row["documento"],
                    "detalle" => $row["detalle_moc"],
                    "ingreso" => $row["ingreso"],
                    "egreso" => $row["egreso"]                
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




if ($accion == "gastosDetallados") {
    try {
        //echo var_dump($data);
        $obj = new ClsEECCCliente();
        $fecha_ini = $_POST['txtfecha_ini'];
        $fecha_fin = $_POST['txtfecha_fin'];
        $codigo_suc = $_POST['cboSucursal'];
        $rsql = $obj->gastosDetallados($fecha_ini, $fecha_fin, $codigo_suc);
        //echo var_dump($rsql);

        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "grupoConcepto" => $row["grupoConcepto"],
                    "fecha" => $row["fecha_moc"],
                    "documento" => $row["documento"],
                    "concepto" => $row["concepto"],
                    "soles" => $row["soles"],
                    "dolares" => $row["dolares"],
                    "detalle" => $row["detalle"]                    
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



if ($accion == "saldosCuentas") {
    try {
        //echo var_dump($data);
        $obj = new ClsEECCCliente();
        $fecha_ini = $_POST['txtfecha_ini'];
        $codigo_suc = $_POST['cboSucursal'];
        $rsql = $obj->saldosCuentas($fecha_ini, $codigo_suc);
        //echo var_dump($rsql);

        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["codigo_cta"],
                    "cuenta" => $row["nombre_cta"],
                    "banco" => $row["banco"],
                    "soles" => $row["soles"],
                    "dolar" => $row["dolar"]                    
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

//cuentasporPagar
if ($accion == "cuentasporPagar") {
    try {
        //echo var_dump($data);
        $obj = new ClsEECCCliente();
        $fecha_fin = $_POST['txtfecha_fin'];
        $codigo_tip = $_POST['cboTipoPersona'];
        $codigo_suc = $_POST['cboSucursal'];
        $rsql = $obj->cuentasporPagar($fecha_fin, $codigo_tip, $codigo_suc);
        //echo var_dump($rsql);

        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["codigo"],
                    "proveedor" => $row["proveedor"],
                    "direccion" => $row["direccion"],
                    "soles" => $row["soles"],
                    "dolares" => $row["dolares"],
                    "sucursal" => $row["sucursal"]
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



if ($accion == "EstadoCuentaProveedor") {
    try {
        //echo var_dump($data);
        $obj = new ClsEECCCliente();
        $desde = $_POST['txtDesde'];
        $hasta = $_POST['txtHasta'];
        $codigo_pro = $_POST['cboProveedor'];
        $codigo_suc = $_POST['cboSucursal'];
        $rsql = $obj->EstadoCuentaProveedor($desde, $hasta, $codigo_pro, $codigo_suc);
        //echo var_dump($rsql);

        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "fecha" => $row["fecha"],
                    "documento" => $row["documento"],
                    "detalle" => $row["detalle"],
                    "ingreso_soles" => $row["ingreso_soles"],
                    "salida_soles" => $row["salida_soles"],
                    "saldo_soles" => $row["saldo_soles"],
                    "ingreso_dolar" => $row["ingreso_dolar"],
                    "salida_dolar" => $row["salida_dolar"],
                    "saldo_dolar" => $row["saldo_dolar"],
                    "fila" => $row["fila"]                    
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