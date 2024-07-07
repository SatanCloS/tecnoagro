<?php

require_once('conexion.php');

class ClsCliente
{
    function Listar($tipo, $id)
    {
        try {
            $ocado = new conexion();
            $sql = "call ListarCliente(:tipo,:codigo);";
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


    function Actualizar($codigo, $nombre_cli, $direccion_cli, $ciudad_cli, $telefono_cli, $codigo_tip, $codigo_doc, $numero_doc, 
                        $codigo_szo, $email_cli, $observacion_cli, $codigo_dis, $estadosunat_cli, $condicionsunat_cli, $usuario)
    {
        try {
            $ocado = new conexion();
            $sql = "call ActualizarCliente(:codigo, :nombre_cli, :direccion_cli, :ciudad_cli, :telefono_cli, :codigo_tip, :codigo_doc, :numero_doc, 
                                            :codigo_szo, :email_cli, :observacion_cli, :codigo_dis, :estadosunat_cli, :condicionsunat_cli, :usuario);";
            $parametros = array(
                ':codigo' => $codigo,
                ':nombre_cli' => strtoupper($nombre_cli),
                ':direccion_cli' => strtoupper($direccion_cli),
                ':ciudad_cli' => strtoupper($ciudad_cli),
                ':telefono_cli' => strtoupper($telefono_cli),
                ':codigo_tip' => $codigo_tip,
                ':codigo_doc' => $codigo_doc,
                ':numero_doc' => $numero_doc,
                ':codigo_szo' => $codigo_szo,
                ':email_cli' => strtoupper($email_cli),
                ':observacion_cli' => strtoupper($observacion_cli),
                ':codigo_dis' => $codigo_dis,
                ':estadosunat_cli' => $estadosunat_cli,
                ':condicionsunat_cli' => $condicionsunat_cli,
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
            $sql = "call EliminarCliente(:codigo,:usuario);";
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
