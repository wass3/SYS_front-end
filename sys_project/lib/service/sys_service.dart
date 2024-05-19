import 'dart:convert';
import 'package:http/http.dart' as http;

class SysService {
  static const String BASE_URL = 'http://localhost:3000'; // Reemplaza con la URL de tu API

  Future<String> getSystemInfo() async {
    try {
      final response = await http.get(Uri.parse('$BASE_URL/system_info'));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Error al obtener información del sistema');
      }
    } catch (e) {
      throw Exception('Error de red: $e');
    }
  }

  Future<void> updateSystemSettings(Map<String, dynamic> settings) async {
    try {
      final response = await http.put(
        Uri.parse('$BASE_URL/system_settings'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(settings),
      );
      if (response.statusCode != 200) {
        throw Exception('Error al actualizar la configuración del sistema');
      }
    } catch (e) {
      throw Exception('Error de red: $e');
    }
  }
}
