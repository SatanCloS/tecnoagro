<?php

require_once('../cado/ClsGerencial.php');

session_start();
if (!empty($_POST['accion'])) {
    $accion = $_POST['accion'];    
}


if ($accion == "kardex_valorado") {
    try {
        //echo var_dump($data);
        $obj = new ClsGerencial();
        $desde = $_POST['txtDesde'];
        $hasta = $_POST['txtHasta'];
        $codigo_art = $_POST['cboArticulo'];
        $codigo_suc = $_POST['cboSucursal'];
        $rsql = $obj->kardex_valorado($desde, $hasta, $codigo_art, $codigo_suc);
        //echo var_dump($rsql);

        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "fecha" => $row["fecha_cpr"],
                    "documento" => $row["documento_cpr"],
                    "persona" => $row["persona"],
                    "s_ingreso" => $row["s_ingreso"],
                    "s_salida" => $row["s_salida"],
                    "s_saldo" => $row["s_saldo"],
                    "precio" => $row["precio"],
                    "costoPromedio" => $row["costoPromedio"],
                    "entrada" => $row["entrada"],
                    "salida" => $row["salida"],
                    "saldo" => $row["saldo"]          
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



if ($accion == "inventario_valorado") {
    try {
        //echo var_dump($data);
        $obj = new ClsGerencial();
        $fecha = $_POST['txtFecha'];
        $codigo_suc = $_POST['cboSucursal'];
        $rsql = $obj->inventario_valorado($fecha, $codigo_suc);
        //echo var_dump($rsql);

        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "linea" => $row["linea"],
                    "articulo" => $row["articulo"],
                    "medida" => $row["medida"],
                    "stock" => $row["stock"],
                    "costo" => $row["costo"]       
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



if ($accion == "utilidadDetallada") {
    try {
        //echo var_dump($data);
        $obj = new ClsGerencial();
        $desde = $_POST['txtDesde'];
        $hasta = $_POST['txtHasta'];
        $codigo_suc = $_POST['cboSucursal'];
        $rsql = $obj->utilidadDetallada($desde, $hasta, $codigo_suc);
        //echo var_dump($rsql);

        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "fecha" => $row["fecha_vta"],
                    "documento" => $row["documento_cpr"],
                    "persona" => $row["cliente"],
                    "cantidad" => $row["cantidad_vde"],
                    "undidad" => $row["unidadm_art"],
                    "precio" => $row["precio"],
                    "importe" => $row["importe"],
                    "costo" => $row["costo"],
                    "utilidad" => $row["utilidad"],
                    "articulo" => $row["articulo"],
                    "linea" => $row["nombre_lin"]          
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



if ($accion == "utilidadResumida") {
    try {
        //echo var_dump($data);
        $obj = new ClsGerencial();
        $desde = $_POST['txtDesde'];
        $hasta = $_POST['txtHasta'];
        $codigo_suc = $_POST['cboSucursal'];
        $tipo = 1;
        $rsql = $obj->utilidadResumida($desde, $hasta, $codigo_suc, $tipo);
        //echo var_dump($rsql);

        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["codigo_art"],
                    "articulo" => $row["articulo"],
                    "cantidad" => $row["cantidad"],
                    "importe" => $row["importe"],
                    "costo" => $row["costo"],
                    "utilidad" => $row["utilidad"],
                    "linea" => $row["linea"]          
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



if ($accion == "egp") {
    try {
        //echo var_dump($data);
        $obj = new ClsGerencial();
        $desde = $_POST['txtDesde'];
        $hasta = $_POST['txtHasta'];
        $codigo_suc = $_POST['cboSucursal'];
        $rsql = $obj->egp($desde, $hasta, $codigo_suc);
        //echo var_dump($rsql);

        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "tipo" => $row["tipo"],
                    "id" => $row["id"],
                    "rubro" => $row["rubro"],
                    "grupo" => $row["grupo"],
                    "concepto" => $row["concepto"],
                    "importe" => $row["importe"]          
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