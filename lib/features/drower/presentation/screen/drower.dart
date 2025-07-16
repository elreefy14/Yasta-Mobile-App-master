import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';

import '../../../../core/route/route_strings/route_strings.dart';
import '../../../../core/theme/text_styles.dart';

class AppDrawer extends StatefulWidget {



  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor:  Colors.white,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 30.0.w,vertical: 50.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getLang(context, "CAR SERVICES").toString() ,
              style: TextStyles.blackFS18FW700CandaraTextStyle,
             // textAlign: TextAlign.center,
            ),
            ListTile(
              title: Row(
                children: [
                  SvgPicture.asset("assets/icons/person.svg"),
                  horizontalSpace(8.w),
                  Text(
                    getLang(context, "About Us").toString(),
                    style: TextStyles.gray900FS16FW500CairoTextStyle,
                  ),
                ],
              ),
              onTap: () {
                Navigator.pushNamed(context, RouteStrings.aboutUsScreen);
              },
            ),
            Divider(thickness: 2, height: 0),
            ListTile(
              title: Row(
                children: [
                  SvgPicture.asset("assets/icons/languages.svg"),
                  horizontalSpace(8.w),
                  Text(
                    getLang(context, "languages").toString(),
                    style: TextStyles.gray900FS16FW500CairoTextStyle,
                  ),
                ],
              ),
              onTap: () {
                Navigator.pushNamed(context, RouteStrings.languageSelectionPage);
              },
            ),
            Divider(thickness: 2, height: 0),
          ],
        ),
      ),
    );
  }
}