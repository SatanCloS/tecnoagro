<?php

require_once('conexion.php');

class ClsProveedor
{
    function Listar($tipo, $id)
    {
        try {
            $ocado = new conexion();
            $sql = "call ListarProveedor(:tipo,:codigo);";
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


    function Actualizar($codigo, $nombre, $direccion_pro, $ciudad_pro, $telefono_pro, $codigo_tip, $codigo_doc, $numero_doc, $observacion_pro, $usuario)
    {
        try {
            $ocado = new conexion();
            $sql = "call ActualizarProveedor(:codigo,:nombre,:direccion_pro,:ciudad_pro,:telefono_pro,:codigo_tip,:codigo_doc,:numero_doc,:observacion_pro,:usuario);";
            $parametros = array(
                ':codigo' => $codigo,
                ':nombre' => strtoupper($nombre),
                ':direccion_pro' => strtoupper($direccion_pro),
                ':ciudad_pro' => strtoupper($ciudad_pro),
                ':telefono_pro' => strtoupper($telefono_pro),
                ':codigo_tip' => $codigo_tip,
                ':codigo_doc' => $codigo_doc,
                ':numero_doc' => $numero_doc,
                ':observacion_pro' => strtoupper($observacion_pro),
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
            $sql = "call EliminarProveedor(:codigo,:usuario);";
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
