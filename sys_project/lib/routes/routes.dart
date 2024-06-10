// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sys_project/screens/screens.dart';
import 'package:sys_project/screens/show_pref_and_usrs.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/homepage': (_) => HomePage(),
    '/login': (_) => Login(),
    '/register': (_) => Register(),
    '/profile': (_) => Profile(),
    '/calendar': (_) => CalendarScreen(),
    '/search': (_) => SearchScreen(),
    '/disponibilidad': (_) => PrefAndDispoScreen(),
  };
}

