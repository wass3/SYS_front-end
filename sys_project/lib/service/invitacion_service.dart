import 'dart:convert';
import 'package:sys_project/models/invitacion.dart';
import 'package:sys_project/providers/sys_provider.dart';

class InvitacionService {
  static Future<List<Invitacion>> getInvitaciones() async {
    try {
      final response = await SysProvider.getJsonData('/api/invitaciones');
      List<dynamic> invitacionesJson = response['invitaciones'];
      List<Invitacion> invitaciones = invitacionesJson.map<Invitacion>((data) => Invitacion.fromJson(data)).toList();
      return invitaciones;
    } catch (e) {
      throw Exception('Failed to load invitaciones: $e');
    }
  }

  static Future<Invitacion> getInvitacionById(int invitacionId) async {
    try {
      final response = await SysProvider.getJsonData('/api/invitaciones/$invitacionId');
      return Invitacion.fromJson(response);
    } catch (e) {
      throw Exception('Failed to load invitacion: $e');
    }
  }

  static Future<Invitacion> createInvitacion(Invitacion newInvitacion) async {
    try {
      final response = await SysProvider.postJsonData('/api/invitaciones', newInvitacion.toJson());
      return Invitacion.fromJson(jsonDecode(response));
    } catch (e) {
      throw Exception('Failed to create invitacion: $e');
    }
  }

  static Future<Invitacion> updateInvitacion(int invitacionId, Invitacion updatedInvitacion) async {
    try {
      final response = await SysProvider.putJsonData('/api/invitaciones/$invitacionId', updatedInvitacion.toJson());
      return Invitacion.fromJson(jsonDecode(response));
    } catch (e) {
      throw Exception('Failed to update invitacion: $e');
    }
  }

  static Future<void> deleteInvitacion(int invitacionId) async {
    try {
      await SysProvider.deleteData('/api/invitaciones/$invitacionId');
    } catch (e) {
      throw Exception('Failed to delete invitacion: $e');
    }
  }
}
