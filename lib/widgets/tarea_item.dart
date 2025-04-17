import 'package:flutter/material.dart';
import 'package:lista_de_tareas/models/model_tarea.dart';
import 'package:provider/provider.dart';
import 'package:lista_de_tareas/providers/tarea_prov.dart';

class TareaItem extends StatelessWidget {
  final Tarea tarea;
  final bool completada;

  const TareaItem(this.tarea, {this.completada = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tareaProv = Provider.of<TareaProvider>(context, listen: false);

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text("Titulo"),
        subtitle: Text("Descripción"),
        trailing: Checkbox(
          value: completada,
          onChanged: (value) => tareaProv.actualizarTarea(tarea),
        ),
      )
    );
  }
}