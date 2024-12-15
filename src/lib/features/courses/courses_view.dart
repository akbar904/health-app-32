import 'package:flutter/material.dart';
import 'package:my_app/features/courses/courses_viewmodel.dart';
import 'package:my_app/features/courses/widgets/add_course_form.dart';
import 'package:my_app/features/courses/widgets/course_card.dart';
import 'package:my_app/ui/common/app_colors.dart';
import 'package:my_app/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class CoursesView extends StatelessWidget {
  const CoursesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CoursesViewModel>.reactive(
      viewModelBuilder: () => CoursesViewModel(),
      onModelReady: (model) => model.initialize(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: kcBackgroundColor,
          appBar: AppBar(
            title: const Text(
              'My Courses',
              style: TextStyle(
                color: kcTextPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
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
            backgroundColor: kcPrimaryColor,
            icon: const Icon(Icons.add_rounded),
            label: const Text('Add Course'),
          ),
          body: model.isBusy
              ? const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(kcPrimaryColor),
                  ),
                )
              : model.courses.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.school_outlined,
                            size: 64,
                            color: kcTextSecondary.withOpacity(0.5),
                          ),
                          verticalSpaceMedium,
                          Text(
                            'No courses added yet',
                            style: TextStyle(
                              fontSize: 18,
                              color: kcTextSecondary.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(
                          bottom: 80, left: 8, right: 8, top: 8),
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
