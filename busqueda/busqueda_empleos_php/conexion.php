<?php

class Conectar{
        
    public static function conexion(){

        try{
            $conexion = new PDO("mysql:host=localhost; dbname=empleos", "root", "ronaldps");
            $conexion->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            $conexion->exec("set character set utf8");

        }catch(Exception $e){
            die("Error". $e->getMessage());
            echo "Línea de error".$e->getLine();
        }

        return $conexion;
    }
}


?>