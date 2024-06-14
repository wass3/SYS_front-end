import 'dart:convert';
import 'package:sys_project/models/user.dart';
import 'package:sys_project/providers/sys_provider.dart';

class UserService {
  static Future<List<User>> getUsers() async {
    try {
      final response = await SysProvider.getJsonData('/api/user');
      print(response['users']);
      List<dynamic> usersJson = response['users'];
      List<User> users = usersJson.map<User>((data) => User.fromJson(data)).toList();
      return users;
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }

  static Future<User> getUserById(String userId) async {
    try {
      final response = await SysProvider.getJsonData('/api/user/$userId');
      return User.fromJson(response);
    } catch (e) {
      throw Exception('Failed to load user: $e');
    }
  }

  static Future<User> createUser(User newUser) async {
    try {
      final response = await SysProvider.postJsonData('/users', newUser.toJson());
      return User.fromJson(jsonDecode(response));
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  static Future<User> updateUser(String userId, User updatedUser) async {
    try {
      final response = await SysProvider.putJsonData('/users/$userId', updatedUser.toJson());
      return User.fromJson(jsonDecode(response));
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  static Future<void> deleteUser(String userId) async {
    try {
      await SysProvider.deleteData('/users/$userId');
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }

  static Future<Map<String, dynamic>> login(String email, String password) async {
  try {
    final data = {'email_address': email, 'password': password};
    print('data: $data');
    final response = await SysProvider.postJsonData('/api/user/login', data);
    print('response: $response');
    final responseData = jsonDecode(response);
    
    if (responseData.containsKey('token')) {
      // Si la respuesta contiene un token, devolver los datos del usuario y el token
      return {
        'userData': responseData,
      };
    } else {
      // Si no contiene un token, lanzar una excepción
      throw Exception('Token not found in response');
    }
  } catch (e) {
    throw Exception('Failed to login: $e');
  }
}

}


