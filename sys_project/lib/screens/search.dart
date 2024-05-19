// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:sys_project/widgets/bottom_nav_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _users = [
    'Herman',
    'Alice',
    'Rosie',
    'Charlie',
    'Bob',
    'Sarah',
    'Sam',
    'Jessica',
    'Frank',
    'Ted',
  ];

  @override
  void initState() {
    super.initState();
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
                      'https://picsum.photos/250?image=$index',
                    ),
                  ),
                  title: Text(
                    _users[index],
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

  void _filterUsers() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _users = [
          'Herman',
          'Alice',
          'Rosie',
          'Charlie',
          'Bob',
          'Sarah',
          'Sam',
          'Jessica',
          'Frank',
          'Ted',
        ];
      } else {
        _users.retainWhere((user) =>
            user.toLowerCase().contains(_searchController.text.toLowerCase()));
      }
    });
  }
}

