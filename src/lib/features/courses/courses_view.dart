import 'package:flutter/material.dart';
import 'package:my_app/features/courses/courses_viewmodel.dart';
import 'package:my_app/features/courses/widgets/add_course_form.dart';
import 'package:my_app/features/courses/widgets/course_card.dart';
import 'package:my_app/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class CoursesView extends StatelessWidget {
  const CoursesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CoursesViewModel>.reactive(
      viewModelBuilder: () => CoursesViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('My Courses'),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: AddCourseForm(
                    onSubmit: model.addCourse,
                  ),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
          body: model.isBusy
              ? const Center(child: CircularProgressIndicator())
              : model.courses.isEmpty
                  ? const Center(
                      child: Text('No courses added yet'),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 80),
                      itemCount: model.courses.length,
                      itemBuilder: (context, index) {
                        final course = model.courses[index];
                        return CourseCard(
                          course: course,
                          onDelete: () => model.removeCourse(course.id),
                        );
                      },
                    ),
        );
      },
    );
  }
}
