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

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title:const Text('Lista de tareas'),
          bottom:const TabBar(
            tabs: [
              Tab(text: 'Pendientes'),
              Tab(text: 'Completadas')
            ],
          ),
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
        body: TabBarView(
          children: [
            _buildTareasList(context, tareasProv.tareas.where((t) => !t.completada).toList()),
            _buildTareasCompletadasList(context, tareasProv.tareas.where((t) => t.completada).toList()),
          ]
      ),
    ),
    );
  }

  Widget _buildTareasList(BuildContext context, List<Tarea> tareas) {
    final tareasProv = Provider.of<TareaProvider>(context, listen: false);
    
    if (tareas.isEmpty) {
      return const Center(child: Text('No hay tareas pendientes'));
    }
    
    return RefreshIndicator(
      onRefresh: tareasProv.cargarTareas,
      child: ListView.builder(
        itemCount: tareas.length,
        itemBuilder: (context, index) => TareaItem(tareas[index]),
      ),
    );
  }
  Widget _buildTareasCompletadasList(BuildContext context, List<Tarea> tareas) {
    final tareasProv = Provider.of<TareaProvider>(context, listen: false);
    
    if (tareas.isEmpty) {
      return const Center(child: Text('No hay tareas completadas'));
    }
    
    return RefreshIndicator(
      onRefresh: tareasProv.cargarTareas,
      child: ListView.builder(
        itemCount: tareas.length,
        itemBuilder: (context, index) => _buildTareaCompletadaItem(context, tareas[index]),
      ),
    );
  }
  Widget _buildTareaCompletadaItem(BuildContext context, Tarea tarea) {
    final tareasProv = Provider.of<TareaProvider>(context, listen: false);

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(
          tarea.titulo,
          style:const TextStyle(decoration: TextDecoration.lineThrough)
        ),
        subtitle: Text(tarea.descripcion),
        trailing: IconButton(
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: () async {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Eliminar tarea'),
                content: const Text('¿Estás seguro de que quieres eliminar esta tarea completada?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            );
            if (confirm == true) {
              try {
                await tareasProv.eliminarTarea(tarea.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Tarea ${tarea.id} eliminada correctamente')),
                );
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error al eliminar tarea: $e')),
                  );
                }
              }
            }
          },
        ),
        onTap: () {
          final updatedTarea = Tarea(
            id: tarea.id,
            titulo: tarea.titulo,
            descripcion: tarea.descripcion,
            completada: !tarea.completada,
          );
          tareasProv.actualizarTarea(updatedTarea);
        }
      ),
    );
  }
}