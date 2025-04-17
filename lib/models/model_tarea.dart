
class Tarea{
  final int id;
  final String titulo;
  final String descripcion;
  bool completada;

  Tarea({
    required this.id,
    required this.titulo,
    required this.descripcion,
    this.completada = false
  });

  factory Tarea.fromJson(Map<String, dynamic> json) {
    return Tarea(
      id: json['id'] ?? 0,
      titulo: json['titulo'] ?? '',
      descripcion: json['descripcion'] ?? '',
      completada: json['completada'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descripcion': descripcion,
      'completada': completada,
    };
  }
}