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
            onPressed: model.isBusy
                ? null
                : () {
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
            child: model.isBusy
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Icon(Icons.add),
          ),
          body: model.isBusy
              ? const Center(child: CircularProgressIndicator())
              : model.courses.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.school_outlined,
                            size: 64,
                            color: Colors.grey,
                          ),
                          verticalSpaceMedium,
                          const Text(
                            'No courses added yet',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                          verticalSpaceSmall,
                          const Text(
                            'Tap the + button to add your first course',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: model.refreshCourses,
                      child: ListView.builder(
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
                    ),
        );
      },
    );
  }
}
