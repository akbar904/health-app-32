import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';

class BaseViewModel extends ChangeNotifier {
  bool _isBusy = false;
  String? _errorMessage;
  
  bool get isBusy => _isBusy;
  String? get modelError => _errorMessage;
  bool get hasModelError => _errorMessage != null;

  void setBusy(bool value) {
    _isBusy = value;
    notifyListeners();
  }

  void setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}