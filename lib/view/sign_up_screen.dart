import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_calley_app_armaan/contants/app_color.dart';
import 'package:get_calley_app_armaan/view_model/sign_up_view_model.dart';
import 'package:get_calley_app_armaan/widgets/custom_button.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';


class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
final viewModel = context.watch<SignUpViewModel>();

    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 33.h),
                      child: Image.asset(
                        "assets/png/get_calley_image.png",
                        width: 228.w,
                        height: 60.h,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: AppColors.borderColor),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x0A0F172A),
                            offset: const Offset(0, 1),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                      child: Form(
                        key: viewModel.formKey,
                        child: Column(
                          children: [
                            Text(
                              "Welcome!",
                              style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 32.sp,
                              ),
                            ),
                            Gap(6),
                            Text(
                              "Please register to continue",
                              style: TextStyle(
                                color: AppColors.languageSelectorSubtile,
                                fontWeight: FontWeight.w400,
                                fontSize: 15.sp,
                              ),
                            ),
                            Gap(24),

                            _buildTextField("Name", viewModel.nameController, Icons.person_outline),
                            Gap(20),
                            _buildTextField("Email address", viewModel.emailController, Icons.email_outlined,
                                keyboardType: TextInputType.emailAddress, validator: _emailValidator),
                            Gap(20),
                            _buildTextField("Password", viewModel.passwordController, Icons.lock_outline,
                                obscure: true),
                            Gap(20),
                            _buildTextField("+91", viewModel.phoneController, Icons.whatshot_sharp,
                                keyboardType: TextInputType.phone),
                            Gap(20),
                            _buildTextField("Mobile Number", viewModel.phoneController, Icons.phone_outlined,
                                keyboardType: TextInputType.phone),
                            Gap(7),

                            // Terms
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                children: [
                                  Checkbox(
                                    activeColor: AppColors.appButtonColor,
                                    value: viewModel.agreed,
                                    onChanged: viewModel.toggleAgreement,
                                  ),
                                  Flexible(
                                    child: Row(
                                      children: [
                                        Text("I agree to the ", style: TextStyle(color: AppColors.black)),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Text(
                                            "Terms and Conditions",
                                            style: TextStyle(
                                              color: AppColors.appButtonColor,
                                              fontSize: 15.sp,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Gap(14),

                            // Sign In Text
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Already have an account? "),
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    "Sign In",
                                    style: TextStyle(
                                      color: AppColors.appButtonColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Gap(13),
                            CustomButton(
                              title: "Sign Up",
                              onTap: () => viewModel.validateForm(context),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    IconData icon, {
    TextInputType keyboardType = TextInputType.text,
    bool obscure = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color:  AppColors.borderColor, width: 1),
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
          validator: validator ?? _defaultValidator,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            hintText: label,
            hintStyle: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.w400,
              fontSize: 15.sp,
            ),
            border: InputBorder.none,
            suffixIcon: Icon(icon, color: AppColors.languageSelectorSubtile),
          ),
        ),
      ),
    );
  }

  String? _defaultValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  String? _emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }
}
