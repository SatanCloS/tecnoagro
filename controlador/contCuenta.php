<?php

require_once('../cado/ClsCuenta.php');

session_start();
if (!empty($_POST['accion'])) {
    $accion = $_POST['accion'];    
    $accionBuscar = $_POST['accionBuscar'];  
    $codigo_suc = $_POST['codigo_suc'];  

    $tipo = $_POST['tipo'];  
    $codigo_cta = $_POST['codigo_cta'];  
     
}

if ($accion == "Listar") {
    try {
        $obj = new ClsCuenta();
        $rsql = $obj->Listar($accionBuscar, 0, $codigo_suc);

        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["codigo_cta"],
                    "nombre" => $row["nombre_cta"],
                    "abreviatura_mon" => $row["abreviatura_mon"],
                    "nombre_ban" => $row["nombre_ban"],
                    "titular_cta" => $row["titular_cta"],
                    "nombre_suc" => $row["nombre_suc"]
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
        $obj = new ClsCuenta();
        
        $codigo = $_POST['hdcod'];
        $nombre = $_POST['txtNombre'];
        $titular_cta = $_POST['txtTitular_cta'];
        $codigo_ban = $_POST['cboBanco'];
        $codigo_mon = $_POST['cboMoneda'];        
        $codigo_suc = $_POST['cboSucursal'];


        $rsql = $obj->Actualizar($codigo, $nombre, $codigo_ban, $codigo_mon, $titular_cta, $codigo_suc, 0);
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
        $obj = new ClsCuenta();
        if (!empty($_POST['codigo'])) {
            $id = $_POST['codigo'];
        }
        //$rsql = $obj->Listar('E', $id);
        $rsql = $obj->Listar('E', $id, $codigo_suc);
        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["codigo_cta"],
                    "nombre" => $row["nombre_cta"],
                    "titular_cta" => $row["titular_cta"],  
                    "codigo_mon" => $row["codigo_mon"],
                    // "nombre_mon" => $row["nombre_mon"],
                    "codigo_ban" => $row["codigo_ban"],                    
                    // "nombre_ban" => $row["nombre_ban"],                      
                    "codigo_suc" => $row["codigo_suc"],  
                    // "nombre_suc" => $row["nombre_suc"],    
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
        $obj = new ClsCuenta();
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

if ($accion == "Listartodos") {
    try {
        $obj = new ClsCuenta();
        $rsql = $obj->Listar('T', 0, 0);

        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["codigo_cta"],
                    "nombre" => $row["nombre_cta"],
                    "abreviatura_mon" => $row["abreviatura_mon"],
                    "nombre_ban" => $row["nombre_ban"],
                    "titular_cta" => $row["titular_cta"],
                    "nombre_suc" => $row["nombre_suc"]
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

if ($accion == "ObtenerNroRecibo") {
    try {
        $obj = new ClsCuenta();
        $rsql = $obj->ObtenerNroRecibo($tipo, $codigo_cta);

        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "recibo" => $row["recibo"]
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

if ($accion == "ListadoCuentas") {
    try {
        $obj = new ClsCuenta();
        $rsql = $obj->Listar($accionBuscar, $codigo_cta, 0);

        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["codigo_cta"],
                    "nombre" => $row["nombre_cta"],
                    "abreviatura_mon" => $row["abreviatura_mon"],
                    "nombre_ban" => $row["nombre_ban"],
                    "titular_cta" => $row["titular_cta"],
                    "nombre_suc" => $row["nombre_suc"]
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


if ($accion == "ObtenerDatosCuenta") {
    try {
        $obj = new ClsCuenta();
        if (!empty($_POST['codigo'])) {
            $id = $_POST['codigo'];
        }
        //$rsql = $obj->Listar('E', $id);
        $rsql = $obj->Listar('LBM', $id, $codigo_suc);
        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo_mon" => $row["codigo_mon"],
                    "nombre_mon" => $row["nombre_mon"],
                    "codigo_ban" => $row["codigo_ban"],                    
                    "nombre_ban" => $row["nombre_ban"]
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



if ($accion == "ObtenerSucursalDestino") {
    try {
        $obj = new ClsCuenta();
        if (!empty($_POST['codigo'])) {
            $id = $_POST['codigo'];
        }
        $rsql = $obj->Listar('LSD', $id, 0);
        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo_suc" => $row["codigo_suc"],
                    "nombre_suc" => $row["nombre_suc"]
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