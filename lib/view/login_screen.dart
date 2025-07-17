import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get_calley_app_armaan/contants/app_color.dart';
import 'package:get_calley_app_armaan/contants/app_string.dart';
import 'package:get_calley_app_armaan/view_model/login_view_model.dart';
import 'package:get_calley_app_armaan/widgets/custom_button.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LoginViewModel>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 33.h),
              child: Image.asset(
                "assets/png/get_calley_image.png",
                width: 228.w,
                height: 60.h,
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(color: AppColors.borderColor),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 5, top: 108.h),
                        child: Text(
                          AppString.welcomeTextLogin,
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Text(
                          AppString.signInSubText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.languageSelectorSubtile,
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                      Gap(22),
                      _buildTextField(
                        context,
                        "Email address",
                        vm.emailController,
                        "assets/png/email.png",
                        keyboardType: TextInputType.emailAddress,
                        validator: vm.validateEmail,
                      ),
                      Gap(20),
                      _buildTextField(
                        context,
                        "Password",
                        vm.passwordController,
                        "assets/png/password.png",
                        obscure: true,
                        validator: vm.validatePassword,
                      ),
                      Gap(6),
                      Padding(
                        padding: EdgeInsets.only(right: 30.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                debugPrint("Forgot Password tapped");
                              },
                              child: Text(
                                AppString.forgotPassword,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(167),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppString.dontHaveAccount,
                            style: TextStyle(color: AppColors.black),
                          ),
                          GestureDetector(
                            onTap: () => debugPrint("Sign Up"),
                            child: Text(
                              AppString.signUp,
                              style: TextStyle(
                                color: AppColors.appButtonColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gap(11),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: CustomButton(
                          title: AppString.signInButton,
                          onTap: () {
                            vm.signIn();
                          },
                        ),
                      ),
                      Gap(30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context,
    String label,
    TextEditingController controller,
    String assetSuffixImagePath, {
    TextInputType keyboardType = TextInputType.text,
    bool obscure = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.borderColor, width: 1),
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0x1A0F172A),
              offset: const Offset(0, 1),
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ],
        ),
        child: TextFormField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
            hintText: label,
            hintStyle: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.w400,
              fontSize: 15.sp,
            ),
            border: InputBorder.none,
            suffixIcon: Padding(
              padding: const EdgeInsets.all(13.0),
              child: SizedBox(
                width: 20,
                height: 20,
                child: Image.asset(assetSuffixImagePath, fit: BoxFit.contain),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
