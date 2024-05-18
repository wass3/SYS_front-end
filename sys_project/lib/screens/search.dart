import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search', style: TextStyle(color: Color(0xffddeee5))),
        backgroundColor: Color(0xff050d09),
      ),
      body: Container(
        color: Color(0xff050d09),
        child: Center(
          child: Text(
            'Search',
            style: TextStyle(color: Color(0xffddeee5)),
          ),
        ),
      ),
    );
  }
}