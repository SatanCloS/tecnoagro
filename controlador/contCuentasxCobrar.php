<?php

require_once('../cado/ClsCuentasxCobrar.php');

session_start();
if (!empty($_POST['accion'])) {
    $accion = $_POST['accion'];    
}

if ($accion == "Listar") {
    try {
        //echo var_dump($data);
        $obj = new ClsCuentasxCobrar();
        $fecha_ini = $_POST['txtFecha_ini'];
        $fecha_fin = $_POST['txtFecha_fin'];
        $codigo_cli = $_POST['cboCliente'];
        $codigo_suc = $_POST['cboSucursal'];

        //$rsql = $obj->Listar($fecha_ini, $fecha_fin, $codigo_pro, $codigo_suc);
        $rsql = $obj->Listar('L', 0, $fecha_ini, $fecha_fin, $codigo_cli, $codigo_suc);
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
                    "importe_moc" => $row["importe_moc"]
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
        $obj = new ClsCuentasxCobrar();
        
        $codigo = $_POST['hdcod'];
        $codigo_suc = $_POST['txtCodigo_suc'];
        $codigo_tdo = $_POST['txtCodigo_tdo'];
        $serie_moc = $_POST['txtSerie_moc'];
        $numero_moc = $_POST['txtNumero_moc'];
        $codigo_cli = $_POST['txtCodigo_cli'];
        $fecha_moc = $_POST['txtfecha_moc'];
        $importe_moc = $_POST['txtImporte_moc'];
        $fechaVencimiento_moc = $_POST['txtFechaVencimiento_moc'];
        $codigo_mon = $_POST['txtCodigo_mon'];
        $detalle_moc = $_POST['txtObservacion_moc'];
        $dolar_moc = 3.00;
        $codigo_ven = 1;
             
        $rsql = $obj->Actualizar($codigo, $codigo_suc, $codigo_tdo, $serie_moc, $numero_moc, $codigo_cli, 
                                $fecha_moc, $importe_moc, $fechaVencimiento_moc, $codigo_mon, $detalle_moc, 
                                $dolar_moc, $codigo_ven, 0);
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
        $obj = new ClsCuentasxCobrar();
        if (!empty($_POST['codigo'])) {
            $id = $_POST['codigo'];
        }

        $rsql = $obj->Listar('E', $id,'', '','', '');
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



if ($accion == "Eliminar") {
    try {
        $obj = new ClsCuentasxCobrar();
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