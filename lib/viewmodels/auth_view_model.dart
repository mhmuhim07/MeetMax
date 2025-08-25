import 'package:flutter/material.dart';
import 'package:meetmax/api/mock_api.dart';
import 'package:meetmax/models/user_model.dart';

class AuthViewModel extends ChangeNotifier {
  final MockApi _api = MockApi();
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    final response = await _api.loginUser(email, password);
    if (response == 'Success') {
      _isLoggedIn = true;
    } else {
      _errorMessage = response;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> register(User user) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    final response = await _api.registerUser(user);
    _isLoading = false;
    notifyListeners();
    if (response == 'Success') {
      return true;
    } else {
      _errorMessage = response;
      return false;
    }
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}
