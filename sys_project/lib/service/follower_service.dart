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

  static Future<Follower> createFollower(Follower newFollower) async {
    try {
      final response = await SysProvider.postJsonData('/api/followers', newFollower.toJson());
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
