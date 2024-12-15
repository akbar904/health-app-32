import 'package:my_app/features/auth/auth_repository.dart';
import 'package:my_app/features/auth/login_view.dart';
import 'package:my_app/features/auth/register_view.dart';
import 'package:my_app/features/courses/courses_view.dart';
import 'package:my_app/services/auth_service.dart';
import 'package:my_app/services/course_service.dart';
import 'package:my_app/features/courses/course_repository.dart';
import 'package:my_app/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:my_app/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:my_app/features/home/home_view.dart';
import 'package:my_app/features/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView, initial: true),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: RegisterView),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: CoursesView),
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: AuthRepository),
    LazySingleton(classType: CourseRepository),
    LazySingleton(classType: CourseService),
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
  ],
)
class App {}
