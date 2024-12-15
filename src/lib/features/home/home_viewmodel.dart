import 'package:my_app/app/app.locator.dart';
import 'package:my_app/app/app.router.dart';
import 'package:my_app/core/base_viewmodel.dart';
import 'package:my_app/features/auth/auth_repository.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authRepository = locator<AuthRepository>();

  String get userName => _authRepository.currentUser?.name ?? 'User';

  Future<void> navigateToCourses() async {
    try {
      await _navigationService.navigateToCoursesView();
    } catch (e) {
      setErrorMessage('Unable to access courses at this time. Please try again.');
    }
  }

  Future<void> logout() async {
    try {
      setBusy(true);
      await _authRepository.logout();
      await _navigationService.replaceWithLoginView();
    } catch (e) {
      setErrorMessage('Failed to log out. Please try again.');
    } finally {
      setBusy(false);
    }
  }
}