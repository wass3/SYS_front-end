class Invitacion {
  final int invitacionId;
  final int planId;
  final int invitadoId;
  final String estado;
  final DateTime creadoEn;

  Invitacion({
    required this.invitacionId,
    required this.planId,
    required this.invitadoId,
    this.estado = 'PENDIENTE',
    required this.creadoEn,
  });

  factory Invitacion.fromJson(Map<String, dynamic> json) {
    return Invitacion(
      invitacionId: json['invitacion_id'] as int,
      planId: json['plan_id'] as int,
      invitadoId: json['invitado_id'] as int,
      estado: json['estado'] as String,
      creadoEn: DateTime.parse(json['creado_en']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'invitacion_id': invitacionId,
      'plan_id': planId,
      'invitado_id': invitadoId,
      'estado': estado,
      'creado_en': creadoEn.toIso8601String(),
    };
  }
}
