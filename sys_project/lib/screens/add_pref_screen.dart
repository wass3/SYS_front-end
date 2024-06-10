import 'package:flutter/material.dart';
import 'package:sys_project/models/user.dart';
import 'package:sys_project/service/user_service.dart';
import 'package:sys_project/widgets/bottom_nav_bar.dart';

class AddPrefForm extends StatelessWidget {
  const AddPrefForm({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: SearchScreen(),
    );
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<User> _users = [];
  Set<int> _selectedUsers = Set();

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
        leading: IconButton(
          icon: Text('Seleccionar (${_selectedUsers.length})'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                      _users[index].userImg,
                    ),
                  ),
                  title: Text(
                    _users[index].name,
                    style: TextStyle(color: Color(0xffddeee5)),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      _selectedUsers.contains(_users[index].userId)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: _selectedUsers.contains(_users[index].userId)
                          ? Colors.red
                          : null,
                    ),
                    onPressed: () {
                      setState(() {
                        if (_selectedUsers.contains(_users[index].userId)) {
                          _selectedUsers.remove(_users[index].userId);
                        } else {
                          _selectedUsers.add(_users[index].userId);
                        }
                      });
                    },
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
    try {
      print('Buscando usuarios...');
      List<User> users = await UserService.getUsers();
      print('Usuarios encontrados: ${users.length}');
      setState(() {
        _users = users;
      });
    } catch (e) {
      print('Error al obtener usuarios: $e');
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
