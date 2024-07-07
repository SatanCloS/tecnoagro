<?php

require_once('../cado/ClsTipoCambio.php');

session_start();
if (!empty($_POST['accion'])) {
    $accion = $_POST['accion'];
}

if ($accion == "Listar") {
    try {
        $codigo_anio = $_POST['cboAnio']; 
        $codigo_mes = $_POST['cboMes']; 
        
        $obj = new ClsTipoCambio();
        $rsql = $obj->Listar('L', '0', $codigo_anio, $codigo_mes);
        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["codigo_tic"],
                    "fecha" => $row["fecha_tic"],
                    "cambioCompra" => $row["cambioCompra_tic"],
                    "cambioVenta" => $row["cambioVenta_tic"]                    
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
        $obj = new ClsTipoCambio();
        $codigo = $_POST['hdcod'];
        $fecha = $_POST['txtfecha'];
        $cambioCompra = $_POST['txtCambioCompra'];
        $cambioVenta = $_POST['txtCambioVenta'];
        $usuario = 0;

        $rsql = $obj->Actualizar($codigo, $fecha, $cambioCompra, $cambioVenta, $usuario);
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
        $obj = new ClsTipoCambio();
        if (!empty($_POST['codigo'])) {
            $id = $_POST['codigo'];
        }
        $rsql = $obj->Listar('E', $id,0,0);
        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["codigo_tic"],
                    "fecha" => $row["fecha_tic"],
                    "cambioCompra" => $row["cambioCompra_tic"],
                    "cambioVenta" => $row["cambioVenta_tic"]                    
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
        $obj = new ClsTipoCambio();
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

if ($accion == "ListarAnio") {
    try {
        $obj = new ClsTipoCambio();
        $rsql = $obj->Listar('A', 0, 0, 0);

        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["id"],
                    "nombre" => $row["anio"]                 
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

if ($accion == "ListarMes") {
    try {
        $anio = $_POST['cboAnio']; 

        $obj = new ClsTipoCambio();
        $rsql = $obj->Listar('M', 0, $anio, 0);

        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["id"],
                    "nombre" => $row["nombreMes"]                 
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


if ($accion == "ObtenerTipoCambio") {
    try {
        $tipo = $_POST['tipo']; 
        $fecha = $_POST['fecha']; 
       
        $obj = new ClsTipoCambio();
        $rsql = $obj->ObtenerTipoCambio($tipo, $fecha);

        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "tipocambio" => $row["tipocambio"]
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