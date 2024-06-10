class Preferencia {
  final int id;
  final int user_id;
  final int amigo_id;

  Preferencia({
    required this.id,
    required this.user_id,
    required this.amigo_id,
  });

  factory Preferencia.fromJson(Map<String, dynamic> json) {
    return Preferencia(
      id: json['id'] as int,
      user_id: json['user_id'] as int,
      amigo_id: json['amigo_id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'amigo_id': amigo_id,
    };
  }
}
