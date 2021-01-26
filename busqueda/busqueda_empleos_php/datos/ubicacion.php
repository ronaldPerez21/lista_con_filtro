<?php

    require_once("../empleos.php");

    $consulta = new Consultas();
    
    $sql = "select nombre
            from ubicacion;";
    echo $consulta->getServicesEmpleados($sql);

?>