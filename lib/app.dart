import 'package:flutter/material.dart';
import 'package:get_calley_app_armaan/view/language_selector_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_calley_app_armaan/view/login_screen.dart';
import 'package:get_calley_app_armaan/view/otp_screen.dart';
import 'package:get_calley_app_armaan/view/sign_up_screen.dart';
import 'package:get_calley_app_armaan/view_model/language_selector_view_model.dart';
import 'package:get_calley_app_armaan/view_model/login_view_model.dart';
import 'package:get_calley_app_armaan/view_model/otp_view_model.dart';
import 'package:get_calley_app_armaan/view_model/sign_up_view_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => SignUpViewModel()),
            ChangeNotifierProvider(create: (_) => LanguageSelectorViewModel()),
            ChangeNotifierProvider(create: (_) => OtpViewModel()),
            ChangeNotifierProvider(create: (_) => LoginViewModel()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(textTheme: GoogleFonts.interTextTheme(
          ThemeData.light().textTheme,
        ),),   
        home:   LoginScreen(), 
          //  home:   OtpScreen(), 
            // home:  SignUpScreen(), // 
            // home:  LanguageSelectorScreen(), // or LanguageSelectorScreen()
          ),
        );
      },
    );
  }
}
