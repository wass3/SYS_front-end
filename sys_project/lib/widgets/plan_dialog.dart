// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:sys_project/models/plan.dart';
import 'package:sys_project/service/plan_service.dart';

class AddPlanDialog extends StatefulWidget {
  const AddPlanDialog({Key? key}) : super(key: key);

  @override
  _AddPlanDialogState createState() => _AddPlanDialogState();
}

class _AddPlanDialogState extends State<AddPlanDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dayHourController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  bool _allFieldsCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _titleController,
          onChanged: (_) => _checkFields(),
          decoration: InputDecoration(
            labelText: 'Título del Plan',
          ),
        ),
        SizedBox(height: 16),
        TextField(
          controller: _dayHourController,
          onChanged: (_) => _checkFields(),
          decoration: InputDecoration(
            labelText: 'Fecha y Hora (YYYY-MM-DD HH:MM)',
          ),
        ),
        SizedBox(height: 16),
        TextField(
          controller: _placeController,
          onChanged: (_) => _checkFields(),
          decoration: InputDecoration(
            labelText: 'Lugar',
          ),
        ),
        SizedBox(height: 16),
        _allFieldsCompleted
            ? ElevatedButton(
                onPressed: () async {
                  await _addPlan();
                },
                child: Text('Agregar Plan'),
              )
            : Text(
                'Completa todos los campos para poder crear el plan',
                style: TextStyle(color: Colors.red),
              ),
      ],
    );
  }

  void _checkFields() {
    setState(() {
      _allFieldsCompleted = _titleController.text.isNotEmpty &&
          _dayHourController.text.isNotEmpty &&
          _placeController.text.isNotEmpty;
    });
  }

  Future<void> _addPlan() async {
    String title = _titleController.text;
    String dayHour = _dayHourController.text;
    String place = _placeController.text;

    try {
      Plan newPlan = Plan(
        planId: 0,
        createdAt: DateTime.now(),
        title: title,
        dayhour: DateTime.parse(dayHour),
        place: place,
      );

      await PlanService.createPlan(newPlan);

      Navigator.of(context).pop();
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('No se pudo crear el plan: $e'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _dayHourController.dispose();
    _placeController.dispose();
    super.dispose();
  }
}
