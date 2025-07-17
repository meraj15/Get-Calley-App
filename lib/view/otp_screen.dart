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
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<OtpViewModel>(context);

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
                          AppString.whatsappOtpVerification,
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Gap(18),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Text(
                          AppString.emailValidationMessage,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.languageSelectorSubtile,
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                      Gap(33),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.w),
                        child: Pinput(
                          length: 6,
                          controller: viewModel.pinController,
                          onSubmitted: (_) => viewModel.validateOtp(() {
                            debugPrint("OTP verified");
                            // Navigator.push(...)
                          }),
                          defaultPinTheme: _pinTheme(context, viewModel),
                          focusedPinTheme: _pinTheme(context, viewModel, focused: true),
                          submittedPinTheme: _pinTheme(context, viewModel),
                        ),
                      ),
                      if (viewModel.isOtpIncorrect)
                        Padding(
                          padding: EdgeInsets.only(top: 10.h, left: 40.w, right: 40.w),
                          child: Text(
                            AppString.incorrectOtpMessage,
                            style: TextStyle(
                              color: AppColors.errorColor,
                              fontSize: 14.sp,
                            ),
                            textAlign: TextAlign.center,
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
                      Gap(143),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppString.didntReceiveOtp, style: TextStyle(color: AppColors.black)),
                          GestureDetector(
                            onTap: () => debugPrint("Resend OTP"),
                            child: Text(
                              AppString.resendOtp,
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
                          title: AppString.verifyButton,
                          onTap: () => viewModel.validateOtp(() {
                            debugPrint("OTP verified via button");
                          }),
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

  PinTheme _pinTheme(BuildContext context, OtpViewModel viewModel, {bool focused = false}) {
    return PinTheme(
      width: 50.w,
      height: 45.h,
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