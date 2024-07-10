<?php

require_once('conexion.php');

class ClsGerencial
{
    function kardex_valorado($desde, $hasta, $codigo_art, $codigo_suc)
    {
        try {
            $ocado = new conexion();
            $sql = "call kardex_valorado(:desde, :hasta, :codigo_art, :codigo_suc);";            
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

    function inventario_valorado($fecha, $codigo_suc)
    {
        try {
            $ocado = new conexion();
            $sql = "call inventario_valorado(:fecha, :codigo_suc);";            
            //echo $sql;
            //echo var_dump($sql);
            $parametros = array(
                ':fecha' => $fecha,
                ':codigo_suc' => $codigo_suc,
            );
            $obj = $ocado->Ejecutar($sql, $parametros);
            return $obj;
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }

    
    function utilidadDetallada($desde, $hasta, $codigo_suc)
    {
        try {
            $ocado = new conexion();
            $sql = "call utilidadDetallada(:desde, :hasta, :codigo_suc);";            
            //echo $sql;
            //echo var_dump($sql);
            $parametros = array(
                ':desde' => $desde,
                ':hasta' => $hasta,
                ':codigo_suc' => $codigo_suc,
            );
            $obj = $ocado->Ejecutar($sql, $parametros);
            return $obj;
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }

    
    function utilidadResumida($desde, $hasta, $codigo_suc, $tipo)
    {
        try {
            $ocado = new conexion();
            $sql = "call utilidadResumida(:desde, :hasta, :codigo_suc, :tipo);";            
            //echo $sql;
            //echo var_dump($sql);
            $parametros = array(
                ':desde' => $desde,
                ':hasta' => $hasta,
                ':codigo_suc' => $codigo_suc,
                ':tipo' => $tipo,
            );
            $obj = $ocado->Ejecutar($sql, $parametros);
            return $obj;
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }

    

    function egp($desde, $hasta, $codigo_suc)
    {
        try {
            $ocado = new conexion();
            $sql = "call egp(:desde, :hasta, :codigo_suc);";            
            //echo $sql;
            //echo var_dump($sql);
            $parametros = array(
                ':desde' => $desde,
                ':hasta' => $hasta,
                ':codigo_suc' => $codigo_suc
            );
            $obj = $ocado->Ejecutar($sql, $parametros);
            return $obj;
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }


}
?>