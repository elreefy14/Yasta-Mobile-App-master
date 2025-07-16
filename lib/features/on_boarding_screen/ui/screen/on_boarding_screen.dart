import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:yasta/core/componant/componant.dart';
import 'package:yasta/core/helper/app_color/app_color.dart';
import 'package:yasta/core/helper/cache_helper/cache_helper.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';

import '../../../../core/app_cubit/app_cubit.dart';
import '../../../../core/app_local/app_local.dart';
import '../../../../core/componant/select_lang_widget.dart';
import '../../../../core/route/route_strings/route_strings.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  List<String> langList = ["العربيه", "English"];
  String selectedValue = "العربيه";

  List<Widget> _buildPages() {
    return [
      _buildPage(
        gifImage: 'assets/lottie/3 screen.json',
        title: getLang(context, "Fast and reliable solutions for your car").toString(),
        description:
        getLang(context, "The perfect platform that brings together car owners and service providers in one place.").toString(),
      ),



      _buildPage(
        gifImage: 'assets/lottie/2 screen.json',
        title: getLang(context, "Your car solutions at your fingertips").toString(),
        description:
        getLang(context, "Just select your location and the type of service you need, and we'll give you the best workshops for you.'").toString(),
      ),
      _buildPage(
        gifImage: 'assets/lottie/1 screen.json',
        title: getLang(context, "Your smart assistant around the clock").toString(),
        description:
        getLang(context, "He is ready to help you at any time, talk to him and explain your problem and he will provide you with the best solutions suggested.").toString(),
      ),
    ];
  }

  Widget _buildPage({
    required String gifImage,
    required String title,
    required String description,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              SelectLangWidget(color: Colors.black,),
              const Spacer(),
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {
                    // Handle skip action
                    CacheHelper.saveData(key: "onBoarding", value: true).then(
                      (value) {
                        Navigator.pushReplacementNamed(
                          context,
                          RouteStrings.serviceType,
                        );
                      },
                    );
                  },
                  child: const Text(
                    'تخطي',
                    style: TextStyle(color: Color(0xFF4B5563)),
                  ),
                ),
              ),
            ],
          ),
        ),
        verticalSpace(30.h),
        Container(
          height: 320.h,
          width: 300.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[100],
          ),
          child: Lottie.asset(gifImage),
        ),
        verticalSpace(30.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              height: 10,
              width: _currentPage == index ? 20 : 10,
              decoration: BoxDecoration(
                color: _currentPage == index ? Colors.blue : Colors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
        verticalSpace(30.h),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
            ),
            padding: EdgeInsets.all(20.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500),
                ),
                verticalSpace(20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    _currentPage == 0
                        ? const SizedBox.shrink()
                        : InkWell(
                      onTap: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: SvgPicture.asset(
                        "assets/icons/Frame.svg",
                      ),
                    ),
                    _currentPage == 0
                        ? const SizedBox.shrink()
                        : horizontalSpace(10.h),
                    SizedBox(
                      width: _currentPage == 0 ? 287.w : 220.w,
                      child: DefaultButton(
                          color: ColorsManager.blackColor,
                          onPressed: () {
                            if (_currentPage == 2 ) {
                              CacheHelper.saveData(
                                      key: "onBoarding", value: true)
                                  .then(
                                (value) {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    RouteStrings.serviceType,
                                  );
                                },
                              );
                            } else {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          child: Text(
                            _currentPage == 2 ?getLang(context, "start now").toString(): getLang(context, "next").toString(),
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                    ),

                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: _buildPages(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
