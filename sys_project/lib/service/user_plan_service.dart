import 'dart:convert';
import 'package:sys_project/models/user_plan.dart';
import 'package:sys_project/providers/sys_provider.dart';

class UserPlanService {
  static Future<List<UserPlan>> getUserPlans() async {
    try {
      final response = await SysProvider.getJsonData('/api/user_plans');
      List<dynamic> userPlansJson = response['user_plans'];
      List<UserPlan> userPlans = userPlansJson.map<UserPlan>((data) => UserPlan.fromJson(data)).toList();
      return userPlans;
    } catch (e) {
      throw Exception('Failed to load user plans: $e');
    }
  }

  static Future<List<UserPlan>> getPlansByUserId(int userId) async {
    try {
      final response = await SysProvider.getJsonData('/api/user_plan/user/$userId/plans');
      List<dynamic> userPlansJson = response['user_plans'];
      List<UserPlan> userPlans = userPlansJson.map<UserPlan>((data) => UserPlan.fromJson(data)).toList();
      return userPlans;
    } catch (e) {
      throw Exception('Failed to load user plans by planId: $e');
    }
  }

  static Future<List<UserPlan>> getUsersByPlanId(int planId) async {
    try {
      final response = await SysProvider.getJsonData('/api/user_plan/plan/$planId/users');
      List<dynamic> userPlansJson = response['user_plans'];
      List<UserPlan> userPlans = userPlansJson.map<UserPlan>((data) => UserPlan.fromJson(data)).toList();
      return userPlans;
    } catch (e) {
      throw Exception('Failed to load user plans by planId: $e');
    }
  }

  static Future<int> countUserPlans(int userId) async {
    try {
      List<UserPlan> plans = await getPlansByUserId(userId);
      return plans.length;
    } catch (e) {
      throw Exception('Failed to count user plans: $e');
    }
  }


  static Future<UserPlan> createUserPlan(UserPlan newUserPlan) async {
    try {
      final response = await SysProvider.postJsonData('/api/user_plans', newUserPlan.toJson());
      return UserPlan.fromJson(jsonDecode(response));
    } catch (e) {
      throw Exception('Failed to create user plan: $e');
    }
  }

  static Future<void> deleteUserPlan(int userId, int planId) async {
    try {
      await SysProvider.deleteData('/api/user_plans/$userId/$planId');
    } catch (e) {
      throw Exception('Failed to delete user plan: $e');
    }
  }
}
