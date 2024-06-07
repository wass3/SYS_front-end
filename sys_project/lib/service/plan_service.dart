import 'dart:convert';
import 'package:sys_project/models/plan.dart';
import 'package:sys_project/providers/sys_provider.dart';

class PlanService {
  static Future<List<Plan>> getPlans() async {
    try {
      final response = await SysProvider.getJsonData('/api/plan');
      
      print('sigue funcionando ${response['plan']}');

      List<dynamic> plansJson = response['plan'];
      List<Plan> plans = plansJson.map<Plan>((data) => Plan.fromJson(data)).toList();
      print('Plans: $plans');
      return plans;
    } catch (e) {
      throw Exception('Failed to load plans: $e');
    }
  }

  static Future<List<Plan>> getPlansForDay(DateTime date) async {
    try {
      final response = await SysProvider.getJsonData('/api/plan/day/${date.year}/${date.month}/${date.day}');
      
      List<dynamic> plansJson = response['plan'];
      List<Plan> plans = plansJson.map<Plan>((data) => Plan.fromJson(data)).toList();
      print('Plans: $plans');
      return plans;
    } catch (e) {
      throw Exception('Failed to load plans for day: $e');
    }
  }

  static Future<Plan> getPlanById(int planId) async {
    try {
      final response = await SysProvider.getJsonData('/api/plan/$planId');
      return Plan.fromJson(response);
    } catch (e) {
      throw Exception('Failed to load plan: $e');
    }
  }

  static Future<Plan> createPlan(Plan newPlan) async {
    try {
      final response = await SysProvider.postJsonData('/api/plan/create', newPlan.toJson());
      return Plan.fromJson(jsonDecode(response));
    } catch (e) {
      throw Exception('Failed to create plan: $e');
    }
  }

  static Future<Plan> updatePlan(int planId, Plan updatedPlan) async {
    try {
      final response = await SysProvider.putJsonData('/api/plan/$planId', updatedPlan.toJson());
      return Plan.fromJson(jsonDecode(response));
    } catch (e) {
      throw Exception('Failed to update plan: $e');
    }
  }

  static Future<void> deletePlan(int planId) async {
    try {
      await SysProvider.deleteData('/api/plan/$planId');
    } catch (e) {
      throw Exception('Failed to delete plan: $e');
    }
  }
}

