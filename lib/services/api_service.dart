import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/model_tarea.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<List<Tarea>> getTareas() async {
    final response = await http.get(Uri.parse('$baseUrl/tareas'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Tarea.fromJson(item)).toList();
    } else {
      throw Exception('Error al obtener las tareas');
    }
  }

  Future<Tarea> createTarea(Tarea tarea) async {
    final response = await http.post(
      Uri.parse('$baseUrl/tareas'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'titulo': tarea.titulo,
        'descripcion': tarea.descripcion,
        'completada': tarea.completada
      }),
    );
    print('Respuesta del backend: ${response.body}');
    if (response.statusCode == 201) {
      return Tarea.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al crear la tarea');
    }
  }

  Future<Tarea> updateTarea(Tarea tarea) async {
    final response = await http.put(
      Uri.parse('$baseUrl/tareas/${tarea.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'title': tarea.titulo,
        'descripcion': tarea.descripcion,
        'completed': tarea.completada
      }),
    );
    if (response.statusCode == 200) {
      return Tarea.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al actualizar la tarea');
    }
  }

  Future<void> deleteTarea(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/tareas/$id'));
    if (response.statusCode != 200) {
      throw Exception('Error al eliminar la tarea');
    }
  }
}