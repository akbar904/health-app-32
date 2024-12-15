import 'package:my_app/app/app.locator.dart';
import 'package:my_app/models/course.dart';
import 'package:my_app/services/course_service.dart';
import 'package:stacked/stacked.dart';

class CoursesViewModel extends BaseViewModel {
  final _courseService = locator<CourseService>();

  List<Course> get courses => _courseService.courses;

  Future<void> addCourse(Course course) async {
    await _courseService.addCourse(course);
    notifyListeners();
  }

  Future<void> removeCourse(String courseId) async {
    await _courseService.removeCourse(courseId);
    notifyListeners();
  }
}
