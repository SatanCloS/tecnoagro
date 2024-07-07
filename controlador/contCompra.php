<?php

require_once('../cado/ClsCompra.php');

session_start();
if (!empty($_POST['accion'])) {
    $accion = $_POST['accion'];    
}

if ($accion == "Listar") {
    try {
        //echo var_dump($data);
        $obj = new ClsCompra();
        $fecha_ini = $_POST['txtFecha_ini'];
        $fecha_fin = $_POST['txtFecha_fin'];
        $codigo_pro = $_POST['cboProveedor'];
        $codigo_suc = $_POST['cboSucursal'];

        //$rsql = $obj->Listar($fecha_ini, $fecha_fin, $codigo_pro, $codigo_suc);
        $rsql = $obj->Listar('L', 0, $fecha_ini, $fecha_fin, $codigo_pro, $codigo_suc);
        //echo var_dump($rsql);
        $data = array();
        if ($rsql) {
            while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
                array_push($data, array(
                    "codigo" => $row["codigo_com"],
                    "documento" => $row["documento"],
                    "fecha" => $row["fecha"],
                    "proveedor" => $row["proveedor"],
                    "condicion" => $row["condicion"],
                    "moneda" => $row["moneda"],
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



// if ($accion == "Actualizar") {
//     try {
//         $obj = new ClsCuentasxPagar();
        
//         $codigo = $_POST['hdcod'];
//         $codigo_suc = $_POST['txtCodigo_suc'];
//         $codigo_tdo = $_POST['txtCodigo_tdo'];
//         $serie_mop = $_POST['txtSerie_mop'];
//         $numero_mop = $_POST['txtNumero_mop'];
//         $codigo_pro = $_POST['txtCodigo_pro'];
//         $fecha_mop = $_POST['txtfecha_mop'];
//         $importe_mop = $_POST['txtImporte_mop'];
//         $fechaVencimiento_mop = $_POST['txtFechaVencimiento_mop'];
//         $codigo_mon = $_POST['txtCodigo_mon'];
//         $detalle_mop = $_POST['txtObservacion_mop'];
//         $dolar_mop = 3.00;
//         $codigo_ven = 1;
             
//         $rsql = $obj->Actualizar($codigo, $codigo_suc, $codigo_tdo, $serie_mop, $numero_mop, $codigo_pro, $fecha_mop, 
//                                 $importe_mop, $fechaVencimiento_mop, $codigo_mon, $detalle_mop, $dolar_mop, $codigo_ven, 0);
//         $data = array();
//         if ($rsql) {
//             while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
//                 array_push($data, array(
//                     "rpta" => $row["Respuesta"],
//                     "msj" => $row["Mensaje"],
//                 ));
//             }
//         } else {
//             array_push($data, array(
//                 "rpta" => "0",
//                 "msj" => "No se pudo realizar la operación",
//             ));
//         }
//         echo json_encode($data);
//     } catch (Exception $e) {
//         $json = $e->getMessage();
//         $data['data'] = $json;
//         echo json_encode($data);
//     }
// }


// if ($accion == "Editar") {
//     try {
//         $obj = new ClsCuentasxPagar();
//         if (!empty($_POST['codigo'])) {
//             $id = $_POST['codigo'];
//         }

//         $rsql = $obj->Listar('E', $id,'', '','', '');
//         $data = array();
//         if ($rsql) {
//             while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
//                 array_push($data, array(
//                     "codigo" => $row["codigo_mop"],
//                     "codigo_suc" => $row["codigo_suc"],
//                     "sucursal" => $row["nombre_suc"],
//                     "codigo_tdo" => $row["codigo_tdo"],
//                     "documento" => $row["nombre_tdo"],
//                     "serie_mop" => $row["serie_mop"],
//                     "numero_mop" => $row["numero_mop"],
//                     "codigo_pro" => $row["codigo_pro"],
//                     "proveedor" => $row["nombre_pro"],                    
//                     "fecha_mop" => $row["fecha_mop"],  
//                     "importe_mop" => $row["importe_mop"],  
//                     "fechaVencimiento_mop" => $row["fechaVencimiento_mop"],  
//                     "codigo_mon" => $row["codigo_mon"],
//                     "moneda" => $row["nombre_mon"],    
//                     "detalle_mop" => $row["detalle_mop"],    
//                     "dolar_mop" => $row["dolar_mop"],   
//                     "codigo_ven" => $row["codigo_ven"] 
//                  ));
//             }
//         } else {
//             $data = "";
//         }
//         echo json_encode($data);
//     } catch (Exception $e) {
//         $json = $e->getMessage();
//         $data['data'] = $json;
//         echo json_encode($data);
//     }
// }



// if ($accion == "Eliminar") {
//     try {
//         $obj = new ClsCuentasxPagar();
//         $codigo = $_POST['codigo'];
//         //$rsql = $obj->Eliminar($codigo, $_SESSION['cdusu']);
//         $rsql = $obj->Eliminar($codigo, 0);
//         $data = array();
//         if ($rsql) {
//             while ($row = $rsql->fetch(PDO::FETCH_NAMED)) {
//                 array_push($data, array(
//                     "rpta" => $row["Respuesta"],
//                     "msj" => $row["Mensaje"],
//                 ));
//             }
//         } else {
//             array_push($data, array(
//                 "rpta" => "0",
//                 "msj" => "No se pudo realizar la operación",
//             ));
//         }
//         echo json_encode($data);
//     } catch (Exception $e) {
//         echo $e->getMessage();
//     }
// }

?>