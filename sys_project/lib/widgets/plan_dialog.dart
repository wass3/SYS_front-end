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
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
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
          controller: _dateController,
          readOnly: true,
          onTap: () => _selectDate(context),
          decoration: InputDecoration(
            labelText: 'Fecha (YYYY-MM-DD)',
          ),
        ),
        SizedBox(height: 16),
        TextField(
          controller: _timeController,
          readOnly: true,
          onTap: () => _selectTime(context),
          decoration: InputDecoration(
            labelText: 'Hora (HH:MM)',
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
          _dateController.text.isNotEmpty &&
          _timeController.text.isNotEmpty &&
          _placeController.text.isNotEmpty;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
        _checkFields();
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      final now = DateTime.now();
      final selectedTime = DateTime(
          now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);
      setState(() {
        _timeController.text =
            "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}";
        _checkFields();
      });
    }
  }

  Future<void> _addPlan() async {
    String title = _titleController.text;
    String date = _dateController.text;
    String time = _timeController.text;
    String place = _placeController.text;

    try {
      DateTime dayHour = DateTime.parse("$date $time");
      Plan newPlan = Plan(
        planId: 0,
        createdAt: DateTime.now(),
        title: title,
        dayhour: dayHour,
        place: place,
      );

      await PlanService.createPlan(newPlan);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Plan creado'),
            content: Text('Se ha creado el plan correctamente'),
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
    _dateController.dispose();
    _timeController.dispose();
    _placeController.dispose();
    super.dispose();
  }
}
