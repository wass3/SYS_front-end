import 'dart:convert';
import 'package:sys_project/models/disponibilidad.dart';
import 'package:sys_project/providers/sys_provider.dart';

class DisponibilidadService {
  static Future<List<Disponibilidad>> getDisponibilidades() async {
    try {
      final response = await SysProvider.getJsonData('/api/disponibilidades');
      List<dynamic> disponibilidadesJson = response['disponibilidades'];
      List<Disponibilidad> disponibilidades = disponibilidadesJson.map<Disponibilidad>((data) => Disponibilidad.fromJson(data)).toList();
      return disponibilidades;
    } catch (e) {
      throw Exception('Failed to load disponibilidades: $e');
    }
  }

  static Future<Disponibilidad> getDisponibilidadById(int id) async {
    try {
      final response = await SysProvider.getJsonData('/api/disponibilidades/$id');
      return Disponibilidad.fromJson(response);
    } catch (e) {
      throw Exception('Failed to load disponibilidad: $e');
    }
  }

  static Future<Disponibilidad> createDisponibilidad(Disponibilidad newDisponibilidad) async {
    try {
      final response = await SysProvider.postJsonData('/api/disponibilidades', newDisponibilidad.toJson());
      return Disponibilidad.fromJson(jsonDecode(response));
    } catch (e) {
      throw Exception('Failed to create disponibilidad: $e');
    }
  }

  static Future<Disponibilidad> updateDisponibilidad(int id, Disponibilidad updatedDisponibilidad) async {
    try {
      final response = await SysProvider.putJsonData('/api/disponibilidades/$id', updatedDisponibilidad.toJson());
      return Disponibilidad.fromJson(jsonDecode(response));
    } catch (e) {
      throw Exception('Failed to update disponibilidad: $e');
    }
  }

  static Future<void> deleteDisponibilidad(int id) async {
    try {
      await SysProvider.deleteData('/api/disponibilidades/$id');
    } catch (e) {
      throw Exception('Failed to delete disponibilidad: $e');
    }
  }
}
