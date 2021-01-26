import 'dart:convert';
import 'package:http/http.dart' as http;

class TraerDatos{


  static Future<List<dynamic>> getTodosServicios() async {  
    http.Response response = await http.get('http://localhost/busqueda_empleos/datos/todosServicios.php');

    if(response.statusCode == 200){
      print('petición correcta');
      print(response.statusCode);

      final jsonData = jsonDecode(response.body);
      List<dynamic> mapDatos = jsonData;
      return mapDatos;
    }else{
      return null;
    }
  }


  static Future<List<dynamic>> buscarUsuario(String servicio, String ubicacion, String horario) async {
    http.Response response = await http.post('http://localhost/busqueda_empleos/datos/buscarUsuario.php', body: {
      'nomServicio': servicio,
      'nomUbicacion': ubicacion,
      'turno': horario
    });

  if(response.statusCode == 200){
    print('petición correcta');
    print(response.statusCode);

    final jsonData = jsonDecode(response.body);
    List<dynamic> mapDatos = jsonData;
    return mapDatos;
  }else{
    return null;
  }

}

static Future<List<dynamic>> getServicios() async {
  
    http.Response response = await http.get('http://localhost/busqueda_empleos/datos/servicios.php');

    if(response.statusCode == 200){
      print('petición correcta');

      final jsonData = jsonDecode(response.body);
      List<dynamic> mapDatos = jsonData;
      return mapDatos;
    }else{
      return null;
    }
  }

  static  Future<String> calificar(String calif, String ciEmple, String idServi) async {
    http.Response response = await http.post('http://localhost/busqueda_empleos/datos/actualizarCalificacion.php', body: {
      'calificacion': calif,
      'ciEmpleado': ciEmple,
      'idServicio': idServi
    });

    if(response.statusCode == 200){
      print("peticion correcta");
      return calif;
    }
    else{
      print("Error");
      return "";
    }
  }

  static Future<List<dynamic>> getUbicacion() async {
  
    http.Response response = await http.get('http://localhost/busqueda_empleos/datos/ubicacion.php');

    if(response.statusCode == 200){
      print('petición correcta');

      final jsonData = jsonDecode(response.body);
      List<dynamic> mapDatos = jsonData;
      return mapDatos;
    }else{
      return null;
    }

  }

}