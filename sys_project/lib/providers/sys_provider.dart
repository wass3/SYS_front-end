// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SysProvider {
  static const _baseUrl = '192.168.56.1:3000';
  static String apiKey = 'Bearer 28316b7eb9286a713260cd929d645117451fc7c5db1ddf0b73c4c035acd95932152a32191587835597762bc1c4da058f787ad75a4bf255367f240977138220cd';
  static Future<Map<String, dynamic>> getJsonData(String endpoint) async {
    final url = Uri.http(_baseUrl, endpoint);
    final response = await http.get(url, headers: {'Authorization': apiKey});
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener datos');
    }
  }

  static Future<String> postJsonData(String endpoint, Map<String, dynamic> data) async {
    final url = Uri.http(_baseUrl, endpoint);
    print('url: $url');
    print('apikey: $apiKey');
    try {
      final response = await http.post(
        url,
        body: json.encode(data),
        headers: {
          'Authorization': apiKey,
          'Content-Type': 'application/json'
        },
      );
      print('response: ${response.statusCode}');
      return response.body;
    } catch (e) {
      throw Exception('Error al crear datos: $e');
    }
  }


  static Future<String> putJsonData(String endpoint, Map<String, dynamic> data) async {
    final url = Uri.http(_baseUrl, endpoint);
    final response = await http.put(
      url,
      body: json.encode(data),
      headers: {
        'Authorization': apiKey,
        'Content-Type': 'application/json'
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Error al actualizar datos');
    }
  }

  static Future<String> deleteData(String endpoint) async {
    final url = Uri.http(_baseUrl, endpoint);
    final response = await http.delete(url, headers: {'Authorization': apiKey});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Error al eliminar datos');
    }
  }
}
