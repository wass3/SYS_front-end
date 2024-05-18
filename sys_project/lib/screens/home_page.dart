// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:sys_project/widgets/bottom_nav_bar.dart';
import 'package:sys_project/widgets/lista_planes.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hoy', style: TextStyle(color: const Color(0xffddeee5)),),
        backgroundColor: const Color(0xff050d09),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Color(0xffddeee5)),
          onPressed: () {
            // Handle menu icon pressed
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Color(0xffddeee5)),
            onPressed: () {
              // Handle search icon pressed
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: const Color(0xff050d09),
              child: LargeCardList(),
            ),
          ),
          const BottomNavBar(selectedIndex: 0,),
          Container(width: double.infinity, height: 26, color: const Color(0xff050d09)),
        ],
      ),
    );
  }
}
