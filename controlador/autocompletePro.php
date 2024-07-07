<?php
    define (DB_USER, "root");
    define (DB_PASSWORD, "12345678");
    define (DB_DATABASE, "bdsistema");
    define (DB_HOST, "localhost");
    $mysqli = new mysqli(DB_HOST, DB_USER, DB_PASSWORD, DB_DATABASE);

    if(!isset($_GET['searchTerm'])){ 
        $json = [];
    }else{
        $search = $_GET['searchTerm'];
        $sql = "SELECT codigo_tmo, nombre_tmo
                FROM tipomovimiento 
                WHERE nombre_tmo LIKE '%".$search."%'
                LIMIT 10"; 
        $result = $mysqli->query($sql);
        $json = [];
        while($row = $result->fetch_assoc()){
            $json[] = ['id'=>$row['codigo_tmo'], 'text'=>$row['nombre_tmo']];
        }
    }

    echo json_encode($json);
?>