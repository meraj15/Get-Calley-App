import 'package:flutter/material.dart';
import 'package:get_calley_app_armaan/services/auth_service.dart';

class OtpViewModel extends ChangeNotifier {
  final TextEditingController pinController = TextEditingController();

  bool _isOtpIncorrect = false;
  bool get isOtpIncorrect => _isOtpIncorrect;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final AuthService _authService = AuthService();

  Future<void> sendOtp(TextEditingController emailController) async {
    final email = emailController.text.trim();
    if (email.isEmpty) return;

    _isLoading = true;
    notifyListeners();

    try {
      final response = await _authService.sendOTP(email: email);
      debugPrint("Send OTP Response: ${response.statusCode} - ${response.body}");
    } catch (e) {
      debugPrint("Send OTP Error: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> verifyOtp(VoidCallback onSuccess, VoidCallback onFailure, TextEditingController emailController) async {
    final email = emailController.text.trim();
    final otp = pinController.text.trim();

    if (email.isEmpty || otp.length != 6) {
      _isOtpIncorrect = true;
      notifyListeners();
      onFailure();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final response = await _authService.verifyOtp(email: email, otp: otp);

      if (response.statusCode == 200) {
        _isOtpIncorrect = false;
        notifyListeners();
        onSuccess();
      } else {
        _isOtpIncorrect = true;
        notifyListeners();
        onFailure();
      }

      debugPrint("Verify OTP Response: ${response.statusCode} - ${response.body}");
    } catch (e) {
      debugPrint("Verify OTP Error: $e");
      _isOtpIncorrect = true;
      notifyListeners();
      onFailure();
    }

    _isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }
}
