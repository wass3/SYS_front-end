import 'package:flutter/material.dart';
import 'package:sys_project/models/disponibilidad.dart';
import 'package:sys_project/service/disponibilidad_service.dart';

class AddDispoForm extends StatefulWidget {
  const AddDispoForm({super.key});

  @override
  State<AddDispoForm> createState() => _AddDispoFormState();
}

class _AddDispoFormState extends State<AddDispoForm> {
  int _selectedIndex = 0;
  double _indicatorPosition = 0.0;
  List<Disponibilidad> _disponibilidades = [];
  List<String> _users = [
    'Usuario 1',
    'Usuario 2',
    'Usuario 3',
    'Usuario 4',
    'Usuario 5',
  ];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDisponibilidades();
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to load disponibilities: $e')));
    }
  }

  void _onButtonPressed(int index) {
    setState(() {
      _selectedIndex = index;
      _indicatorPosition = index == 0 ? 0.0 : 0.5;
    });
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
            color: Colors.grey[800],
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
                    width: 100.0,  // Ajusta el ancho de la línea
                    height: 2.0,
                    color: Color(0xff35e789),  // Cambia el color a verde
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : IndexedStack(
                    index: _selectedIndex,
                    children: [
                      ListView.builder(
                        itemCount: _disponibilidades.length,
                        itemBuilder: (context, index) {
                          Disponibilidad disponibilidad = _disponibilidades[index];
                          return ListTile(
                            title: Text(
                              'Fecha: ${disponibilidad.fecha.toString()} - Inicio: ${disponibilidad.horaInicio.toString()} - Fin: ${disponibilidad.horaFin.toString()}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        },
                      ),
                      ListView.builder(
                        itemCount: _users.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              _users[index],
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}