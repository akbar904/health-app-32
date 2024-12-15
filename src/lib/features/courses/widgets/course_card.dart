import 'package:flutter/material.dart';
import 'package:my_app/models/course.dart';
import 'package:my_app/ui/common/app_colors.dart';
import 'package:my_app/ui/common/ui_helpers.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  final VoidCallback onDelete;

  const CourseCard({
    required this.course,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    course.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: kcPrimaryColor,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: onDelete,
                ),
              ],
            ),
            verticalSpaceSmall,
            Row(
              children: [
                const Icon(Icons.person, size: 16, color: kcMediumGrey),
                horizontalSpaceSmall,
                Text(
                  course.professor,
                  style: const TextStyle(color: kcMediumGrey),
                ),
              ],
            ),
            verticalSpaceTiny,
            Row(
              children: [
                const Icon(Icons.schedule, size: 16, color: kcMediumGrey),
                horizontalSpaceSmall,
                Text(
                  course.schedule,
                  style: const TextStyle(color: kcMediumGrey),
                ),
              ],
            ),
            verticalSpaceTiny,
            Row(
              children: [
                const Icon(Icons.school, size: 16, color: kcMediumGrey),
                horizontalSpaceSmall,
                Text(
                  '${course.credits} credits',
                  style: const TextStyle(color: kcMediumGrey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
