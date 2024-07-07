<?php

require_once('conexion.php');

class ClsLogistica
{
    function InventarioFisico($hasta, $codigo_lin, $codigo_suc)
    {
        try {
            $ocado = new conexion();
            $sql = "call InventarioFisico(:hasta,:codigo_lin,:codigo_suc);";            
            //echo $sql;
            //echo var_dump($sql);
            $parametros = array(
                ':hasta' => $hasta,
                ':codigo_lin' => $codigo_lin,
                ':codigo_suc' => $codigo_suc,
            );
            $obj = $ocado->Ejecutar($sql, $parametros);
            return $obj;
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }

    function KardexFisico($desde, $hasta, $codigo_art, $codigo_suc)
    {
        try {
            $ocado = new conexion();
            $sql = "call kardexFisico(:desde,:hasta,:codigo_art,:codigo_suc);";     
            //echo $sql;
            //echo var_dump($sql);
            $parametros = array(
                ':desde' => $desde,
                ':hasta' => $hasta,
                ':codigo_art' => $codigo_art,
                ':codigo_suc' => $codigo_suc,
            );
            $obj = $ocado->Ejecutar($sql, $parametros);
            return $obj;
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }

    // function ListarCompraDetallada($tipo, $fecha_ini, $fecha_fin, $codigo_cod, $codigo_suc)
    // {
    //     try {
    //         $ocado = new conexion();
    //         $sql = "call ListarCompraDetallada(:tipo,:fecha_ini,:fecha_fin,:codigo_cod,:codigo_suc);";            
    //         //echo $sql;
    //         //echo var_dump($sql);
    //         $parametros = array(
    //             ':tipo' => $tipo,
    //             ':fecha_ini' => $fecha_ini,
    //             ':fecha_fin' => $fecha_fin,
    //             ':codigo_cod' => $codigo_cod,
    //             ':codigo_suc' => $codigo_suc,
    //         );
    //         $obj = $ocado->Ejecutar($sql, $parametros);
    //         return $obj;
    //     } catch (Exception $e) {
    //         return $e->getMessage();
    //     }
    // }



}
?>