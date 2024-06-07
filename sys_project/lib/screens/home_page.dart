// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:sys_project/screens/profile.dart';
import 'package:sys_project/widgets/bottom_nav_bar.dart';
import 'package:sys_project/widgets/lista_planes.dart';
import 'package:sys_project/widgets/plan_dialog.dart';
import 'package:sys_project/models/plan.dart';
import 'package:sys_project/service/plan_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Plan>> _futurePlans;
  String _filter = 'Hoy';

  @override
  void initState() {
    super.initState();
    _futurePlans = PlanService.getPlans();
  }

  void _applyFilter(String filter) {
    setState(() {
      _filter = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _filter,
          style: TextStyle(color: const Color(0xffddeee5)),
        ),
        backgroundColor: const Color(0xff050d09),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Color(0xffddeee5)),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              print('futuro chat');
            },
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xff212529),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(height: 40),
            ListTile(
              leading: const CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage('assets/user_img.png'),
              ),
              title: const Text(
                'UserName',
                style: TextStyle(
                  color: const Color(0xffddeee5),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.person, color: Color(0xffddeee5)),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Profile()));
                },
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.calendar_today, color: Color(0xffddeee5)),
              title: const Text(
                'Hoy',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                _applyFilter('Hoy');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_view_day, color: Color(0xffddeee5)),
              title: const Text(
                'Próximos 7 días',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                _applyFilter('Próximos 7 días');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month, color: Color(0xffddeee5)),
              title: const Text(
                'Este mes',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                _applyFilter('Este mes');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.local_activity, color: Color(0xffddeee5)),
              title: const Text(
                'Actividades preferidas',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                _applyFilter('Actividades preferidas');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite, color: Color(0xffddeee5)),
              title: const Text(
                'Favoritos',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                _applyFilter('Favoritos');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.ac_unit, color: Color(0xffddeee5)),
              title: const Text(
                'Tipo de actividad',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                _applyFilter('Tipo de actividad');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on, color: Color(0xffddeee5)),
              title: const Text(
                'Ubicación',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                _applyFilter('Ubicación');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.date_range, color: Color(0xffddeee5)),
              title: const Text(
                'Fecha',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                _applyFilter('Fecha');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  color: const Color(0xff050d09),
                  child: LargeCardList(filter: _filter),
                ),
              ),
              const BottomNavBar(selectedIndex: 0),
              Container(
                  width: double.infinity, height: 26, color: const Color(0xff050d09)),
            ],
          ),
          Positioned(
            bottom: 120,
            right: 16,
            child: FloatingActionButton(
              backgroundColor: const Color(0xff1b894f),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Añadir a un plan'),
                      content: AddPlanDialog(),
                    );
                  },
                );
              },
              child: Icon(Icons.add, color: const Color(0xffddeee5)),
            ),
          ),
        ],
      ),
    );
  }
}
