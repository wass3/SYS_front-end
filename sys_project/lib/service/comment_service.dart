import 'dart:convert';
import 'package:sys_project/models/comments.dart';
import 'package:sys_project/providers/sys_provider.dart';

class CommentService {
  static Future<List<Comment>> getComments() async {
    try {
      final response = await SysProvider.getJsonData('/api/comments');
      List<dynamic> commentsJson = response['comments'];
      List<Comment> comments = commentsJson.map<Comment>((data) => Comment.fromJson(data)).toList();
      return comments;
    } catch (e) {
      throw Exception('Failed to load comments: $e');
    }
  }

  static Future<List<Comment>> getCommentsByPlanId(int planId) async {
    try {
      final response = await SysProvider.getJsonData('/api/comments/plan/$planId');
      List<dynamic> commentsJson = response['comments'];
      List<Comment> comments = commentsJson.map<Comment>((data) => Comment.fromJson(data)).toList();
      return comments;
    } catch (e) {
      throw Exception('Failed to load comments by planId: $e');
    }
  }

  static Future<Comment> getCommentById(int commentId) async {
    try {
      final response = await SysProvider.getJsonData('/api/comments/$commentId');
      return Comment.fromJson(response);
    } catch (e) {
      throw Exception('Failed to load comment: $e');
    }
  }

  static Future<Comment> createComment(Comment newComment) async {
    try {
      final response = await SysProvider.postJsonData('/api/comments', newComment.toJson());
      return Comment.fromJson(jsonDecode(response));
    } catch (e) {
      throw Exception('Failed to create comment: $e');
    }
  }

  static Future<Comment> updateComment(int commentId, Comment updatedComment) async {
    try {
      final response = await SysProvider.putJsonData('/api/comments/$commentId', updatedComment.toJson());
      return Comment.fromJson(jsonDecode(response));
    } catch (e) {
      throw Exception('Failed to update comment: $e');
    }
  }

  static Future<void> deleteComment(int commentId) async {
    try {
      await SysProvider.deleteData('/api/comments/$commentId');
    } catch (e) {
      throw Exception('Failed to delete comment: $e');
    }
  }
}

