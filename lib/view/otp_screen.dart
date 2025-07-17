import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_calley_app_armaan/contants/app_color.dart';
import 'package:get_calley_app_armaan/contants/app_string.dart';
import 'package:get_calley_app_armaan/view_model/otp_view_model.dart';
import 'package:get_calley_app_armaan/widgets/custom_button.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatelessWidget {
  final TextEditingController emailController;
  const OtpScreen({super.key, required this.emailController});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<OtpViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SafeArea(
        child: Column(
          children: [
            Gap(33.h),
            Image.asset(
              "assets/png/get_calley_image.png",
              width: 228.w,
              height: 60.h,
            ),
            Gap(33.h),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.r),
                  ),
                  border: Border.all(color: AppColors.borderColor),
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      Gap(108.h),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          "Whatsapp OTP Verification",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Gap(18),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          "Please ensure your email is valid. We have sent an OTP.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: AppColors.languageSelectorSubtile,
                          ),
                        ),
                      ),
                      Gap(33),
                      Pinput(
                        length: 6,
                        controller: viewModel.pinController,
                        onSubmitted: (_) {
                          viewModel.verifyOtp(
                            () => debugPrint("OTP Verified Successfully!"),
                            () => debugPrint("Invalid OTP!"),
                            emailController,
                          );
                        },
                        defaultPinTheme: _pinTheme(context, viewModel),
                        focusedPinTheme: _pinTheme(
                          context,
                          viewModel,
                          focused: true,
                        ),
                        submittedPinTheme: _pinTheme(context, viewModel),
                      ),
                      if (viewModel.isOtpIncorrect)
                        Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: Text(
                            "Incorrect OTP. Please try again.",
                            style: TextStyle(color: AppColors.errorColor),
                          ),
                        ),
                      Gap(17),
                      Text(
                        AppString.phoneNumber,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                      ),
                      Gap(163),

                      GestureDetector(
                        onTap: () async {
                          await viewModel.sendOtp(emailController);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("OTP Resent to your email")),
                          );
                        },
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Didn’t receive the OTP? ",
                                style: TextStyle(color: AppColors.black),
                              ),
                              TextSpan(
                                text: "Resend",
                                style: TextStyle(
                                  color: AppColors.appButtonColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Gap(11),
                      CustomButton(
                        title: "Verify",
                        onTap: () {
                          viewModel.verifyOtp(
                            () => Navigator.pushNamed(context, '/home'),
                            () => ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Invalid OTP. Please try again"),
                              ),
                            ),
                            emailController
                          );
                        },
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

  PinTheme _pinTheme(
    BuildContext context,
    OtpViewModel viewModel, {
    bool focused = false,
  }) {
    return PinTheme(
      width: 50.w,
      height: 50.h,
      textStyle: TextStyle(fontSize: 20.sp, color: AppColors.black),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(
          color: viewModel.isOtpIncorrect
              ? AppColors.errorColor
              : (focused ? AppColors.appButtonColor : AppColors.borderColor),
          width: focused ? 2.0 : 1.0,
        ),
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A0F172A),
            offset: Offset(0, 1),
            blurRadius: 4,
          ),
        ],
      ),
    );
  }
}
