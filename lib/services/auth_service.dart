import 'dart:convert';
import 'package:get_calley_app_armaan/contants/app_endpoint.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<http.Response> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse(AppEndpoint.login);

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"email": email, "password": password}),
    );
    return response;
  }

  Future<http.Response> register({
    required String username,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse(AppEndpoint.register);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );
    return response;
  }

  Future<http.Response> sendOTP ({required String email})async {
    final url = Uri.parse(AppEndpoint.sendOTP);
    final response = await http.post(url,
    headers: {'Content-Type' : 'application/json'},
     body: jsonEncode({'email': email}),
    );
    return response;
  }

  Future<http.Response> verifyOtp({required String email, required String otp}) async {
    final url = Uri.parse(AppEndpoint.verifyOTP);
    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'otp': otp}),
    );
  }
}
