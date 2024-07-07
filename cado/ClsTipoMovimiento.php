<?php

require_once('conexion.php');

class ClsTipoMovimiento
{
    function Listar($tipo, $codigo)
    {
        try {
            $ocado = new conexion();
            $sql = "call ListarTipoMovimiento(:tipo,:codigo);";            
            //echo $sql;
            //echo var_dump($sql);
            $parametros = array(
                ':tipo' => $tipo,
                ':codigo' => $codigo
            );
            $obj = $ocado->Ejecutar($sql, $parametros);
            return $obj;
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }
}
?>