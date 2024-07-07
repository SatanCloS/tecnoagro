<?php

require_once('conexion.php');

class ClsEECCCLiente
{
    function EstadoCuentaCliente($desde, $hasta, $codigo_cli, $codigo_suc)
    {
        try {
            $ocado = new conexion();
            $sql = "call EstadoCuentaCliente(:desde, :hasta, :codigo_cli, :codigo_suc);";            
            //echo $sql;
            //echo var_dump($sql);
            $parametros = array(
                ':desde' => $desde,
                ':hasta' => $hasta,
                ':codigo_cli' => $codigo_cli,
                ':codigo_suc' => $codigo_suc,
            );
            $obj = $ocado->Ejecutar($sql, $parametros);
            return $obj;
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }

    function CuentasxCobrar($hasta, $codigo_tip, $codigo_suc)
    {
        try {
            $ocado = new conexion();
            $sql = "call cuentasxCobrar(:hasta, :codigo_tip, :codigo_suc);";            
            //echo $sql;
            //echo var_dump($sql);
            $parametros = array(
                ':hasta' => $hasta,
                ':codigo_tip' => $codigo_tip,
                ':codigo_suc' => $codigo_suc,
            );
            $obj = $ocado->Ejecutar($sql, $parametros);
            return $obj;
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }


    function conceptoIndividual($fecha_ini, $fecha_fin, $codigo_con, $codigo_suc)
    {
        try {
            $ocado = new conexion();
            $sql = "call conceptoIndividual(:fecha_ini, :fecha_fin, :codigo_con, :codigo_suc);";            
            //echo $sql;
            //echo var_dump($sql);
            $parametros = array(
                ':fecha_ini' => $fecha_ini,
                ':fecha_fin' => $fecha_fin,
                ':codigo_con' => $codigo_con,
                ':codigo_suc' => $codigo_suc
            );
            $obj = $ocado->Ejecutar($sql, $parametros);
            return $obj;
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }


    function gastosDetallados($fecha_ini, $fecha_fin, $codigo_suc)
    {
        try {
            $ocado = new conexion();
            $sql = "call gastosDetallados(:fecha_ini, :fecha_fin, :codigo_suc);";            
            //echo $sql;
            //echo var_dump($sql);
            $parametros = array(
                ':fecha_ini' => $fecha_ini,
                ':fecha_fin' => $fecha_fin,
                ':codigo_suc' => $codigo_suc
            );
            $obj = $ocado->Ejecutar($sql, $parametros);
            return $obj;
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }


    function saldosCuentas($fecha_ini, $codigo_suc)
    {
        try {
            $ocado = new conexion();
            $sql = "call saldosCuentas(:fecha_ini, :codigo_suc);";            
            //echo $sql;
            //echo var_dump($sql);
            $parametros = array(
                ':fecha_ini' => $fecha_ini,
                ':codigo_suc' => $codigo_suc
            );
            $obj = $ocado->Ejecutar($sql, $parametros);
            return $obj;
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }


    function cuentasporPagar($fecha_fin, $codigo_tip, $codigo_suc)
    {
        try {
            $ocado = new conexion();
            $sql = "call cuentasporPagar(:fecha_fin, :codigo_tip, :codigo_suc);";
            //$sql = "call cuentasporPagar('2024-05-18', 0, 1);";
            //echo $sql;
            //echo var_dump($sql);
            $parametros = array(
                ':fecha_fin' => $fecha_fin,
                ':codigo_tip' => $codigo_tip,
                ':codigo_suc' => $codigo_suc
            );           
            $obj = $ocado->Ejecutar($sql, $parametros);
            return $obj;
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }


    function EstadoCuentaProveedor($desde, $hasta, $codigo_pro, $codigo_suc)
    {
        try {
            $ocado = new conexion();
            $sql = "call EstadoCuentaProveedor(:desde, :hasta, :codigo_pro, :codigo_suc);";            
            //echo $sql;
            //echo var_dump($sql);
            $parametros = array(
                ':desde' => $desde,
                ':hasta' => $hasta,
                ':codigo_pro' => $codigo_pro,
                ':codigo_suc' => $codigo_suc,
            );
            $obj = $ocado->Ejecutar($sql, $parametros);
            return $obj;
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }

}
?>