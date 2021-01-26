<?php

    require_once("../empleos.php");

    $consulta = new Consultas();
    
    $sql = "select nombre
            from servicio;";
    echo $consulta->getServicesEmpleados($sql);

?>