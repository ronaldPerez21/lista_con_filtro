<?php

    require_once("../empleos.php");
    $nombreServicio = $_POST['nomServicio'];
    $nombreUbicacion = $_POST['nomUbicacion'];
    $turno = $_POST['turno'];

    $consulta = new Consultas();

    $sql = "select e.ci,s.id, e.nombreYApellido, u.nombre as 'nombreUbicacion', s.nombre, getTurno(h.horaIni) as 'turno',ds.descripcion, ds.calificacion
          from ubicacion u, empleado e, detalleServicio ds, servicio s, horario h
          where u.id = e.idUbicacion and e.ci = ds.ciEmpleado and ds.idServicio = s.id
          and ds.ciEmpleado = h.ciEmpleado and ds.idServicio = h.idServicio
          and s.nombre = '$nombreServicio' and u.nombre = '$nombreUbicacion' and getTurnoNumerico(h.horaIni) = $turno;";
    echo $consulta->getServicesEmpleados($sql);

    // $matriz = [
    //             [1,2,3],
    //             [4,5,6],
    //             [7,8,9]  ];
    // echo json_encode($matriz);

?>