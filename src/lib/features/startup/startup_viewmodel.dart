import 'package:my_app/app/app.locator.dart';
import 'package:my_app/app/app.router.dart';
import 'package:my_app/features/auth/auth_repository.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authRepository = locator<AuthRepository>();

  Future runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 1));

    if (_authRepository.isAuthenticated) {
      await _navigationService.replaceWithHomeView();
    } else {
      await _navigationService.replaceWithLoginView();
    }
  }
}
