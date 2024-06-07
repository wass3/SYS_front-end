// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sys_project/models/plan.dart';
import 'package:sys_project/service/plan_service.dart';
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

  final Color _primaryColor = Color(0xff050d09);
  final Color _secondaryColor = Color(0xffddeee5);
  final Color _highlightColor = Color(0xff1b894f);
  final Color _planBackgroundColor = Color(0xff333534);
  final DateTime _kFirstDay = DateTime(2010, 10, 16);
  final DateTime _kLastDay = DateTime(2030, 3, 14);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              _buildHeader(),
              _buildCalendar(),
              _buildPlansList(),
              const BottomNavBar(selectedIndex: 1),
              Container(height: 26, color: _primaryColor),
            ],
          ),
          _buildFloatingActionButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    String formattedMonthYear = intl.DateFormat('MMMM y').format(_focusedDay);
    return Container(
      padding: EdgeInsets.only(top: 45, left: 15),
      color: _primaryColor,
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            formattedMonthYear,
            style: TextStyle(color: _secondaryColor, fontSize: 24),
          ),
          IconButton(
            icon: Icon(_calendarIcon, color: _secondaryColor),
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
    );
  }

  Widget _buildCalendar() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: _primaryColor,
          border: Border.all(color: _primaryColor),
        ),
        child: TableCalendar(
          sixWeekMonthsEnforced: true,
          calendarStyle: CalendarStyle(
            tablePadding: EdgeInsets.fromLTRB(5, 10, 5, 0),
            defaultTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            weekendTextStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            outsideTextStyle: TextStyle(color: Colors.grey),
          ),
          rowHeight: 53,
          headerVisible: false,
          startingDayOfWeek: StartingDayOfWeek.monday,
          firstDay: _kFirstDay,
          lastDay: _kLastDay,
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) async {
            if (!isSameDay(_selectedDay, selectedDay)) {
              List<Widget> plans = await _plansForSelectedDay(selectedDay);
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                _selectedDayPlans = plans;
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
    );
  }

  Widget _buildPlansList() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: _primaryColor,
          border: Border.all(color: _primaryColor),
        ),
        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: _selectedDayPlans.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.event_busy, color: _secondaryColor, size: 80),
                    SizedBox(height: 10),
                    Text(
                      'No hay planes para este día',
                      style: TextStyle(color: _secondaryColor, fontSize: 18),
                    ),
                  ],
                ),
              )
            : ListView(
                padding: EdgeInsets.zero,
                children: _selectedDayPlans.map((plan) {
                  return Container(
                    color: _primaryColor,
                    child: plan,
                  );
                }).toList(),
              ),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return Positioned(
      bottom: 120,
      right: 16,
      child: FloatingActionButton(
        backgroundColor: _highlightColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: () {
          // Añadir aquí la lógica para el botón flotante
        },
        child: Icon(Icons.add, color: _secondaryColor),
      ),
    );
  }

  void _changeCalendarFormat(CalendarFormat format) {
    setState(() {
      _calendarFormat = format;
      _calendarIcon = format == CalendarFormat.month
          ? Icons.view_module
          : Icons.view_week;
    });
  }

  Future<List<Widget>> _plansForSelectedDay(DateTime selectedDay) async {
    // Llama al método getPlans() del servicio PlanService para obtener los planes correspondientes al día seleccionado
    List<Plan> plans = await PlanService.getPlans();
    List<Plan> plansFiltered = plans
        .where((plan) =>
            plan.dayhour != null &&
            plan.dayhour!.day == selectedDay.day &&
            plan.dayhour!.month == selectedDay.month &&
            plan.dayhour!.year == selectedDay.year)
        .toList();

    // Convierte cada plan en un Widget
    List<Widget> planWidgets = plansFiltered.map((plan) {
      return Container(
        margin: EdgeInsets.all(10),
        height: 50,
        decoration: BoxDecoration(
          color: _planBackgroundColor,
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
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                plan.title, // Mostrar el título del plan u otra información relevante
                style: TextStyle(color: _secondaryColor),
              ),
            ),
          ],
        ),
      );
    }).toList();

    return planWidgets;
  }
}
