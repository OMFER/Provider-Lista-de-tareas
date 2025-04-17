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
            apiService: ApiService(baseUrl: 'https://jsonplaceholder.typicode.com'),
            ),
          ),
        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Provider-Lista-de-tareas',
        theme: ThemeData.dark(),
        home: ListaTareas(),
      )
    );
  }
}
