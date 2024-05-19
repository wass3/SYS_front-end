// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SysProvider {
  static const _baseUrl = '192.168.56.1:3000';
  static String apiKey = '';


  static Future<Map<String, dynamic>> getJsonData(String endpoint) async {
    final url = Uri.http(_baseUrl, endpoint);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener datos');
    }
  }

  static Future<String> postJsonData(String endpoint, Map<String, dynamic> data) async {
    final url = Uri.https(_baseUrl, endpoint);
    final response = await http.post(url, body: json.encode(data));
    if (response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception('Error al crear datos');
    }
  }

  static Future<String> putJsonData(String endpoint, Map<String, dynamic> data) async {
    final url = Uri.https(_baseUrl, endpoint);
    final response = await http.put(url, body: json.encode(data));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Error al actualizar datos');
    }
  }

  static Future<String> deleteData(String endpoint) async {
    final url = Uri.https(_baseUrl, endpoint);
    final response = await http.delete(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Error al eliminar datos');
    }
  }
}
