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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: kcSurfaceWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: kcShadowColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
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
                        color: kcTextPrimary,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline_rounded,
                        color: kcErrorRed),
                    onPressed: onDelete,
                  ),
                ],
              ),
              verticalSpaceSmall,
              Row(
                children: [
                  const Icon(Icons.person_outline_rounded,
                      size: 20, color: kcPrimaryColor),
                  horizontalSpaceSmall,
                  Text(
                    course.professor,
                    style: const TextStyle(
                      color: kcTextSecondary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              verticalSpaceTiny,
              Row(
                children: [
                  const Icon(Icons.schedule_rounded,
                      size: 20, color: kcPrimaryColor),
                  horizontalSpaceSmall,
                  Text(
                    course.schedule,
                    style: const TextStyle(
                      color: kcTextSecondary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              verticalSpaceTiny,
              Row(
                children: [
                  const Icon(Icons.school_rounded,
                      size: 20, color: kcPrimaryColor),
                  horizontalSpaceSmall,
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: kcPrimaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${course.credits} credits',
                      style: const TextStyle(
                        color: kcPrimaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              if (course.description.isNotEmpty) ...[
                verticalSpaceSmall,
                Text(
                  course.description,
                  style: const TextStyle(
                    color: kcTextSecondary,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
