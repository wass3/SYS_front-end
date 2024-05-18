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
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 45, left: 15),
            color: Color(0xff050d09),
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formattedMonthYear, // Mostrar mes y año dinámicamente
                  style: TextStyle(color: Color(0xffddeee5), fontSize: 24),
                ),
                IconButton(
                  icon: Icon(_calendarIcon, color: Color(0xffddeee5)),
                  onPressed: () {
                    // Aquí podrías abrir un menú desplegable si lo deseas, o simplemente cambiar el formato directamente
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
              height: MediaQuery.of(context).size.height / 2,
              
              child: TableCalendar(
                calendarStyle: CalendarStyle(
                  tablePadding: EdgeInsets.fromLTRB( 5, 10, 5, 0),
                  defaultTextStyle:TextStyle(color: Colors.blue),
                  weekNumberTextStyle:TextStyle(color: Colors.red),
                  weekendTextStyle:TextStyle(color: Colors.pink),
                  
                ),
                rowHeight: 60,
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
          Container(
            height: 2, 
            width: double.infinity, 
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xff050d09)),),),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff050d09),
                border: Border.all(color: Color(0xff050d09)),
              ),
              padding: EdgeInsets.fromLTRB( 5, 0, 5, 10),
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
    );
  }

  void _changeCalendarFormat(CalendarFormat format) {
    setState(() {
      _calendarFormat = format;
      // Actualizar el icono basado en el formato seleccionado
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
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                  image: AssetImage('assets/images/person_image.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Plan ${i + 1}',
                  style: TextStyle(color: Color(0xffddeee5)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.more_vert, color: Color(0xffddeee5)),
            ),
          ],
        ),
      ));
    }
    return plans;
  }

}

