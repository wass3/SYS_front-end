// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:sys_project/models/plan.dart';
import 'package:sys_project/service/plan_service.dart';
import 'package:intl/intl.dart'; // Asegúrate de agregar esta importación para formatear fechas

class LargeCardList extends StatefulWidget {
  const LargeCardList({Key? key}) : super(key: key);

  @override
  _LargeCardListState createState() => _LargeCardListState();
}

class _LargeCardListState extends State<LargeCardList> {
  late Future<List<Plan>> _futurePlans;

  @override
  void initState() {
    super.initState();
    _futurePlans = PlanService.getPlans();
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
          final plans = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: plans.length,
            itemBuilder: (context, index) {
              final plan = plans[index];
              return Column(
                children: [
                  LargeCard(plan: plan),
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

  const LargeCard({Key? key, required this.plan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

  return Card(
    color: const Color(0xff333534),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    child: Padding(
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
        ],
      ),
    ),
  );
}
}
