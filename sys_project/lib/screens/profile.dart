// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(color: Color(0xffddeee5))),
        backgroundColor: Color(0xff050d09),
      ),
      body: Container(
        color: Color(0xff050d09),
        child: Center(
          child: Text(
            'Profile',
            style: TextStyle(color: Color(0xffddeee5)),
          ),
        ),
      ),
    );
  }
}
