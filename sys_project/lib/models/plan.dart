class Plan {
  final int planId;
  final DateTime createdAt;
  final String title;
  final DateTime? dayhour;
  final String place;
  final String? planImg;
  final String state;

  Plan({
    required this.planId,
    required this.createdAt,
    required this.title,
    this.dayhour,
    required this.place,
    this.planImg,
    this.state = 'CREATED',
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      planId: json['plan_id'] as int,
      createdAt: DateTime.parse(json['created_at']),
      title: json['title'] as String,
      dayhour: json['dayhour'] != null ? DateTime.parse(json['dayhour']) : null,
      place: json['place'] as String,
      planImg: json['plan_img'] as String?,
      state: json['state'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'plan_id': planId,
      'created_at': createdAt.toIso8601String(),
      'title': title,
      'dayhour': dayhour?.toIso8601String(),
      'place': place,
      'plan_img': planImg,
      'state': state,
    };
  }
}
