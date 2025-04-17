import 'package:flutter/material.dart';
import 'package:lista_de_tareas/models/model_tarea.dart';
import 'package:provider/provider.dart';
import '../providers/tarea_prov.dart';
import '../widgets/tarea_item.dart';
import 'agregar_tarea.dart';

class ListaTareas extends StatelessWidget {
  const ListaTareas({super.key});

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
              itemBuilder: (context, index) => TareaItem(tareasPorv.tareas[index]),
            );
          }
        }
      ),
    );
  }

}