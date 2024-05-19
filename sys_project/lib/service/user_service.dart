import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sys_project/models/user.dart';
import 'package:sys_project/providers/sys_provider.dart';

class UserService {
  static Future<List<User>> getUsers() async {
    try {
      final response = await SysProvider.getJsonData('/users');
      List<User> users = response.map<User>((data) => User.fromJson(data)).toList();
      return users;
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }

  static Future<User> getUserById(String userId) async {
    try {
      final response = await SysProvider.getJsonData('/users/$userId');
      
      List<User> users = response.map<User>((data) => User.fromJson(data)).toList();
      User user = users[0];
      return user;
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
