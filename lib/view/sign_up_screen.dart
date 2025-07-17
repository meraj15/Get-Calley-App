// sign_up_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_calley_app_armaan/contants/app_color.dart';
import 'package:get_calley_app_armaan/contants/app_string.dart';
import 'package:get_calley_app_armaan/view/otp_screen.dart';
import 'package:get_calley_app_armaan/view_model/otp_view_model.dart';
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
            Expanded(child: _buildFormContainer(viewModel, context)),
          ],
        ),
      ),
    );
  }

  Widget _buildFormContainer(SignUpViewModel viewModel, BuildContext context) {
    return Container(
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
      child: SingleChildScrollView(
        child: Form(
          key: viewModel.formKey,
          child: Column(
            children: [
              Text(
                AppString.welcomeTextSignUp,
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 32.sp,
                ),
              ),
              Gap(6),
              Text(
                AppString.subText,
                style: TextStyle(
                  color: AppColors.languageSelectorSubtile,
                  fontWeight: FontWeight.w400,
                  fontSize: 15.sp,
                ),
              ),
              Gap(24),
              _buildTextField("Name", viewModel.nameController, "assets/png/name.png", validator: viewModel.validateName),
              Gap(20),
              _buildTextField(
                "Email address",
                viewModel.emailController,
                "assets/png/email.png",
                keyboardType: TextInputType.emailAddress,
                validator: viewModel.validateEmail,
              ),
              if (viewModel.errorMessage.isNotEmpty)
                Text(
                  viewModel.errorMessage,
                  style: TextStyle(color: AppColors.errorColor, fontSize: 14.sp),
                ),
              Gap(20),
              _buildTextField(
                "Password",
                viewModel.passwordController,
                "assets/png/password.png",
                obscure: true,
                validator: viewModel.validatePassword,
              ),
              Gap(20),
              _buildTextField(
                "+91",
                viewModel.phoneController,
                "assets/png/whatsapp.png",
                assetPrefixImagePath: "assets/png/india_flag.png",
                keyboardType: TextInputType.phone,
                validator: viewModel.validatePhone,
              ),
              Gap(20),
              _buildTextField(
                "Mobile Number",
                viewModel.mobileController,
                "assets/png/mobile.png",
                keyboardType: TextInputType.phone,
                validator: viewModel.validateMobile,
              ),
              Gap(7),
              _buildTermsCheckbox(viewModel),
              Gap(14),
              _buildSignInLink(context),
              Gap(11),
              
              CustomButton(
                title: "Sign Up",
                onTap: () async {
                  viewModel.clearError(); // clear previous backend error
                  if (viewModel.formKey.currentState!.validate()) {
                    final error = await viewModel.registerUser(context);
                    if (error != null) {
                      viewModel.setError(error);
                    } else {
                      await context.read<OtpViewModel>().sendOtp(viewModel.emailController);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => OtpScreen(emailController: viewModel.emailController),
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    String assetSuffixImagePath, {
    String? assetPrefixImagePath,
    TextInputType keyboardType = TextInputType.text,
    bool obscure = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
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
            prefixIcon: assetPrefixImagePath != null
                ? Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(
                      width: 10,
                      height: 10,
                      child: Image.asset(
                        assetPrefixImagePath,
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
                : null,
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

  Widget _buildTermsCheckbox(SignUpViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Checkbox(
            activeColor: AppColors.appButtonColor,
            value: viewModel.agreed,
            onChanged: viewModel.toggleAgreement,
            side: BorderSide(width: 1),
          ),
          Flexible(
            child: Row(
              children: [
                Text(AppString.termsPrefix, style: TextStyle(color: AppColors.black)),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    AppString.termsLink,
                    style: TextStyle(color: AppColors.appButtonColor, fontSize: 15.sp),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignInLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(AppString.signInPrefix),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/login'),
          child: Text(
            AppString.signInLink,
            style: TextStyle(
              color: AppColors.appButtonColor,
              fontWeight: FontWeight.w600,
              fontSize: 15.sp,
            ),
          ),
        ),
      ],
    );
  }

  String? _defaultValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppString.requiredFieldMsg;
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

  String? _nameValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter your name';
    if (value.trim().length < 3) return 'Name must be at least 3 characters';
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter your password';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  String? _phoneValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter your phone number';
    if (!RegExp(r'^\d{10}$').hasMatch(value)) return 'Phone number must be 10 digits';
    return null;
  }

  String? _mobileValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter your mobile number';
    if (!RegExp(r'^\d{10}$').hasMatch(value)) return 'Mobile number must be 10 digits';
    return null;
  }
}
