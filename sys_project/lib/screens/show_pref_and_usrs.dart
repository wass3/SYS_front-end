// ignore_for_file: avoid_print, use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sys_project/models/disponibilidad.dart';
import 'package:sys_project/models/preferencia.dart';
import 'package:sys_project/screens/add_dispo_screen.dart';
import 'package:sys_project/screens/add_pref_screen.dart';
import 'package:sys_project/service/disponibilidad_service.dart';
import 'package:sys_project/service/preferencia_service.dart';
import 'package:intl/intl.dart';
import 'package:sys_project/service/user_service.dart';

class PrefAndDispoScreen extends StatefulWidget {
  const PrefAndDispoScreen({super.key});

  @override
  State<PrefAndDispoScreen> createState() => _PrefAndDispoScreen();
}

class _PrefAndDispoScreen extends State<PrefAndDispoScreen> {
  int _selectedIndex = 0;
  double _indicatorPosition = 0.0;
  List<Disponibilidad> _disponibilidades = [];
  List<Preferencia> _preferencias = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDisponibilidades();
    _loadPreferencias();
  }

  Future<void> _loadDisponibilidades() async {
    try {
      List<Disponibilidad> disponibilities = await DisponibilidadService.getDisponibilidadesByUserId(1);
      setState(() {
        _disponibilidades = disponibilities;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to load disponibilidades: $e')));
    }
  }

  Future<void> _loadPreferencias() async {
    try {
      List<Preferencia> preferencias = await PreferenciaService.getPreferenciaByUserId(1);
      print('preferencias $preferencias');
      setState(() {
        _preferencias = preferencias;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to load preferencias: $e')));
    }
  }

  Future<String> _getUserHandler(String userId) async {
    final user = await UserService.getUserById(userId);
    return user.userHandler;
  }

  void _onButtonPressed(int index) {
    setState(() {
      _selectedIndex = index;
      _indicatorPosition = index == 0 ? 0.0 : 0.5;
    });
  }

  void _navigateToForm() {
    if (_selectedIndex == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddDispoForm()),
      );
    } else if (_selectedIndex == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddPrefForm()),
      );
    }
  }

  String formatDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  String formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('HH:mm').format(dt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff050d09),
      appBar: AppBar(
        title: const Text('Preferencias y Usuarios'),
        backgroundColor: const Color(0xff050d09),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Color(0xff050d09),
            height: 50.0,
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () => _onButtonPressed(0),
                      child: const Text(
                        'Disponibilidad',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () => _onButtonPressed(1),
                      child: const Text(
                        'Usuarios',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  left: MediaQuery.of(context).size.width * _indicatorPosition + MediaQuery.of(context).size.width * 0.25 - 45,
                  top: 48.0,
                  child: Container(
                    width: 100.0,
                    height: 2.0,
                    color: Color(0xff35e789),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Color(0xff050d09),
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : IndexedStack(
                      index: _selectedIndex,
                      children: [
                        ListView.builder(
                          itemCount: _disponibilidades.length,
                          itemBuilder: (context, index) {
                            Disponibilidad disponibilidad = _disponibilidades[index];
                            String formattedDate = formatDate(disponibilidad.fecha);
                            String formattedStartTime = formatTimeOfDay(disponibilidad.horaInicio);
                            String formattedEndTime = formatTimeOfDay(disponibilidad.horaFin);
                            return ListTile(
                              title: Text(
                                'Disponible día $formattedDate de $formattedStartTime a $formattedEndTime',
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                          },
                        ),
                        ListView.builder(
                          itemCount: _preferencias.length,
                          itemBuilder: (context, index) {
                            Preferencia preferencia = _preferencias[index];
                            return FutureBuilder<String>(
                              future: _getUserHandler('${preferencia.amigo_id}'),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  String userName = snapshot.data ?? 'No data';
                                  return ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      backgroundImage: NetworkImage('https://banner2.cleanpng.com/20180329/zue/kisspng-computer-icons-user-profile-person-5abd85306ff7f7.0592226715223698404586.jpg'),
                                    ),
                                    title: Text(
                                      userName,
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  );
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton(
          onPressed: _navigateToForm,
          backgroundColor: Color(0xff35e789),
          child: Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
