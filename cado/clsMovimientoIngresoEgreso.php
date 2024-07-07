<?php

require_once('conexion.php');

class clsMovimientoIngresoEgreso
{
    function Listar($fecha_ini, $fecha_fin, $codigo_cta, $codigo_suc)
    {
        try {
            $ocado = new conexion();
            $sql = "call ListarMovimientoIngresoEgreso(:fecha_ini,:fecha_fin,:codigo_cta,:codigo_suc);";            
            //echo $sql;
            //echo var_dump($sql);
            $parametros = array(
                ':fecha_ini' => $fecha_ini,
                ':fecha_fin' => $fecha_fin,
                ':codigo_cta' => $codigo_cta,
                ':codigo_suc' => $codigo_suc,
            );
            $obj = $ocado->Ejecutar($sql, $parametros);
            return $obj;
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }



    function Actualizar($codigo, $codigo_suc, $codigo_pso, $fecha, $importe, $saldo, $tipo, 
                        $codigo_cta, $recibo, $codigo_mon, $detalle, $codigo_con, $fechaVencimiento, 
                        $dolar, $codigo_ven, $usuario, $tipoMovimiento, $persona)
    {
        try {
            
            $ocado = new conexion();
            $sql = "call RegistrarMovimientoCaja(:codigo,:codigo_suc,:codigo_pso,:fecha,:importe,:saldo,
                                                :tipo,:codigo_cta,:recibo,:codigo_mon,:detalle,:codigo_con,
                                                :fechaVencimiento,:dolar,:codigo_ven,:usuario,:tipoMovimiento,
                                                :persona);";
            
            $parametros = array(
                ':codigo' => $codigo,
                ':codigo_suc' => $codigo_suc,
                ':codigo_pso' => $codigo_pso,
                ':fecha' => $fecha,
                ':importe' => $importe,
                ':saldo' => $saldo,
                ':tipo' => $tipo,
                ':codigo_cta' => $codigo_cta,
                ':recibo' => $recibo,
                ':codigo_mon' => $codigo_mon,
                ':detalle' => strtoupper($detalle),
                ':codigo_con' => $codigo_con,
                ':fechaVencimiento' => $fechaVencimiento,
                ':dolar' => $dolar,
                ':codigo_ven' => $codigo_ven,
                ':usuario' => $usuario,
                ':tipoMovimiento' => $tipoMovimiento,
                ':persona' => $persona
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


    function Editar($id, $tipo_mov, $tabla)
    {
        try {
            $ocado = new conexion();
            $sql = "call EditarMovimientoCaja(:id,:tipo_mov,:tabla);";            
            //echo $sql;
            //echo var_dump($sql);
            $parametros = array(
                ':id' => $id,
                ':tipo_mov' => $tipo_mov,
                ':tabla' => $tabla
            );
            $obj = $ocado->Ejecutar($sql, $parametros);
            return $obj;
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }


    function Eliminar($codigo, $tabla, $usuario)
    {
        try {
            //echo $codigo . " " . $tabla . " " . $usuario;

            $ocado = new conexion();
            $sql = "call EliminarMovimientoCaja(:codigo,:tabla,:usuario);";
            $parametros = array(
                ':codigo' => $codigo,
                ':tabla' => $tabla,
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