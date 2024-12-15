import 'package:my_app/models/course.dart';
import 'package:my_app/utils/exceptions/api_exception.dart';

class CourseRepository {
  final List<Course> _courses = [
    Course(
      id: '1',
      name: 'Introduction to Computer Science',
      professor: 'Dr. Smith',
      schedule: 'Mon/Wed 10:00 AM',
      credits: 3,
      description: 'Fundamental concepts of programming and computer systems.',
    ),
    Course(
      id: '2',
      name: 'Data Structures',
      professor: 'Dr. Johnson',
      schedule: 'Tue/Thu 2:00 PM',
      credits: 4,
      description: 'Advanced data structures and algorithms.',
    ),
  ];

  List<Course> getCourses() {
    try {
      return List.unmodifiable(_courses);
    } catch (e) {
      throw APIException(
        userMessage: 'Unable to retrieve courses. Please try again.',
        technicalDetails: e.toString(),
        errorCode: 'FETCH_ERROR',
      );
    }
  }

  Future<void> addCourse(Course course) async {
    try {
      if (_courses.any((c) => c.name == course.name)) {
        throw ValidationException('A course with this name already exists.');
      }
      _courses.add(course);
    } catch (e) {
      if (e is ValidationException) rethrow;
      throw APIException(
        userMessage: 'Unable to add course. Please try again.',
        technicalDetails: e.toString(),
        errorCode: 'ADD_ERROR',
      );
    }
  }

  Future<void> removeCourse(String courseId) async {
    try {
      final index = _courses.indexWhere((course) => course.id == courseId);
      if (index == -1) {
        throw ValidationException('Course not found.');
      }
      _courses.removeAt(index);
    } catch (e) {
      if (e is ValidationException) rethrow;
      throw APIException(
        userMessage: 'Unable to remove course. Please try again.',
        technicalDetails: e.toString(),
        errorCode: 'DELETE_ERROR',
      );
    }
  }

  Future<void> updateCourse(Course updatedCourse) async {
    try {
      final index =
          _courses.indexWhere((course) => course.id == updatedCourse.id);
      if (index == -1) {
        throw ValidationException('Course not found.');
      }
      _courses[index] = updatedCourse;
    } catch (e) {
      if (e is ValidationException) rethrow;
      throw APIException(
        userMessage: 'Unable to update course. Please try again.',
        technicalDetails: e.toString(),
        errorCode: 'UPDATE_ERROR',
      );
    }
  }

  Course? getCourseById(String id) {
    try {
      return _courses.firstWhere((course) => course.id == id);
    } catch (e) {
      return null;
    }
  }
}
