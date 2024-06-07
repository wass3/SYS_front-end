// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:sys_project/models/plan.dart';
import 'package:sys_project/service/plan_service.dart';
import 'package:intl/intl.dart';

class LargeCardList extends StatefulWidget {
  final String filter;

  const LargeCardList({Key? key, required this.filter}) : super(key: key);

  @override
  _LargeCardListState createState() => _LargeCardListState();
}

class _LargeCardListState extends State<LargeCardList> {
  late Future<List<Plan>> _futurePlans;
  int? _expandedCardIndex;

  @override
  void initState() {
    super.initState();
    _futurePlans = PlanService.getPlans();
  }

  void _toggleExpanded(int index) {
    setState(() {
      if (_expandedCardIndex == index) {
        _expandedCardIndex = null;
      } else {
        _expandedCardIndex = index;
      }
    });
  }

  List<Plan> _applyFilter(List<Plan> plans, String filter) {
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = now.add(Duration(days: 7 - now.weekday));
    DateTime startOfMonth = DateTime(now.year, now.month, 1);
    DateTime endOfMonth = DateTime(now.year, now.month + 1, 0);

    switch (filter) {
      case 'Hoy':
        return plans.where((plan) =>
            plan.dayhour != null && plan.dayhour!.day == now.day && plan.dayhour!.month == now.month && plan.dayhour!.year == now.year).toList();
      case 'Próximos 7 días':
        return plans.where((plan) =>
            plan.dayhour != null && plan.dayhour!.isAfter(now) && plan.dayhour!.isBefore(endOfWeek)).toList();
      case 'Este mes':
        return plans.where((plan) =>
            plan.dayhour != null && plan.dayhour!.isAfter(startOfMonth) && plan.dayhour!.isBefore(endOfMonth)).toList();
      // Add other filters as necessary
      default:
        return plans;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Plan>>(
      future: _futurePlans,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Failed to load plans'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No plans available'));
        } else {
          final plans = _applyFilter(snapshot.data!, widget.filter);
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: plans.length,
            itemBuilder: (context, index) {
              final plan = plans[index];
              return Column(
                children: [
                  LargeCard(
                    key: UniqueKey(),  // Asegura una clave única para cada tarjeta
                    plan: plan,
                    isExpanded: _expandedCardIndex == index,
                    onToggleExpanded: () => _toggleExpanded(index),
                  ),
                  const SizedBox(height: 16),
                ],
              );
            },
          );
        }
      },
    );
  }
}


class LargeCard extends StatelessWidget {
  final Plan plan;
  final bool isExpanded;
  final VoidCallback onToggleExpanded;

  const LargeCard({
    Key? key,
    required this.plan,
    required this.isExpanded,
    required this.onToggleExpanded,
  }) : super(key: key);

  Color getStateColor(String state) {
    switch (state) {
      case 'CREATED':
        return Colors.blue;
      case 'IN_PROGRESS':
        return Colors.orange;
      case 'COMPLETED':
        return Colors.green;
      case 'CANCELLED':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggleExpanded,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xff333534),
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              plan.title,
              style: TextStyle(color: Color.fromARGB(255, 195, 240, 217), fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              plan.place,
              style: TextStyle(color: const Color(0xff050d09)),
            ),
            const SizedBox(height: 8),
            if (plan.dayhour != null) ...[
              Text(
                'Fecha y Hora: ${DateFormat('dd/MM/yyyy – kk:mm').format(plan.dayhour!)}',
                style: TextStyle(color: Colors.white),
              ),
            ],
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              decoration: BoxDecoration(
                color: getStateColor(plan.state),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                plan.state,
                style: TextStyle(color: Colors.white),
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              child: isExpanded
                  ? Column(
                      key: ValueKey('expanded-${plan.title}'), // Clave única basada en el título del plan
                      children: [
                        const SizedBox(height: 16),
                        Text(
                          'Detalles adicionales del plan...',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            print('boton accion');
                          },
                          child: Text('Acción'),
                        ),
                      ],
                    )
                  : SizedBox.shrink(
                      key: ValueKey('collapsed-${plan.title}'), // Clave única basada en el título del plan
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
