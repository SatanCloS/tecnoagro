<?php

require_once('conexion.php');

class ClsUbigeo
{
    function ListarDepartamento($tipo, $id)
    {
        try {
            $ocado = new conexion();
            $sql = "call ListarDepartamento(:tipo,:codigo);";
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

    function ListarProvincia($tipo, $id)
    {
        try {
            $ocado = new conexion();
            $sql = "call ListarProvincia(:tipo,:codigo);";
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

    function ListarDistrito($tipo, $id)
    {
        try {
            $ocado = new conexion();
            $sql = "call ListarDistrito(:tipo,:codigo);";
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


}
?>
