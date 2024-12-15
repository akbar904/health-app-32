import 'package:flutter/material.dart';
import 'package:my_app/models/course.dart';
import 'package:my_app/ui/common/app_colors.dart';
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
        name: _nameController.text.trim(),
        professor: _professorController.text.trim(),
        schedule: _scheduleController.text.trim(),
        credits: int.parse(_creditsController.text),
        description: _descriptionController.text.trim(),
      );

      widget.onSubmit(course);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: kcSurfaceWhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Add New Course',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: kcTextPrimary,
              ),
            ),
            verticalSpaceMedium,
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Course Name',
                prefixIcon: Icon(Icons.book_outlined),
              ),
              validator: (value) =>
                  value?.isEmpty == true ? 'Please enter course name' : null,
            ),
            verticalSpaceSmall,
            TextFormField(
              controller: _professorController,
              decoration: const InputDecoration(
                labelText: 'Professor',
                prefixIcon: Icon(Icons.person_outline),
              ),
              validator: (value) =>
                  value?.isEmpty == true ? 'Please enter professor name' : null,
            ),
            verticalSpaceSmall,
            TextFormField(
              controller: _scheduleController,
              decoration: const InputDecoration(
                labelText: 'Schedule',
                prefixIcon: Icon(Icons.schedule_outlined),
              ),
              validator: (value) =>
                  value?.isEmpty == true ? 'Please enter schedule' : null,
            ),
            verticalSpaceSmall,
            TextFormField(
              controller: _creditsController,
              decoration: const InputDecoration(
                labelText: 'Credits',
                prefixIcon: Icon(Icons.stars_outlined),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value?.isEmpty == true) return 'Please enter credits';
                if (int.tryParse(value!) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
            verticalSpaceSmall,
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                prefixIcon: Icon(Icons.description_outlined),
              ),
              maxLines: 3,
              validator: (value) =>
                  value?.isEmpty == true ? 'Please enter description' : null,
            ),
            verticalSpaceMedium,
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: kcPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Add Course',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
