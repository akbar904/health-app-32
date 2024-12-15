import 'package:my_app/features/courses/course_repository.dart';
import 'package:my_app/models/course.dart';

class CourseService {
  final CourseRepository _repository;

  CourseService(this._repository);

  List<Course> get courses => _repository.getCourses();

  Future<void> addCourse(Course course) async {
    await _repository.addCourse(course);
  }

  Future<void> removeCourse(String courseId) async {
    await _repository.removeCourse(courseId);
  }

  Future<void> updateCourse(Course course) async {
    await _repository.updateCourse(course);
  }

  Course? getCourseById(String id) {
    return _repository.getCourseById(id);
  }
}
