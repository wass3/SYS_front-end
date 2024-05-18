// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sys_project/screens/screens.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/homepage': (_) => HomePage(),
    '/login': (_) => Login(),
    '/register': (_) => Register(),
    '/profile': (_) => Profile(),
    '/calendar': (_) => CalendarScreen(),
  };
}

