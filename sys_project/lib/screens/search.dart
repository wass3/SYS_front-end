// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sys_project/models/user.dart';
import 'package:sys_project/widgets/bottom_nav_bar.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<User> _users = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
    _searchController.addListener(_filterUsers);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterUsers);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xff1C1D1C),
          ),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: TextStyle(color: Color(0xffddeee5)),
              border: InputBorder.none,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.search, color: Color(0xffddeee5)),
              ),
            ),
            style: TextStyle(color: Color(0xffddeee5)),
          ),
        ),
        backgroundColor: Color(0xff050d09),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      _users[index].imageUrl,
                    ),
                  ),
                  title: Text(
                    _users[index].name,
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {},
                    child: Text('Seguir'),
                  ),
                );
              },
            ),
          ),
          const BottomNavBar(selectedIndex: 2),
          Container(
            height: 26,
            color: Color(0xff050d09),
          ),
        ],
      ),
    );
  }

  Future<void> _fetchUsers() async {
    final response = await http.get(Uri.parse('https://localhost:3000/api/users'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      setState(() {
        _users = jsonResponse.map((data) => User.fromJson(data)).toList();
      });
    } else {
      print('Error al obtener usuarios: ${response.statusCode}');
    }
  }

  void _filterUsers() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _fetchUsers();
      } else {
        _users.retainWhere((user) =>
            user.name.toLowerCase().contains(_searchController.text.toLowerCase()));
      }
    });
  }
}

