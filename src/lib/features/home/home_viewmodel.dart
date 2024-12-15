import 'package:my_app/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/app/app.locator.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  Future<void> navigateToCourses() async {
    await _navigationService.navigateToCoursesView();
  }
}
