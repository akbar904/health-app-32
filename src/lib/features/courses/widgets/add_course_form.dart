import 'package:flutter/material.dart';
import 'package:my_app/models/course.dart';
import 'package:my_app/ui/common/ui_helpers.dart';

class AddCourseForm extends StatefulWidget {
  final Function(Course) onSubmit;

  const AddCourseForm({required this.onSubmit, super.key});

  @override
  State<AddCourseForm> createState() => _AddCourseFormState();
}

class _AddCourseFormState extends State<AddCourseForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _professorController = TextEditingController();
  final _scheduleController = TextEditingController();
  final _creditsController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _professorController.dispose();
    _scheduleController.dispose();
    _creditsController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final course = Course(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        professor: _professorController.text,
        schedule: _scheduleController.text,
        credits: int.parse(_creditsController.text),
        description: _descriptionController.text,
      );

      widget.onSubmit(course);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Course Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a course name';
                }
                return null;
              },
            ),
            verticalSpaceSmall,
            TextFormField(
              controller: _professorController,
              decoration: const InputDecoration(labelText: 'Professor'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a professor name';
                }
                return null;
              },
            ),
            verticalSpaceSmall,
            TextFormField(
              controller: _scheduleController,
              decoration: const InputDecoration(labelText: 'Schedule'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a schedule';
                }
                return null;
              },
            ),
            verticalSpaceSmall,
            TextFormField(
              controller: _creditsController,
              decoration: const InputDecoration(labelText: 'Credits'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter credits';
                }
                if (int.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
            verticalSpaceSmall,
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
            verticalSpaceMedium,
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Add Course'),
            ),
          ],
        ),
      ),
    );
  }
}
