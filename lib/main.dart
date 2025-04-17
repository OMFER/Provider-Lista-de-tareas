import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/tarea_prov.dart';
import 'services/api_service.dart';
import 'screens/lista_tareas.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TareaProvider(
            apiService: ApiService(baseUrl: 'http://10.0.2.2:3000'),
            ),
          ),
        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lista de Tareas',
        theme: ThemeData.dark(),
        home:const ListaTareas(),
      )
    );
  }
}
