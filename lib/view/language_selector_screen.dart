import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../contants/app_color.dart';
import '../model/language_model.dart';
import '../view_model/language_selector_view_model.dart';
import '../widgets/custom_button.dart';
import '../widgets/language_tile.dart';

class LanguageSelectorScreen extends StatefulWidget {
  const LanguageSelectorScreen({super.key});

  @override
  State<LanguageSelectorScreen> createState() =>
      _LanguageSelectorScreenState();
}

class _LanguageSelectorScreenState extends State<LanguageSelectorScreen> {
  final LanguageSelectorViewModel viewModel = LanguageSelectorViewModel();
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(10.h),
            Padding(
              padding: EdgeInsets.only(left: 88.w),
              child: Text(
                'Choose Your Language',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ),
            ),
            Gap(13.h),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: AppColors.borderColor),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF0F172A).withOpacity(0.04),
                        offset: Offset(0, 1),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: viewModel.languages.length,
                    separatorBuilder: (context, index) => Gap(18),
                    itemBuilder: (context, index) {
                      LanguageModel lang = viewModel.languages[index];
                      return LanguageTile(
                        language: lang,
                        isSelected: selectedLanguage == lang.name,
                        onTap: () {
                          setState(() {
                            selectedLanguage = lang.name;
                          });
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            Gap(25.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CustomButton(
                title: "Select",
                onTap: () {
                  // Handle language select
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Selected: $selectedLanguage')),
                  );
                },
              ),
            ),
            Gap(30.h),
          ],
        ),
      ),
    );
  }
}
