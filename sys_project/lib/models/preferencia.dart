class Preferencia {
  final int id;
  final int userId;
  final int amigoId;

  Preferencia({
    required this.id,
    required this.userId,
    required this.amigoId,
  });

  factory Preferencia.fromJson(Map<String, dynamic> json) {
    return Preferencia(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      amigoId: json['amigo_id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'amigo_id': amigoId,
    };
  }
}
