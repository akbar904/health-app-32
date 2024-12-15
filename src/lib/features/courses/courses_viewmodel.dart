import 'package:my_app/app/app.locator.dart';
import 'package:my_app/models/course.dart';
import 'package:my_app/services/course_service.dart';
import 'package:stacked/stacked.dart';

class CoursesViewModel extends BaseViewModel {
  final _courseService = locator<CourseService>();

  List<Course> get courses => _courseService.courses;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool get hasModelError => _errorMessage != null;

  void setModelError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  Future<void> addCourse(Course course) async {
    try {
      setBusy(true);
      await _courseService.addCourse(course);
      notifyListeners();
    } catch (e) {
      setModelError('Failed to add course. Please try again.');
    } finally {
      setBusy(false);
    }
  }

  Future<void> removeCourse(String courseId) async {
    try {
      setBusy(true);
      await _courseService.removeCourse(courseId);
      notifyListeners();
    } catch (e) {
      setModelError('Failed to remove course. Please try again.');
    } finally {
      setBusy(false);
    }
  }

  void initialize() {
    setBusy(true);
    try {
      notifyListeners();
    } catch (e) {
      setModelError('Failed to load courses. Please try again.');
    } finally {
      setBusy(false);
    }
  }
}