// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:sys_project/screens/profile.dart';
import 'package:sys_project/widgets/bottom_nav_bar.dart';
import 'package:sys_project/widgets/lista_planes.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hoy',
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
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Handle more icon pressed
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
                // Update UI for today's events
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_view_day, color: Color(0xffddeee5)),
              title: const Text(
                'Próximas 7 días',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                // Update UI for next 7 days' events
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
                // Update UI for this month's events
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
                // Update UI for activities
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
                // Update UI for favorites
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
                // Update UI for activity type
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
                // Update UI for location
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
                // Update UI for date
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
                  child: LargeCardList(),
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
                // Añadir aquí la lógica para el botón flotante
              },
              child: Icon(Icons.add, color: const Color(0xffddeee5)),
            ),
          ),
        ],
      ),
    );
  }
}
