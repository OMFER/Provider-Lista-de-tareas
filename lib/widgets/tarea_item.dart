import 'package:flutter/material.dart';
import 'package:lista_de_tareas/models/model_tarea.dart';
import 'package:lista_de_tareas/widgets/tarea_form.dart';
import 'package:provider/provider.dart';
import 'package:lista_de_tareas/providers/tarea_prov.dart';

class TareaItem extends StatelessWidget {
  final Tarea tarea;

  const TareaItem(this.tarea, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tareaProv = Provider.of<TareaProvider>(context, listen: false);

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(tarea.titulo),
        subtitle: Text(tarea.descripcion),
        trailing: Checkbox(
          value: tarea.completada,
          onChanged: (value) {
            final updatedTarea = Tarea(
              id: tarea.id,
              titulo: tarea.titulo,
              descripcion: tarea.descripcion,
              completada: value ?? false,
            );
            tareaProv.actualizarTarea(updatedTarea);
          },
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Scaffold(
                appBar: AppBar(title:const Text('Editar Tarea')),
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TareaForm(
                    initTarea: tarea,
                    onSubmit: (updatedTarea) async {
                      await tareaProv.actualizarTarea(updatedTarea);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            )
          );
        },
      ),
    );
  }
}