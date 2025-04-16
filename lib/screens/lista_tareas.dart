import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tarea_prov.dart';
import '../widgets/tarea.dart';
import 'agregar_tarea.dart';

class ListaTareas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tareasPorv = Provider.of<TareaProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title:const Text('Lista de tareas'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AgregarTarea()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: tareasPorv.cargarTareas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al cargar las tareas: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: tareasPorv.tareas.length,
              itemBuilder: (context, index) {
                final tarea = tareasPorv.tareas[index];
                return Tarea(tarea: tarea);
              },
            );
          }
        }
      ),
    );
  }

}