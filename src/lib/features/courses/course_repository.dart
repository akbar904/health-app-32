import 'package:my_app/models/course.dart';

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
    return List.unmodifiable(_courses);
  }

  Future<void> addCourse(Course course) async {
    _courses.add(course);
  }

  Future<void> removeCourse(String courseId) async {
    _courses.removeWhere((course) => course.id == courseId);
  }

  Future<void> updateCourse(Course updatedCourse) async {
    final index =
        _courses.indexWhere((course) => course.id == updatedCourse.id);
    if (index != -1) {
      _courses[index] = updatedCourse;
    }
  }

  Course? getCourseById(String id) {
    try {
      return _courses.firstWhere((course) => course.id == id);
    } catch (_) {
      return null;
    }
  }
}
