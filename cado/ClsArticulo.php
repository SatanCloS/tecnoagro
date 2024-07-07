<?php

require_once('conexion.php');

class ClsArticulo
{
    function Listar($tipo, $id)
    {
        try {
            $ocado = new conexion();
            $sql = "call ListarArticulo(:tipo,:codigo);";
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


    function Actualizar($codigo, $nombre_art, $abreviatura_art, $codigobarra_art, $codigoproveedor_art, $codigo_mar, $codigo_lin, $unidadm_art, $tipoimpuesto_art, $precio_art, $preciomayorista_art, $stockmin_art, $stockmax_art, $usuario)
    {
        try {
            $ocado = new conexion();
            $sql = "call ActualizarArticulo(:codigo,:nombre_art,:abreviatura_art,:codigobarra_art,:codigoproveedor_art,:codigo_mar,:codigo_lin,:unidadm_art,:tipoimpuesto_art,:precio_art,:preciomayorista_art,:stockmin_art,:stockmax_art,:usuario);";
            $parametros = array(
                ':codigo' => $codigo,
                ':nombre_art' => strtoupper($nombre_art),
                ':abreviatura_art' => strtoupper($abreviatura_art),
                ':codigobarra_art' => strtoupper($codigobarra_art),
                ':codigoproveedor_art' => strtoupper($codigoproveedor_art),
                ':codigo_mar' => $codigo_mar,
                ':codigo_lin' => $codigo_lin,                
                ':unidadm_art' => strtoupper($unidadm_art),
                ':tipoimpuesto_art' => $tipoimpuesto_art,                
                ':precio_art' => $precio_art,
                ':preciomayorista_art' => $preciomayorista_art,                
                ':stockmin_art' => $stockmin_art,
                ':stockmax_art' => $stockmax_art,
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
            $sql = "call EliminarArticulo(:codigo,:usuario);";
            $parametros = array(
                ':codigo' => $codigo,
                ':usuario' => $usuario,
            );

            $obj = $ocado->Ejecutar($sql, $parametros);
            return $obj;
        } catch (Exception $e) {
            echo $e->getMessage();
        }
    }

}
?>