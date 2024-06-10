import 'package:flutter/material.dart';

class Disponibilidad {
  final int id;
  final int userId;
  final DateTime fecha;
  final TimeOfDay horaInicio;
  final TimeOfDay horaFin;

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
      horaInicio: _timeOfDayFromString(json['hora_inicio']),
      horaFin: _timeOfDayFromString(json['hora_fin']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'fecha': fecha.toIso8601String(),
      'hora_inicio': _timeOfDayToString(horaInicio),
      'hora_fin': _timeOfDayToString(horaFin),
    };
  }

  static TimeOfDay _timeOfDayFromString(String timeString) {
    final parts = timeString.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }

  static String _timeOfDayToString(TimeOfDay time) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    return '$hours:$minutes:00';
  }
}

