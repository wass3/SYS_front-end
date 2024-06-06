class UserPlan {
  final int userId;
  final int planId;

  UserPlan({
    required this.userId,
    required this.planId,
  });

  factory UserPlan.fromJson(Map<String, dynamic> json) {
    return UserPlan(
      userId: json['user_id'] as int,
      planId: json['plan_id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'plan_id': planId,
    };
  }
}
