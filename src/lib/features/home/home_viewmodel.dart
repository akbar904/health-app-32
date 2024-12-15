import 'package:my_app/app/app.locator.dart';
import 'package:my_app/app/app.router.dart';
import 'package:my_app/features/auth/auth_repository.dart';
import 'package:my_app/services/error_service.dart';
import 'package:my_app/utils/exceptions/error_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authRepository = locator<AuthRepository>();
  final _dialogService = locator<DialogService>();
  final _errorService = locator<ErrorService>();

  String get userName => _authRepository.currentUser?.name ?? 'User';

  Future<void> navigateToCourses() async {
    try {
      await _navigationService.navigateToCoursesView();
    } catch (e) {
      _errorService.logError(e, null);
      await _dialogService.showCustomDialog(
        variant: DialogType.error,
        title: 'Navigation Error',
        description: 'Unable to access courses. Please try again.',
      );
    }
  }

  Future<void> logout() async {
    try {
      setBusy(true);
      await _authRepository.logout();
      await _navigationService.replaceWithLoginView();
    } catch (e) {
      final errorMessage = ErrorHandler.handleError(e);
      _errorService.logError(e, null);

      await _dialogService.showCustomDialog(
        variant: DialogType.error,
        title: 'Logout Error',
        description: errorMessage,
      );
    } finally {
      setBusy(false);
    }
  }
}
