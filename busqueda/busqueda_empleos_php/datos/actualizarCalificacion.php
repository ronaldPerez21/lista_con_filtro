<?php

    require_once("../empleos.php");

    $calif = $_POST['calificacion'];
    $ciEmple = $_POST['ciEmpleado'];
    $idServi = $_POST['idServicio'];

    $consulta = new Consultas();

    // $sql = "select e.ci, e.nombreYApellido, u.nombre as 'nombreUbicacion', s.nombre, getTurno(h.horaIni) as 'turno', ds.descripcion, ds.calificacion
    // from ubicacion u, empleado e, detalleServicio ds, servicio s, horario h
    // where u.id = e.idUbicacion and e.ci  = ds.ciEmpleado and ds.idServicio = s.id
    // and ds.ciEmpleado = h.ciEmpleado and ds.idServicio = h.idServicio and e.ci = $ci;";
    // echo $consulta->getServicesEmpleados($sql);

    $sql = "update detalleServicio set calificacion = $calif where ciEmpleado = $ciEmple and idServicio = $idServi;";
    echo $consulta->getServicesEmpleados($sql);
   
    // echo "<br><br>****************************<br><br>";

    // $lista = json_decode($consultaServices);
    // echo $lista[1]->descripcion;

?>