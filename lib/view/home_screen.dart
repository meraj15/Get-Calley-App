import 'package:flutter/material.dart';
import 'package:get_calley_app_armaan/contants/app_color.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Login Successful",style: TextStyle(fontSize: 25,color: AppColors.appButtonColor),),),
    );
  }
}