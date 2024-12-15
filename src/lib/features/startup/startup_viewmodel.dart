import 'package:my_app/app/app.locator.dart';
import 'package:my_app/app/app.router.dart';
import 'package:my_app/features/auth/auth_repository.dart';
import 'package:my_app/services/error_service.dart';
import 'package:my_app/utils/exceptions/error_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authRepository = locator<AuthRepository>();
  final _dialogService = locator<DialogService>();
  final _errorService = locator<ErrorService>();

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
      final errorMessage = ErrorHandler.handleError(e);
      _errorService.logError(e, null);

      await _dialogService.showCustomDialog(
        variant: DialogType.error,
        title: 'Startup Error',
        description: errorMessage,
      );

      // Fall back to login view on error
      await _navigationService.replaceWithLoginView();
    } finally {
      setBusy(false);
    }
  }
}
