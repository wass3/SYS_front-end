// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sys_project/widgets/bottom_nav_bar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart' as intl;

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  IconData _calendarIcon = Icons.view_module;
  List<Widget> _selectedDayPlans = [];

  @override
  Widget build(BuildContext context) {
    var kFirstDay = DateTime(2010, 10, 16);
    var kLastDay = DateTime(2030, 3, 14);

    String formattedMonthYear = intl.DateFormat('MMMM y').format(_focusedDay);
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 45, left: 15),
                color: Color(0xff050d09),
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formattedMonthYear,
                      style: TextStyle(color: Color(0xffddeee5), fontSize: 24),
                    ),
                    IconButton(
                      icon: Icon(_calendarIcon, color: Color(0xffddeee5)),
                      onPressed: () {
                        _changeCalendarFormat(
                          _calendarFormat == CalendarFormat.month
                              ? CalendarFormat.week
                              : CalendarFormat.month,
                        );
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff050d09),
                    border: Border.all(color: Color(0xff050d09)),
                  ),
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: TableCalendar(
                    sixWeekMonthsEnforced: true, // Hacer que todos los meses tengan 6 semanas
                    calendarStyle: CalendarStyle(
                      tablePadding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                      defaultTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      weekendTextStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      outsideTextStyle: TextStyle(color: Colors.grey),
                    ),
                    rowHeight: 53,
                    headerVisible: false,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    firstDay: kFirstDay,
                    lastDay: kLastDay,
                    focusedDay: _focusedDay,
                    calendarFormat: _calendarFormat,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                          _selectedDayPlans = _plansForSelectedDay(_selectedDay!);
                        });
                      }
                    },
                    onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      }
                    },
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff050d09),
                    border: Border.all(color: Color(0xff050d09)),
                  ),
                  padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
                  child: ListView(
                    children: _selectedDayPlans.map((plan) => Container(
                      color: Color(0xff050d09),
                      child: plan,
                    )).toList(),
                  ),
                ),
              ),
              const BottomNavBar(selectedIndex: 1),
              Container(height: 26, color: Color(0xff050d09)),
            ],
          ),
          Positioned(
            bottom: 130,
            right: 16,
            child: FloatingActionButton(
              backgroundColor: Color(0xff1b894f),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              onPressed: () {
                // Añadir aquí la lógica para el botón flotante
              },
              child: Icon(Icons.add, color: Color(0xffddeee5)),
            ),
          ),
        ],
      ),
    );
  }

  void _changeCalendarFormat(CalendarFormat format) {
    setState(() {
      _calendarFormat = format;
      switch (format) {
        case CalendarFormat.month:
          _calendarIcon = Icons.view_module;
          break;
        case CalendarFormat.week:
          _calendarIcon = Icons.view_week;
          break;
        case CalendarFormat.twoWeeks:
          _calendarIcon = Icons.date_range;
          break;
        default:
          _calendarIcon = Icons.view_module;
          break;
      }
    });
  }

  List<Widget> _plansForSelectedDay(DateTime selectedDay) {
    List<Widget> plans = [];
    for (int i = 0; i < 8; i++) {
      plans.add(Container(
        margin: EdgeInsets.all(10),
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xff333534),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          children: [
            Container(
              width: 35,
              height: 35,
              margin: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                  image: AssetImage('assets/user_img.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Plan $i',
                  style: TextStyle(color: Color(0xffddeee5)),
                ),
              ),
            ),
          ],
        ),
      ));
    }
    return plans;
  }
}
