import 'package:flutter/material.dart';
import '../models/model_tarea.dart';

class TareaForm extends StatefulWidget {
  final Tarea? initTarea;
  final Function(Tarea) onSubmit;

  const TareaForm({super.key, this.initTarea, required this.onSubmit});

  @override
  State<TareaForm> createState() => _TareaFormState();
}

class _TareaFormState extends State<TareaForm> {
  final _formKey = GlobalKey<FormState>();
  late String _titulo = '';
  late String _descripcion = '';

  @override
  void initState() {
    super.initState();
    if (widget.initTarea != null) {
      _titulo = widget.initTarea!.titulo;
      _descripcion = widget.initTarea!.descripcion;
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('Enviando tarea - Título: $_titulo, Descripción: $_descripcion');
      final tarea = Tarea(
        id: widget.initTarea?.id ?? 0,
        titulo: _titulo,
        descripcion: _descripcion,
        completada: widget.initTarea?.completada ?? false,
      );
      widget.onSubmit(tarea);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            initialValue: _titulo,
            decoration: const InputDecoration(labelText: 'Título'),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'El título es obligatorio';
              }
              if (value.trim().length < 3) {
                  return 'El título debe tener al menos 3 caracteres';
              }
              return null;
            },
            onSaved: (value) => _titulo = value ?? '',
          ),
          TextFormField(
            initialValue: _descripcion,
            decoration:const InputDecoration(
              labelText: 'Descripción *',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'La descripción es obligatoria';
              }
              if (value.trim().length < 10) {
                return 'La descripción debe tener al menos 10 caracteres';
              }
              return null;
            },
            onSaved: (value) => _descripcion = value!,
          ),
          ElevatedButton(
            onPressed: _submit, 
            style: ElevatedButton.styleFrom(
              padding:const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(
                widget.initTarea == null ? 'Agregar Tarea' : 'Actualizar Tarea',
                style:const TextStyle(fontSize: 16),
              ),
          ),
        ],
      ),
    );
  }
}