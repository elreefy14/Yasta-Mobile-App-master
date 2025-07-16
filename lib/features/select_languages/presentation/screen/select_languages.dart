import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/app_cubit/app_cubit.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/helper/cache_helper/cache_helper.dart';
import '../../../../core/componant/componant.dart';
import '../../../../core/helper/app_color/app_color.dart';
import '../../../../core/theme/text_styles.dart';

class LanguageSelectionPage extends StatefulWidget {
  const LanguageSelectionPage({super.key});

  @override
  State<LanguageSelectionPage> createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  String selectedLanguage = ''; // Default selection

  @override
  void initState() {
    // TODO: implement initState
    print(CacheHelper.getdata(key: "lang").toString());
    selectedLanguage = CacheHelper.getdata(key: "lang").toString() == "en" ? 'English' : 'Arabic';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          getLang(context, "languages").toString(),
          style: TextStyles.blackFS15FW500TextStyle,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30.h),
            Text(
              'Select your preferred language',
              style: TextStyle(fontSize: 16.sp, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              'حدد لغتك المفضلة',
              style: TextStyle(fontSize: 16.sp, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30.h),
            // English language option
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedLanguage = 'English';
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                decoration: BoxDecoration(
                  color: selectedLanguage == 'English'
                      ? Colors.green[100]
                      : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'English',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    Text(
                      'انجليزي',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Arabic language option
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedLanguage = 'Arabic';
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                decoration: BoxDecoration(
                  color: selectedLanguage == 'Arabic'
                      ? Colors.green[100]
                      : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Arabic',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    Text(
                      'عربي',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Confirm button
            DefaultButton(
              color: ColorsManager.blackColor,
              onPressed: () {
                final appCubit = AppCubit.get(context);
                if (selectedLanguage == 'English') {
                  appCubit.changeLanguage('en');
                } else {
                  appCubit.changeLanguage('ar');
                }
              },
              child: Text(
                getLang(context, "Change").toString(),
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
