class Disponibilidad {
  final int id;
  final int userId;
  final DateTime fecha;
  final DateTime horaInicio;
  final DateTime horaFin;

  Disponibilidad({
    required this.id,
    required this.userId,
    required this.fecha,
    required this.horaInicio,
    required this.horaFin,
  });

  factory Disponibilidad.fromJson(Map<String, dynamic> json) {
    return Disponibilidad(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      fecha: DateTime.parse(json['fecha']),
      horaInicio: DateTime.parse(json['hora_inicio']),
      horaFin: DateTime.parse(json['hora_fin']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'fecha': fecha.toIso8601String(),
      'hora_inicio': horaInicio.toIso8601String(),
      'hora_fin': horaFin.toIso8601String(),
    };
  }
}
