// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xff050d09),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(24.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40.0,
                    backgroundColor: Color(0xff97e2ba),
                    child: Icon(
                      Icons.person,
                      color: Color(0xff050d09),
                      size: 32.0,
                    ),
                  ),
                  SizedBox(width: 24.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Username',
                          style: TextStyle(color: Color(0xffddeee5), fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Biography',
                          style: TextStyle(color: Color(0xffddeee5)),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xffddeee5),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        '15',
                        style: TextStyle(color: Color(0xffddeee5), fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Plans Made',
                        style: TextStyle(color: Color(0xffddeee5)),
                      ),
                    ],
                  ),
                  Container(
                    width: 1.0,
                    height: 32.0,
                    color: Color(0xffddeee5),
                  ),
                  Column(
                    children: [
                      Text(
                        '10',
                        style: TextStyle(color: Color(0xffddeee5), fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Followers',
                        style: TextStyle(color: Color(0xffddeee5)),
                      ),
                    ],
                  ),
                  Container(
                    width: 1.0,
                    height: 32.0,
                    color: Color(0xffddeee5),
                  ),
                  Column(
                    children: [
                      Text(
                        '5',
                        style: TextStyle(color: Color(0xffddeee5), fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Following',
                        style: TextStyle(color: Color(0xffddeee5)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                children: [
                  _profileSettingContainer('Appearance'),
                  _profileSettingContainer('Sounds'),
                  _profileSettingContainer('General'),
                  _profileSettingContainer('About'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileSettingContainer(String title) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(color: Color(0xffddeee5)),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Color(0xffddeee5),
          ),
        ],
      ),
    );
  }
}

