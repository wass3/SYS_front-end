import 'dart:convert';
import 'package:sys_project/models/user.dart';
import 'package:sys_project/providers/sys_provider.dart';

class UserService {
  static Future<List<User>> getUsers() async {
    try {
      final response = await SysProvider.getJsonData('/api/user');
      List<dynamic> usersJson = response['user'];
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
}
