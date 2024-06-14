// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:sys_project/models/follower.dart';
import 'package:sys_project/providers/sys_provider.dart';

class FollowerService {
  static Future<List<Follower>> getFollowers() async {
    try {
      final response = await SysProvider.getJsonData('/api/followers');
      List<dynamic> followersJson = response['followers'];
      List<Follower> followers = followersJson.map<Follower>((data) => Follower.fromJson(data)).toList();
      return followers;
    } catch (e) {
      throw Exception('Failed to load followers: $e');
    }
  }

  static Future<Follower> getFollowerById(int followerId, int followedId) async {
    try {
      final response = await SysProvider.getJsonData('/api/followers/$followerId/$followedId');
      return Follower.fromJson(response);
    } catch (e) {
      throw Exception('Failed to load follower: $e');
    }
  }

  //Obtener todos los seguidores de un usuario
  static Future<List<Follower>> getFollowersByFollowedId(int followed_id) async {
    try {
      final response = await SysProvider.getJsonData('/api/followers/seguidores/$followed_id');
      List<dynamic> followersJson = response['followers'];
      List<Follower> followers = followersJson.map<Follower>((data) => Follower.fromJson(data)).toList();
      return followers;
    } catch (e) {
      throw Exception('Failed to load followers: $e');
    }
  }

  //Obtener el número de seguidores de un usuario
  static Future<int?> getNumberOfFollowers(int followed_id) async {
    try {
      final response = await SysProvider.getJsonData('/api/followers/seguidores/$followed_id/numero');
      List<dynamic> followersJson = response['followers'];
      int followers = followersJson.length;
      return followers;
    } catch (e) {
      print('error en getNumberOfFollowers');
      return 0;
    }
  }

  //Obtener todos los seguidos de un usuario
  static Future<List<Follower>> getFollowersByFollowerId(int follower_id) async {
    try {
      final response = await SysProvider.getJsonData('/api/followers/seguidos/$follower_id');
      List<dynamic> followersJson = response['followers'];
      List<Follower> followers = followersJson.map<Follower>((data) => Follower.fromJson(data)).toList();
      return followers;
    } catch (e) {
      throw Exception('Failed to load followers: $e');
    }
  }

  //Obtener el número de seguidos de un usuario
  static Future<int?> getNumberOfFollowed(int follower_id) async {
    try {
      final response = await SysProvider.getJsonData('/api/followers/seguidos/$follower_id/numero');
      List<dynamic> followersJson = response['followers'];
      int followed = followersJson.length;
      return followed;
    } catch (e) {
      print('error en getNumberOfFollowed');
      return 0;
    }
  }

  static Future<Follower> createFollower(Follower newFollower) async {
    try {
      final response = await SysProvider.postJsonData('/api/followers', newFollower.toJson());
      return Follower.fromJson(jsonDecode(response));
    } catch (e) {
      throw Exception('Failed to create follower: $e');
    }
  }

  static Future<Follower> follow(int follower, int followed) async {
    try {
      final follow = {
        'follower_id': follower,
        'followed_id': followed
      };
      final response = await SysProvider.postJsonData('/api/followers/follow/$follower/$followed', follow);
      return Follower.fromJson(jsonDecode(response));
    } catch (e) {
      throw Exception('Failed to create follower: $e');
    }
  }

  static Future<void> deleteFollower(int followerId, int followedId) async {
    try {
      await SysProvider.deleteData('/api/followers/$followerId/$followedId');
    } catch (e) {
      throw Exception('Failed to delete follower: $e');
    }
  }
}
