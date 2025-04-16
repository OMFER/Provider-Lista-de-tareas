
class Tarea{
  final String id;
  final String titulo;
  final String descripcion;
  final String hora;
  bool completada;

  Tarea({required this.id, required this.titulo, required this.descripcion, required this.hora, this.completada = false});

  factory Tarea.fromJson(Map<String, dynamic> json) {
    return Tarea(
      id: json['id'],
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      hora: json['hora'],
      completada: json['completada'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descripcion': descripcion,
      'hora': hora,
      'completada': completada,
    };
  }

}