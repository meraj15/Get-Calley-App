// sign_up_view_model.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_calley_app_armaan/services/auth_service.dart';

class SignUpViewModel extends ChangeNotifier {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final mobileController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool agreed = false;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  final _authService = AuthService();

  void toggleAgreement(bool? value) {
    agreed = value ?? false;
    notifyListeners();
  }

  void setError(String msg) {
    _errorMessage = msg;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = '';
    notifyListeners();
  }

  // === Validators ===
  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter your name';
    if (value.trim().length < 3) return 'Name must be at least 3 characters';
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter your email';
    if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter your password';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter phone number';
    if (!RegExp(r'^\d{10}$').hasMatch(value)) return 'Phone must be exactly 10 digits';
    return null;
  }

  String? validateMobile(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter mobile number';
    if (!RegExp(r'^\d{10}$').hasMatch(value)) return 'Mobile must be exactly 10 digits';
    return null;
  }

  Future<String?> registerUser(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final name = nameController.text.trim();
    

    try {
      final response = await _authService.register(
        username: name,
        email: email,
        password: password,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return null;
      } else {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['message'] ?? 'Registration failed';
      }
    } catch (e) {
      return 'Something went wrong';
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    mobileController.dispose();
    super.dispose();
  }
}
