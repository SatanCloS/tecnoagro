<?php

require_once('conexion.php');

class ClsTipoCambio
{
    function Listar($tipo, $id, $anio, $mes)
    {
        try {
            $ocado = new conexion();
            $sql = "call ListarTipoCambio(:tipo,:codigo,:anio,:mes);";
            $parametros = array(
                ':tipo' => $tipo,
                ':codigo' => $id,
                ':anio' => $anio,
                ':mes' => $mes
            );
            $obj = $ocado->Ejecutar($sql, $parametros);
            return $obj;
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }


    function Actualizar($codigo, $fecha, $cambioCompra, $cambioVenta, $usuario)
    {
        try {
            $ocado = new conexion();
            $sql = "call Actualizartipocambio(:codigo,:fecha,:cambioCompra,:cambioVenta,:usuario);";
            $parametros = array(
                ':codigo' => $codigo,
                ':fecha' => $fecha,
                ':cambioCompra' => $cambioCompra,
                ':cambioVenta' => $cambioVenta,
                ':usuario' => $usuario
            );
            //echo $sql;
            //echo var_dump($parametros);
            $obj = $ocado->Ejecutar($sql, $parametros);
            //echo var_dump($sql);
            return $obj;
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }


    function Eliminar($codigo, $usuario)
    {
        try {
            $ocado = new conexion();
            $sql = "call EliminarTipoCambio(:codigo,:usuario);";
            $parametros = array(
                ':codigo' => $codigo,
                ':usuario' => $usuario
            );

            $obj = $ocado->Ejecutar($sql, $parametros);
            return $obj;
        } catch (Exception $e) {
            echo $e->getMessage();
        }
    }


    function ObtenerTipoCambio($tipo, $fecha)
    {
        try {
            $ocado = new conexion();
            $sql = "call ObtenerTipoCambio(:tipo,:fecha);";
            $parametros = array(
                ':tipo' => $tipo,
                ':fecha' => $fecha
            );

            $obj = $ocado->Ejecutar($sql, $parametros);
            return $obj;
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }

}
?>
