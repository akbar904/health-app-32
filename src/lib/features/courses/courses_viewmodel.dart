import 'package:my_app/app/app.locator.dart';
import 'package:my_app/models/course.dart';
import 'package:my_app/services/course_service.dart';
import 'package:my_app/services/error_service.dart';
import 'package:my_app/utils/exceptions/error_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CoursesViewModel extends BaseViewModel {
  final _courseService = locator<CourseService>();
  final _dialogService = locator<DialogService>();
  final _errorService = locator<ErrorService>();

  List<Course> get courses => _courseService.courses;

  Future<void> addCourse(Course course) async {
    try {
      setBusy(true);
      await _courseService.addCourse(course);
      notifyListeners();
    } catch (e) {
      final errorMessage = ErrorHandler.handleCourseError(e);
      _errorService.logError(e, null);

      await _dialogService.showCustomDialog(
        variant: DialogType.error,
        title: 'Error Adding Course',
        description: errorMessage,
      );
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
      final errorMessage = ErrorHandler.handleCourseError(e);
      _errorService.logError(e, null);

      await _dialogService.showCustomDialog(
        variant: DialogType.error,
        title: 'Error Removing Course',
        description: errorMessage,
      );
    } finally {
      setBusy(false);
    }
  }
}
