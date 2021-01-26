<?php
  
  class Consultas{
        
    private $db;
    private $datos;

    public function __construct(){

        require_once("conexion.php");
        $this->db = Conectar::conexion();
        $this->datos = array();

    }

    public function getServicesEmpleados($sql){
        $datosJson = array();
        $consulta = $this->db->query($sql);
        
        while($filas = $consulta->fetch(PDO::FETCH_ASSOC)){
            $datosJson[] = $filas;
        }

        return json_encode($datosJson);
    }
  }
  
?>
