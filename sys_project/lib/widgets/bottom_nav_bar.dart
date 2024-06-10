// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sys_project/screens/add_dispo_screen.dart';
import 'package:sys_project/screens/calendar_screen.dart';
import 'package:sys_project/screens/home_page.dart';
import 'package:sys_project/screens/profile.dart';
import 'package:sys_project/screens/search.dart';
import 'package:sys_project/screens/show_pref_and_usrs.dart';


class BottomNavBar extends StatefulWidget {
  final int selectedIndex;

  const BottomNavBar({Key? key, required this.selectedIndex}) : super(key: key);
  
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
   late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  bool isSunday() {
    // Get current day and check if it's Sunday (day number 7).
    return DateTime.now().weekday == 1;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
            color: const Color(0xff050d09),
            border: Border.all(color: const Color(0xff050d09)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Container(
            height: kBottomNavigationBarHeight + 16,
            decoration: BoxDecoration(
              color: const Color(0xff1C1D1C),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.home, size: 35, color: _selectedIndex == 0 ? Color(0xff35e789) : Color(0xffddeee5)),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 0;
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.calendar_month, size: 35, color: _selectedIndex == 1 ? Color(0xff35e789) : Color(0xffddeee5)),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 1;
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CalendarScreen()));
                    });
                  },
                ),
                if (isSunday()) 
                  Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 121, 120, 121),
                      ),
                      child: IconButton(
                            icon: Icon(Icons.stream_outlined, size: 35, color: Color.fromARGB(255, 53, 231, 77)),
                            onPressed: () {
                              setState(() {
                                _selectedIndex = 3;
                                Navigator.push(context, MaterialPageRoute(builder: (context) => PrefAndDispoScreen()));
                              });
                            },
                          ),
                    ),

                IconButton(
                  icon: Icon(Icons.search, size: 35, color: _selectedIndex == 2 ? Color(0xff35e789) : Color(0xffddeee5)),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 2;
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.settings, size: 35, color: _selectedIndex == 3 ? Color(0xff35e789) : Color(0xffddeee5)),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 3;
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class NavIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const NavIconButton({Key? key, required this.icon, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, size: 35, color: const Color(0xffddeee5)),
      onPressed: onPressed,
    );
  }
}

