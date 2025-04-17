import 'package:flutter_test/flutter_test.dart';
import 'package:lista_de_tareas/models/model_tarea.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:lista_de_tareas/providers/tarea_prov.dart';
import 'package:lista_de_tareas/services/api_service.dart'; 

class MockApiService extends Mock implements ApiService {}

@GenerateMocks([ApiService])
void main() {
  late TareaProvider tareaProvider;
  late MockApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
    tareaProvider = TareaProvider(apiService: mockApiService);
  });

  final tarea1Test = Tarea(id: 1, titulo: 'Tarea 1', descripcion: 'Descripción de la tarea 1', completada: false);
  final tarea2Test = Tarea(id: 2, titulo: 'Tarea 2', descripcion: 'Descripción de la tarea 2', completada: false);


  group('Cargar tareas', () {
    test('debe cargar las tareas correctamente', () async {
      when(mockApiService.getTareas()).thenAnswer((_) async => [tarea1Test]);
      await tareaProvider.cargarTareas();
      expect(tareaProvider.tareas, [tarea1Test]);
      verify(mockApiService.getTareas()).called(1);
    });
  });

  group('Agregar tarea', () {
    test('debe agregar la tarea correctamente', () async {
      when(mockApiService.createTarea(tarea2Test)).thenAnswer((_) async => tarea1Test);
      await tareaProvider.crearTarea(tarea2Test);
      expect(tareaProvider.tareas, [tarea2Test]);
      verify(mockApiService.createTarea(tarea2Test)).called(1);
    });
  });

}