import 'package:my_app/app/app.locator.dart';
import 'package:my_app/app/app.router.dart';
import 'package:my_app/core/base_viewmodel.dart';
import 'package:my_app/features/auth/auth_repository.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authRepository = locator<AuthRepository>();

  Future<void> runStartupLogic() async {
    try {
      setBusy(true);
      await Future.delayed(const Duration(seconds: 1));

      if (_authRepository.isAuthenticated()) {
        await _navigationService.replaceWithHomeView();
      } else {
        await _navigationService.replaceWithLoginView();
      }
    } catch (e) {
      setErrorMessage('Failed to initialize the application. Please try again.');
    } finally {
      setBusy(false);
    }
  }
}