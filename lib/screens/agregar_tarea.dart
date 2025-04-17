import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tarea_prov.dart';
import '../widgets/tarea_form.dart';

class AgregarTarea extends StatelessWidget {
  const AgregarTarea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tareaProv = Provider.of<TareaProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Tarea')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TareaForm(
            onSubmit: (tarea) async {
              try {
                await tareaProv.crearTarea(tarea);
                await tareaProv.cargarTareas();
                Navigator.pop(context);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error al crear tarea: $e')),
                );
              }
            },
          ),
        )
      ),
    );
  }
}