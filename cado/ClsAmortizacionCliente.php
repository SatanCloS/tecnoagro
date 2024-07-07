<?php

require_once('conexion.php');

class ClsAmortizacionCliente
{
    function Listar($tipo, $codigo_moc, $fecha_ini, $fecha_fin, $codigo_cli, $codigo_suc)
    {
        try {
            $ocado = new conexion();
            $sql = "call ListaAmortizacionCliente(:tipo, :codigo_moc, :fecha_ini, :fecha_fin, :codigo_cli, :codigo_suc);";            
            //echo $sql;
            // echo var_dump($sql);
            $parametros = array(
                ':tipo' => $tipo,
                ':codigo_moc' => $codigo_moc,
                ':fecha_ini' => $fecha_ini,
                ':fecha_fin' => $fecha_fin,
                ':codigo_cli' => $codigo_cli,
                ':codigo_suc' => $codigo_suc,
            );
            $obj = $ocado->Ejecutar($sql, $parametros);
            return $obj;
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }


    function Actualizar($codigo, $codigo_suc, $codigo_tdo, $serie_moc, $numero_moc, $codigo_cli, $fecha_moc, 
                        $importe_moc, $codigo_cta, $recibo, $codigo_mon, $detalle_moc, $dolar, $codigo_ven, 
                        $referencia, $usuario)
    {
        try {
            $ocado = new conexion();
            $sql = "call AmortizacionCliente(:codigo,:codigo_suc,:codigo_tdo,:serie_moc,:numero_moc,:codigo_cli,:fecha_moc,
                                            :importe_moc,:codigo_cta,:recibo,:codigo_mon,:detalle_moc,:dolar,:codigo_ven,
                                            :referencia,:usuario);";
            $parametros = array(
                ':codigo' => $codigo,
                ':codigo_suc' => $codigo_suc,
                ':codigo_tdo' => $codigo_tdo,
                ':serie_moc' => $serie_moc,
                ':numero_moc' => $numero_moc,
                ':codigo_cli' => $codigo_cli,
                ':fecha_moc' => $fecha_moc,
                ':importe_moc' => $importe_moc,
                ':codigo_cta' => $codigo_cta,
                ':recibo' => $recibo,
                ':codigo_mon' => $codigo_mon,
                ':detalle_moc' => strtoupper($detalle_moc),
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
            $sql = "call EliminarAmortizacionCliente(:codigo,:usuario);";
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