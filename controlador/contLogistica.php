<?php

require_once('../cado/ClsLogistica.php');

session_start();
if (!empty($_POST['accion'])) {
    $accion = $_POST['accion'];    
}

if ($accion == "InventarioFisico") {
    try {
        //echo var_dump($data);
        $obj = new ClsLogistica();
        $hasta = $_POST['txtHasta'];
        $codigo_lin = $_POST['cboLinea'];
        $codigo_suc = $_POST['cboSucursal'];
        $rsql = $obj->InventarioFisico($hasta, $codigo_lin, $codigo_suc);
        //echo var_dump($rsql);

        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["codigo_art"],
                    "articulo" => $row["nombre_art"],
                    "unidadm" => $row["unidadm_art"],
                    "linea" => $row["nombre_lin"],
                    "stock" => $row["stock"]
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


if ($accion == "KardexFisico") {
    try {
        //echo var_dump($data);
        $obj = new ClsLogistica();
        $desde = $_POST['txtDesde'];
        $hasta = $_POST['txtHasta'];
        $codigo_art = $_POST['cboArticulo'];
        $codigo_suc = $_POST['cboSucursal'];
        $rsql = $obj->KardexFisico($desde, $hasta, $codigo_art, $codigo_suc);
        //echo var_dump($rsql);

        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "fecha" => $row["fecha"],
                    "documento" => $row["documento"],
                    "cliprov" => $row["cliprov"],
                    "ingreso" => $row["ingreso"],
                    "salida" => $row["salida"],
                    "saldo" => $row["saldo"],
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