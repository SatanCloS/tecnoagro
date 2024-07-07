<?php

class conexion
{
    function ConexionPDO()
    {
        try {
            $manejador = 'mysql';
            $servidor = '127.0.0.1';
            //$puerto = '3306';
            $base = 'bdsistema';
            $usuario = 'root';
            $pass = '12345678';
            $cadena = "$manejador:host=$servidor;dbname=$base";
            $cnx = new PDO($cadena, $usuario, $pass);
            return $cnx;
        } catch (PDOException $e) {
            echo 'Falló la conexión: ' . $e->getMessage();
        }
    }

    function Ejecutar($sql, $parametros)
    {
        try {
            $cnx = $this->ConexionPDO();
            $pre = $cnx->prepare($sql);
            $pre->execute($parametros);
            return $pre;
        } catch (Exception $e) {
            echo 'error: ' . $e->getMessage();
        }
    }
}

?>