import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/componant/componant.dart';
import 'package:yasta/core/componant/select_lang_widget.dart';
import 'package:yasta/core/helper/app_color/app_color.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';
import 'package:yasta/features/auth/ui/screen/login_screen.dart';
import 'package:yasta/features/service_provider/ui/widget/or_widget.dart';
import 'package:yasta/features/service_provider/ui/widget/who_iam_widget.dart';

import '../../../../core/route/route_strings/route_strings.dart';

class ServiceType extends StatefulWidget {
  const ServiceType({super.key});

  @override
  State<ServiceType> createState() => _ServiceTypeState();
}

class _ServiceTypeState extends State<ServiceType> {
  int _selectedIndex = -1; // -1 means no selection initially

  Widget _buildSelectableContainer(
      {required int index, required String imagePath, required String title}) {
    bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        width: 150.w, // Adjust the size as needed
        height: 170.h, // Adjust the size as needed
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? Colors.black
                : ColorsManager.gray200, // Black border if selected
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: SvgPicture.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
            Text(title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorsManager.blackColor,
        body: Column(
          children: [
            verticalSpace(20.h),
            Align(
              alignment: Alignment.topLeft,
              child: SelectLangWidget(
                color: Colors.white,
              ),
            ),
            verticalSpace(40.h),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                ),
                padding:
                    EdgeInsets.symmetric(horizontal: 24.sp, vertical: 44.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const WhoIamWidget(),
                    verticalSpace(44.h),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSelectableContainer(
                            index: 0,
                            imagePath: 'assets/image/service.svg',
                            title: getLang(context, "Service Provider").toString()),
                        const SizedBox(width: 20),
                        _buildSelectableContainer(
                            index: 1,
                            imagePath: 'assets/image/user.svg',
                            title: getLang(context, "User").toString()),
                      ],
                    ),
                    verticalSpace(20.h),
                    DefaultButton(
                      color: ColorsManager.blackColor,
                      onPressed: _selectedIndex == -1
                          ? null
                          : () {
                              if (_selectedIndex == 0) {
                                Navigator.pushNamed(
                                    context, RouteStrings.signUpPersonalData,
                                    arguments: "provider");
                              } else {
                                Navigator.pushNamed(
                                    context, RouteStrings.signUpPersonalData,
                                    arguments: "user");
                              }
                            },
                      child: Text(
                        getLang(context, "next").toString(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    verticalSpace(44.h),
                    OrWidget(),
                    verticalSpace(24.h),
                    DefaultButton(
                      color: ColorsManager.whiteColor,
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, RouteStrings.loginScreen);
                        // Navigator.pushAndRemoveUntil(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => LoginScreen()),
                        //       (route) => false, // Remove all previous routes
                        // );
                      },
                      child: Text(
                        getLang(context, "login").toString(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: ColorsManager.gray950,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    verticalSpace(24.h),
                    DefaultButton(
                      color: ColorsManager.whiteColor,
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          RouteStrings.homeLayoutScreen,
                          arguments: {
                            "isGuest": true,
                            "isUser" : true,
                          },
                        );
                      },
                      child: Text(
                        getLang(context, "As Guest").toString(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: ColorsManager.gray950,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
