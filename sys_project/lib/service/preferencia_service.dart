import 'dart:convert';
import 'package:sys_project/models/preferencia.dart';
import 'package:sys_project/providers/sys_provider.dart';

class PreferenciaService {
  static Future<List<Preferencia>> getPreferencias() async {
    try {
      final response = await SysProvider.getJsonData('/api/preferencias');
      List<dynamic> preferenciasJson = response['preferencias'];
      List<Preferencia> preferencias = preferenciasJson.map<Preferencia>((data) => Preferencia.fromJson(data)).toList();
      return preferencias;
    } catch (e) {
      throw Exception('Failed to load preferencias: $e');
    }
  }

  static Future<Preferencia> getPreferenciaById(int id) async {
    try {
      final response = await SysProvider.getJsonData('/api/preferencias/$id');
      return Preferencia.fromJson(response);
    } catch (e) {
      throw Exception('Failed to load preferencia: $e');
    }
  }

  static Future<Preferencia> createPreferencia(Preferencia newPreferencia) async {
    try {
      final response = await SysProvider.postJsonData('/api/preferencias', newPreferencia.toJson());
      return Preferencia.fromJson(jsonDecode(response));
    } catch (e) {
      throw Exception('Failed to create preferencia: $e');
    }
  }

  static Future<void> deletePreferencia(int id) async {
    try {
      await SysProvider.deleteData('/api/preferencias/$id');
    } catch (e) {
      throw Exception('Failed to delete preferencia: $e');
    }
  }
}
