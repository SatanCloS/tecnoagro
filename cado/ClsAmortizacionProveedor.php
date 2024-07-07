<?php

require_once('conexion.php');

class ClsAmortizacionProveedor
{
    function Listar($tipo, $codigo, $fecha_ini, $fecha_fin, $codigo_pro, $codigo_suc)
    {
        try {
            $ocado = new conexion();
            $sql = "call ListaAmortizacionProveedor(:tipo, :codigo, :fecha_ini, :fecha_fin, :codigo_pro, :codigo_suc);";            
            //echo $sql;
            // echo var_dump($sql);
            $parametros = array(
                ':tipo' => $tipo,
                ':codigo' => $codigo,
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


    function Actualizar($codigo, $codigo_suc, $codigo_tdo, $serie, $numero, $codigo_pro, $fecha, 
                        $importe, $codigo_cta, $recibo, $codigo_mon, $detalle, $dolar, $codigo_ven, 
                        $referencia, $usuario)
    {
        try {
            $ocado = new conexion();
            $sql = "call AmortizacionProveedor(:codigo,:codigo_suc,:codigo_tdo,:serie,:numero,:codigo_pro,:fecha,
                                            :importe,:codigo_cta,:recibo,:codigo_mon,:detalle,:dolar,:codigo_ven,
                                            :referencia,:usuario);";
            $parametros = array(
                ':codigo' => $codigo,
                ':codigo_suc' => $codigo_suc,
                ':codigo_tdo' => $codigo_tdo,
                ':serie' => $serie,
                ':numero' => $numero,
                ':codigo_pro' => $codigo_pro,
                ':fecha' => $fecha,
                ':importe' => $importe,
                ':codigo_cta' => $codigo_cta,
                ':recibo' => $recibo,
                ':codigo_mon' => $codigo_mon,
                ':detalle' => strtoupper($detalle),
                ':dolar' => $dolar,
                ':codigo_ven' => $codigo_ven,
                ':referencia' => $referencia,
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
            $sql = "call EliminarAmortizacionProveedor(:codigo,:usuario);";
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