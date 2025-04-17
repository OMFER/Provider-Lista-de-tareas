import 'package:test/test.dart';
import 'package:lista_de_tareas/models/model_tarea.dart';

void main(){
  group('Tarea', () {

    test('fromJson', () {
      final json = {'id': 1, 'titulo': 'Tarea 1', 'descripcion': 'Descripción de la tarea 1', 'completada': false};
      final tarea = Tarea.fromJson(json);
      expect(tarea.id, equals(1));
      expect(tarea.titulo, equals('Tarea 1'));
      expect(tarea.descripcion, equals('Descripción de la tarea 1'));
      expect(tarea.completada, equals(false));
    });

    test('toJson', () {
      final tarea = Tarea(id: 1, titulo: 'Tarea 1', descripcion: 'Descripción de la tarea 1', completada: false);
      final json = tarea.toJson();
      expect(json['id'], equals(1));
      expect(json['titulo'], equals('Tarea 1'));
      expect(json['descripcion'], equals('Descripción de la tarea 1'));
      expect(json['completada'], equals(false));
    });
  });
}