import 'package:flutter/material.dart';

class OtpViewModel extends ChangeNotifier {
  final TextEditingController pinController = TextEditingController();
  final String _correctOtp = "123456";
  bool _isOtpIncorrect = false;

  bool get isOtpIncorrect => _isOtpIncorrect;

  void validateOtp(VoidCallback onSuccess) {
    if (pinController.text == _correctOtp) {
      _isOtpIncorrect = false;
      notifyListeners();
      onSuccess();
    } else {
      _isOtpIncorrect = true;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }
}
