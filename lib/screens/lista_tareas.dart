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
    final tareasProv = Provider.of<TareaProvider>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      tareasProv.cargarTareas();
    });

    return Scaffold(
      appBar: AppBar(
        title:const Text('Lista de tareas'),
        actions: [
          IconButton(
            icon:const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) =>const AgregarTarea()),
              );
            },
          ),
        ],
      ),
      body: Consumer<TareaProvider>(
        builder: (context, tareasProv, child) {
          if (tareasProv.tareas.isEmpty) {
            return const Center(child: Text('No hay tareas'));
          }
          return RefreshIndicator(
            onRefresh: tareasProv.cargarTareas,
            child: ListView.builder(
              itemCount: tareasProv.tareas.length,
              itemBuilder: (context, index) => TareaItem(tareasProv.tareas[index]),
            )
          );
        },
      ),
    );
  }

}