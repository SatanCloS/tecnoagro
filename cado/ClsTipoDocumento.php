<?php

require_once('conexion.php');

class ClsTipoDocumento
{
    function Listar($tipo, $id, $buscar)
    {
        try {
            $ocado = new conexion();
            $sql = "call ListarTipoDocumento(:tipo,:codigo, :buscar);";
            $parametros = array(
                ':tipo' => $tipo,
                ':codigo' => $id,
                ':buscar' => $buscar,
            );

            $obj = $ocado->Ejecutar($sql, $parametros);
            return $obj;
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }

    function Actualizar($codigo, $nombre, $abreviatura, $codigosunat, $tipo, $usuario)
    {
        try {
            $ocado = new conexion();
            $sql = "call ActualizarTipoDocumento(:codigo,:nombre,:abreviatura,:codigosunat,:tipo,:usuario);";
            $parametros = array(
                ':codigo' => $codigo,
                ':nombre' => strtoupper($nombre),
                ':abreviatura' => strtoupper($abreviatura),
                ':codigosunat' => strtoupper($codigosunat),
                ':tipo' => strtoupper($tipo),
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
            $sql = "call EliminarTipoDocumento(:codigo,:usuario);";
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



    function ObtenerNrotransferencia($tipo, $codigo_suc)
    {
        try {
            $ocado = new conexion();
            $sql = "call ObtenerNrotransferencia(:tipo,:codigo_suc);";
            $parametros = array(
                ':tipo' => $tipo,
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
