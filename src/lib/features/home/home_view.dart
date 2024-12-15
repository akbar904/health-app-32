import 'package:flutter/material.dart';
import 'package:my_app/features/home/home_viewmodel.dart';
import 'package:my_app/ui/common/app_colors.dart';
import 'package:my_app/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: kcBackgroundColor,
        appBar: AppBar(
          title: const Text(
            'Course Management',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: kcTextPrimary,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout_rounded, color: kcPrimaryColor),
              onPressed: model.logout,
            ),
          ],
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpaceLarge,
                Text(
                  'Welcome back,\n${model.userName}!',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: kcTextPrimary,
                    height: 1.2,
                  ),
                ),
                verticalSpaceMedium,
                const Text(
                  'Manage your courses and track your academic progress',
                  style: TextStyle(
                    fontSize: 16,
                    color: kcTextSecondary,
                  ),
                ),
                verticalSpaceLarge,
                InkWell(
                  onTap: model.navigateToCourses,
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [kcPrimaryColor, kcSecondaryColor],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: kcPrimaryColor.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.book_rounded,
                          color: Colors.white,
                          size: 32,
                        ),
                        horizontalSpaceMedium,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'My Courses',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              verticalSpaceSmall,
                              Text(
                                'View and manage your enrolled courses',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                if (model.hasModelError)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: errorMessageWidget(model.modelError.toString()),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
