import 'package:flutter/material.dart';
import '../models/model_tarea.dart';
import '../services/api_service.dart';

class TareaProvider with ChangeNotifier {
    final ApiService apiService;
    List<Tarea> _tareas = [];

    TareaProvider({required this.apiService});

    List<Tarea> get tareas => _tareas;

    Future<void> cargarTareas() async {
      _tareas = await apiService.getTareas();
      notifyListeners();
    }

    Future<Tarea> crearTarea(Tarea tarea) async {
      final nuevaTarea = await apiService.createTarea(tarea);
      print('Tareas después de agregar: $_tareas');
      _tareas.add(nuevaTarea);
      notifyListeners();
      return nuevaTarea;
    }

    Future<Tarea> actualizarTarea(Tarea tarea) async {
      final tareaActualizada = await apiService.updateTarea(tarea);
      final index = _tareas.indexWhere((t) => t.id == tarea.id);
      if (index != -1) {
        _tareas[index] = tareaActualizada;
        notifyListeners();
      }
      return tareaActualizada;
    }

    Future<void> eliminarTarea(int id) async {
      await apiService.deleteTarea(id);
      _tareas.removeWhere((t) => t.id == id);
      notifyListeners();
    }
}