import 'package:my_app/app/app.locator.dart';
import 'package:my_app/app/app.router.dart';
import 'package:my_app/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();
  final _dialogService = locator<DialogService>();

  Future<void> navigateToCourses() async {
    await _navigationService.navigateToCoursesView();
  }

  Future<void> logout() async {
    try {
      await _authService.logout();
      await _navigationService.replaceWithLoginView();
    } catch (e) {
      await _dialogService.showDialog(
        title: 'Error',
        description: 'Failed to logout: ${e.toString()}',
      );
    }
  }
}
