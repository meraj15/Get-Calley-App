import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_calley_app_armaan/services/auth_service.dart';

class LoginViewModel extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _authService = AuthService();

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  Future<bool> login(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    try {
      final response = await _authService.login(email: email, password: password);
      _isLoading = false;

      if (response.statusCode == 200 || response.statusCode == 201) {
        _errorMessage = '';
        notifyListeners();
        Navigator.pushReplacementNamed(context, '/home');
        return true;
      } else {
        final Map<String, dynamic> data = jsonDecode(response.body);
        _errorMessage = data['message'] ?? 'Login failed';
        debugPrint("$data");
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Something went wrong';
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _errorMessage = '';
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
