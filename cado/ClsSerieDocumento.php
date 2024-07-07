<?php

require_once('conexion.php');

class ClsSerieDocumento
{
    function Listar($tipo, $id)
    {
        try {
            $ocado = new conexion();
            $sql = "call ListarSerieDocumento(:tipo,:codigo);";
            $parametros = array(
                ':tipo' => $tipo,
                ':codigo' => $id
            );

            $obj = $ocado->Ejecutar($sql, $parametros);
            return $obj;
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }

    function Actualizar($codigo, $codigo_tdo, $serie_ser, $numero_ser, $codigo_suc, $usuario, $sistema)
    {
        try {
            $ocado = new conexion();
            $sql = "call ActualizarSerieDocumento(:codigo,:codigo_tdo,:serie_ser,:numero_ser,:codigo_suc,:usuario,:sistema);";
            $parametros = array(
                ':codigo' => $codigo,
                ':codigo_tdo' => $codigo_tdo,
                ':serie_ser' => $serie_ser,
                ':numero_ser' => $numero_ser,
                ':codigo_suc' => $codigo_suc,                
                ':usuario' => $usuario, 
                ':sistema' => $sistema                
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
            $sql = "call EliminarSerieDocumento(:codigo,:usuario);";
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


}
?>
