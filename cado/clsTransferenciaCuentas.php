<?php

require_once('conexion.php');

class clsTransferenciaCuentas
{
    function Listar($tipo, $id, $codigo_suc)
    {
        try {
            $ocado = new conexion();
            $sql = "call ListarTransferenciaCuenta(:tipo,:id,:codigo_suc);";
            //echo $sql;
            //echo var_dump($sql);
            $parametros = array(
                ':tipo' => $tipo,
                ':id' => $id,
                ':codigo_suc' => $codigo_suc
            );
            $obj = $ocado->Ejecutar($sql, $parametros);
            return $obj;
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }


    function Actualizar($codigo, $codigo_suc, $fecha, $importe, $saldo, $codigo_cta_origen, 
                        $codigo_cta_destino, $recibo, $detalle, $fechaVencimiento, $dolar, 
                        $codigo_ven, $codigoDestino, $codigosuc_Destino, $usuario)
    {
        try {
            $ocado = new conexion();
            $sql = "call RegistrarTransferencia(:codigo,:codigo_suc,:fecha,:importe,:saldo,:codigo_cta_origen,
                                                :codigo_cta_destino,:recibo,:detalle,:fechaVencimiento,:dolar,
                                                :codigo_ven,:codigoDestino,:codigosuc_Destino,:usuario);";

            $parametros = array(
                ':codigo' => $codigo,
                ':codigo_suc' => $codigo_suc,
                ':fecha' => $fecha,
                ':importe' => $importe,
                ':saldo' => $saldo,
                ':codigo_cta_origen' => $codigo_cta_origen,
                ':codigo_cta_destino' => $codigo_cta_destino,                
                ':recibo' => $recibo,
                ':detalle' => strtoupper($detalle),
                ':fechaVencimiento' => $fechaVencimiento,
                ':dolar' => $dolar,
                ':codigo_ven' => $codigo_ven,
                ':codigoDestino' => $codigoDestino,
                ':codigosuc_Destino' => $codigosuc_Destino,
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


    // function Editar($id, $tipo_mov, $tabla)
    // {
    //     try {
    //         $ocado = new conexion();
    //         $sql = "call EditarMovimientoCaja(:id,:tipo_mov,:tabla);";            
    //         //echo $sql;
    //         //echo var_dump($sql);
    //         $parametros = array(
    //             ':id' => $id,
    //             ':tipo_mov' => $tipo_mov,
    //             ':tabla' => $tabla
    //         );
    //         $obj = $ocado->Ejecutar($sql, $parametros);
    //         return $obj;
    //     } catch (Exception $e) {
    //         return $e->getMessage();
    //     }
    // }


    function Eliminar($codigo, $usuario)
    {
        try {
            //echo $codigo . " " . $tabla . " " . $usuario;

            $ocado = new conexion();
            $sql = "call EliminarTransferenciaCuenta(:codigo,:usuario);";
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