<?php

require_once('conexion.php');

class ClsCuenta
{
    function Listar($tipo, $id, $codigo_suc)
    {
        try {
            $ocado = new conexion();
            $sql = "call ListarCuenta(:tipo,:codigo,:codigo_suc);";
            $parametros = array(
                ':tipo' => $tipo,
                ':codigo' => $id,
                ':codigo_suc' => $codigo_suc
            );

            $obj = $ocado->Ejecutar($sql, $parametros);
            return $obj;
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }

      

    function Actualizar($codigo, $nombre, $codigo_ban, $codigo_mon, $titular_cta, $codigo_suc, $usuario)
    {
        try {
            $ocado = new conexion();
            $sql = "call ActualizarCuenta(:codigo,:nombre,:codigo_ban,:codigo_mon,:titular_cta,:codigo_suc,:usuario);";
            $parametros = array(
                ':codigo' => $codigo,
                ':nombre' => strtoupper($nombre),
                ':codigo_ban' => $codigo_ban,
                ':codigo_mon' => $codigo_mon,
                ':titular_cta' => strtoupper($titular_cta),
                ':codigo_suc' => $codigo_suc,
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
            $sql = "call EliminarCuenta(:codigo,:usuario);";
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


    function ObtenerNroRecibo($tipo, $codigo_cta)
    {
        try {
            $ocado = new conexion();
            $sql = "call ObtenerNroRecibo(:tipo,:codigo_cta);";
            $parametros = array(
                ':tipo' => $tipo,
                ':codigo_cta' => $codigo_cta
            );

            $obj = $ocado->Ejecutar($sql, $parametros);
            return $obj;
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }



}
?>
