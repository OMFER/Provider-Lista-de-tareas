import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lista_de_tareas/widgets/tarea_form.dart';

void main() {

  group("Validación de formulario", () {
    final formKey = GlobalKey<FormState>();
    testWidgets("debe mostrar errores con campos vacíos", (widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TareaForm(
              key: formKey,
              initTarea: null,
              onSubmit: (tarea) {},
            ),
          ),
        )
      );

      await widgetTester.tap(find.byType(ElevatedButton));
      await widgetTester.pump();

      expect(find.text('El título es obligatorio'), findsOneWidget);
      expect(find.text('La descripción es obligatoria'), findsOneWidget);
    });

    testWidgets("debe mostrar errores con campos con menos de 3 caracteres", (widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TareaForm(
              key: formKey,
              initTarea: null,
              onSubmit: (tarea) {},
            ),
          ),
        )
      );

      await widgetTester.enterText(find.byType(TextFormField).first, 'Ti');
      await widgetTester.tap(find.byType(ElevatedButton));
      await widgetTester.pump();

      expect(find.text('El título debe tener al menos 3 caracteres'), findsOneWidget);
    });

    testWidgets("debe llamar onSubmit con datos válidos", (widgetTester) async {
      var tareaTest;

      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TareaForm(
              key: formKey,
              initTarea: null,
              onSubmit: (tarea) => tareaTest = tarea,
            ),
          ),
        )
      );

      await widgetTester.enterText(find.byType(TextFormField).first, 'Tarea 1');
      await widgetTester.enterText(find.byType(TextFormField).last, 'Descripción de la tarea 1');
      await widgetTester.tap(find.byType(ElevatedButton));
      await widgetTester.pump();

      expect(tareaTest, isNotNull);
      expect(tareaTest.titulo, 'Tarea 1');
      expect(tareaTest.descripcion, 'Descripción de la tarea 1');
    });
  });

}

