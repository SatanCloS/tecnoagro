<?php

require_once('conexion.php');

class ClsCuentasxPagar
{
    function Listar($tipo, $codigo_mop, $fecha_ini, $fecha_fin, $codigo_pro, $codigo_suc)
    {
        try {
            $ocado = new conexion();
            $sql = "call ListaCuentasxPagar(:tipo,:codigo_mop,:fecha_ini,:fecha_fin,:codigo_pro,:codigo_suc);";
            
            //echo $sql;
            $parametros = array(
                ':tipo' => $tipo,
                ':codigo_mop' => $codigo_mop,
                ':fecha_ini' => $fecha_ini,
                ':fecha_fin' => $fecha_fin,
                ':codigo_pro' => $codigo_pro,
                ':codigo_suc' => $codigo_suc,
            );

            $obj = $ocado->Ejecutar($sql, $parametros);
            return $obj;
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }


    function Actualizar($codigo, $codigo_suc, $codigo_tdo, $serie_mop, $numero_mop, $codigo_pro, $fecha_mop, $importe_mop, 
                        $fechaVencimiento_mop, $codigo_mon, $detalle_mop, $dolar_mop, $codigo_ven, $usuario)
    {
        try {
            $ocado = new conexion();
            $sql = "call ActualizarCuentasxPagar(:codigo,:codigo_suc,:codigo_tdo,:serie_mop,:numero_mop,:codigo_pro,:fecha_mop,:importe_mop,
                                                    :fechaVencimiento_mop,:codigo_mon,:detalle_mop,:dolar_mop,:codigo_ven,:usuario);";
            $parametros = array(
                ':codigo' => $codigo,
                ':codigo_suc' => $codigo_suc,
                ':codigo_tdo' => $codigo_tdo,
                ':serie_mop' => $serie_mop,
                ':numero_mop' => $numero_mop,
                ':codigo_pro' => $codigo_pro,
                ':fecha_mop' => $fecha_mop,
                ':importe_mop' => $importe_mop,
                ':fechaVencimiento_mop' => $fechaVencimiento_mop,
                ':codigo_mon' => $codigo_mon,
                ':detalle_mop' => strtoupper($detalle_mop),
                ':dolar_mop' => $dolar_mop,
                ':codigo_ven' => $codigo_ven,
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
            $sql = "call EliminarCuentasxPagar(:codigo,:usuario);";
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
