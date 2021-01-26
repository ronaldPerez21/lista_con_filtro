<?php

    require_once("../empleos.php");

    $consulta = new Consultas();
    
    $sql = "select e.ci, s.id, e.nombreYApellido, u.nombre as 'nombreUbicacion', s.nombre, getTurno(h.horaIni) as 'turno', ds.descripcion, ds.calificacion
    from ubicacion u, empleado e, detalleServicio ds, servicio s, horario h
    where u.id = e.idUbicacion and e.ci  = ds.ciEmpleado and ds.idServicio = s.id
    and ds.ciEmpleado = h.ciEmpleado and ds.idServicio = h.idServicio;";
    echo $consulta->getServicesEmpleados($sql);

?>