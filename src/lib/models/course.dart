import 'package:equatable/equatable.dart';

class Course extends Equatable {
  final String id;
  final String name;
  final String professor;
  final String schedule;
  final int credits;
  final String description;

  const Course({
    required this.id,
    required this.name,
    required this.professor,
    required this.schedule,
    required this.credits,
    required this.description,
  });

  Course copyWith({
    String? id,
    String? name,
    String? professor,
    String? schedule,
    int? credits,
    String? description,
  }) {
    return Course(
      id: id ?? this.id,
      name: name ?? this.name,
      professor: professor ?? this.professor,
      schedule: schedule ?? this.schedule,
      credits: credits ?? this.credits,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'professor': professor,
      'schedule': schedule,
      'credits': credits,
      'description': description,
    };
  }

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as String,
      name: json['name'] as String,
      professor: json['professor'] as String,
      schedule: json['schedule'] as String,
      credits: json['credits'] as int,
      description: json['description'] as String,
    );
  }

  @override
  List<Object?> get props =>
      [id, name, professor, schedule, credits, description];
}
