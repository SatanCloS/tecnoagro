<?php

require_once('conexion.php');

class ClsGrupoConcepto
{
    function Listar($tipo, $id)
    {
        try {
            $ocado = new conexion();
            $sql = "call ListarGrupoConcepto(:tipo,:codigo);";
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

    function Actualizar($codigo, $nombre, $esgasto, $usuario)
    {
        try {
            $ocado = new conexion();
            $sql = "call ActualizarGrupoConcepto(:codigo,:nombre,:esgasto,:usuario);";
            $parametros = array(
                ':codigo' => $codigo,
                ':nombre' => strtoupper($nombre),
                ':esgasto' => $esgasto,
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
            $sql = "call EliminarGrupoConcepto(:codigo,:usuario);";
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
