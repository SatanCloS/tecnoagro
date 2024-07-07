<?php

require_once('../cado/ClsArticulo.php');

session_start();
if (!empty($_POST['accion'])) {
    $accion = $_POST['accion'];    
}
 
if ($accion == "Listar") {
    try {
        $obj = new ClsArticulo();
        $rsql = $obj->Listar('L', 0);

        console.log($rsql);

        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["codigo_art"],
                    "nombre" => $row["nombre_art"],
                    "abreviatura" => $row["abreviatura_art"],
                    "codigobarra" => $row["codigobarra_art"],
                    "codigoproveedor" => $row["codigoproveedor_art"],
                    "marca" => $row["nombre_mar"],
                    "linea" => $row["nombre_lin"],
                    "unidadm" => $row["unidadm_art"],
                    "costo" => $row["costo_art"],
                    "precio" => $row["precio_art"],
                    "preciomayorista" => $row["preciomayorista_art"],                    
                    "stkmin" => $row["stockmin_art"],
                    "stkmax" => $row["stockmax_art"]                 
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
        $obj = new ClsArticulo();

        $codigo = $_POST['hdcod'];
        $nombre = $_POST['txtNombre'];
        $abreviatura = $_POST['txtAbreviatura'];
        $codigoBarras = $_POST['txtCodigoBarras'];
        $codigoProveedor = $_POST['txtCodigoProveedor'];
        $marca = $_POST['cboMarca'];
        $linea = $_POST['cboLinea'];
        $unidadm = $_POST['txtUnidadm'];
        $tipoImpuesto = $_POST['cboTipoImpuesto'];
        $precio = $_POST['txtPrecio'];
        $precioMayorista = $_POST['txtPrecioMayorita'];
        $stockmin = $_POST['txtStkMin'];
        $stockmax = $_POST['txtStkMax'];

        //$rsql = $obj->Actualizar($codigo, $nombre, $abreviatura, $_SESSION['cdusu']);
        $rsql = $obj->Actualizar($codigo,$nombre,$abreviatura,$codigoBarras,$codigoProveedor,$marca,$linea,
                                    $unidadm,$tipoImpuesto,$precio,$precioMayorista,$stockmin,$stockmax,0);
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
        $obj = new ClsArticulo();
        if (!empty($_POST['codigo'])) {
            $id = $_POST['codigo'];
        }
        $rsql = $obj->Listar('E', $id);
        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["codigo_art"],
                    "nombre" => $row["nombre_art"],
                    "abreviatura" => $row["abreviatura_art"],
                    "codigobarra" => $row["codigobarra_art"],
                    "codproveedor" => $row["codigoproveedor_art"],
                    "codmarca" => $row["codigo_mar"], 
                    "codlinea" => $row["codigo_lin"], 
                    "unidadm" => $row["unidadm_art"],
                    "tipoimpuesto" => $row["tipoimpuesto_art"],
                    "costo" => $row["costo_art"],
                    "precio" => $row["precio_art"],
                    "costogasto" => $row["costogasto_art"],
                    "preciomayorista" => $row["preciomayorista_art"],
                    "stockmin" => $row["stockmin_art"],
                    "stockmax" => $row["stockmax_art"]                    
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
        $obj = new ClsArticulo();
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