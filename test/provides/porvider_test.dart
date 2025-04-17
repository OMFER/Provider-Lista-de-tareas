import 'package:flutter_test/flutter_test.dart';
import 'package:lista_de_tareas/models/model_tarea.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:lista_de_tareas/providers/tarea_prov.dart';
import 'package:lista_de_tareas/services/api_service.dart';

import 'porvider_test.mocks.dart';


@GenerateMocks([ApiService])
void main() {
  late TareaProvider tareaProvider;
  late MockApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
    tareaProvider = TareaProvider(apiService: mockApiService);
  });

  final tareasCarga = [
   Tarea(id: 1, titulo: 'Tarea 1', descripcion: 'Descripción de la tarea 1'),
   Tarea(id: 2, titulo: 'Tarea 2', descripcion: 'Descripción de la tarea 2')
  ];

  final tarea1Test = Tarea(id: 1, titulo: 'Tarea 1', descripcion: 'Descripción de la tarea 1');
  final tarea2Test = Tarea(id: 2, titulo: 'Tarea 2', descripcion: 'Descripción de la tarea 2');
  group('Cargar tareas', () {
    test('debe cargar las tareas correctamente', () async {
      when(mockApiService.getTareas()).thenAnswer((_) async => tareasCarga);

      await tareaProvider.cargarTareas();
      
      expect(tareaProvider.tareas, tareasCarga);
      verify(mockApiService.getTareas()).called(1);
    });
  });

  group('Agregar tarea', () {
    test('debe agregar la tarea correctamente', () async {
      when(mockApiService.createTarea(tarea2Test)).thenAnswer((_) async => tarea1Test);
      when(mockApiService.getTareas()).thenAnswer((_) async => [tarea1Test]);

      await tareaProvider.crearTarea(tarea2Test);

      verify(mockApiService.createTarea(tarea2Test)).called(1);
      verify(mockApiService.getTareas()).called(1);
      expect(tareaProvider.tareas, [tarea1Test]);
    });
  });

  group('Actualizar tarea', () {
    test('debe actualizar la tarea correctamente', () async {
      tareaProvider.tareas = [tarea2Test];
      when(mockApiService.updateTarea(tarea2Test)).thenAnswer((_) async => tarea2Test);
      when(mockApiService.getTareas()).thenAnswer((_) async => [tarea2Test]);

      await tareaProvider.actualizarTarea(tarea2Test);

      verify(mockApiService.updateTarea(tarea2Test)).called(1);
      verifyNever(mockApiService.getTareas());
      expect(tareaProvider.tareas.length, 1);
      expect(tareaProvider.tareas[0].id, tarea2Test.id);
      expect(tareaProvider.tareas[0].titulo, tarea2Test.titulo);
      expect(tareaProvider.tareas[0].descripcion, tarea2Test.descripcion);
      expect(tareaProvider.tareas[0].completada, tarea2Test.completada);
    });
  });

  group('Eliminar tarea', () {
    test('debe eliminar la tarea correctamente', () async {

      tareaProvider.tareas = [
        Tarea(id: 1, titulo: 'Tarea a eliminar', descripcion: 'Descripción')
      ]; 

      when(mockApiService.deleteTarea(1)).thenAnswer((_) async => null);

      await tareaProvider.eliminarTarea(1);

      verify(mockApiService.deleteTarea(1)).called(1);
      verifyNever(mockApiService.getTareas());
      expect(tareaProvider.tareas, []);
    });
  });
}