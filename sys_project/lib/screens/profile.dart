// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sys_project/screens/login.dart';
import 'package:sys_project/widgets/bottom_nav_bar.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.only(top: 44.0),
            decoration: BoxDecoration(
              color: Color(0xff050d09),
              border: Border.all(color: Color(0xff050d09)),
            ),
            child: Column(
              children: [
                _buildProfileHeader(),
                _buildStatsRow(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only( left: 24.0, right: 24.0),
                    child: Column(
                      children: [
                        _buildSettingsList(),
                        SizedBox(height: 24.0),
                        _buildLogoutButton(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const BottomNavBar(selectedIndex: 3),
        Container(
          height: 26,
          color: Color(0xff050d09),
        ),
      ],
    );
  }

  Widget _buildProfileHeader() {
    return Padding(
      padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 24.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40.0,
            backgroundColor: Color(0xff97e2ba),
            child: Image.asset('assets/user_img.png'),
          ),
          SizedBox(width: 24.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '@username',
                  style: TextStyle(
                    color: Color(0xffddeee5),
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
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
    );
  }

  Widget _buildStatsRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatsColumn('15', 'Plans'),
          _buildVerticalDivider(),
          _buildStatsColumn('10', 'Followers'),
          _buildVerticalDivider(),
          _buildStatsColumn('5', 'Following'),
        ],
      ),
    );
  }

  Widget _buildStatsColumn(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            color: Color(0xffddeee5),
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(color: Color(0xffddeee5)),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      width: 1.0,
      height: 32.0,
      color: Color(0xffddeee5),
    );
  }

  Widget _buildSettingsList() {
    List<String> settings = [
      'Appearance',
      'Sounds',
      'General',
      'About',
      'Privacy',
      'Account',
      'Notifications',
      'Security',
    ];

    return Column(
      children: settings.map((title) => _profileSettingContainer(title)).toList(),
    );
  }

  Widget _profileSettingContainer(String title) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.only(bottom: 8.0),
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
            size: 16.0,
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await logout(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      },
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(Size(double.infinity, 50.0)),
        backgroundColor: MaterialStateProperty.all(Color(0xffddeee5).withOpacity(0.2)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      child: Text(
        'Log out',
        style: TextStyle(
          color: Color.fromARGB(255, 201, 46, 54),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

