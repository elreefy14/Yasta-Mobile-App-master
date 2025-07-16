import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/helper/app_color/app_color.dart';
import 'package:yasta/core/helper/cache_helper/cache_helper.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';
import 'package:yasta/features/notification/presentation/widget/notification_item.dart';

import '../../../../../core/theme/text_styles.dart';
import '../widget/copy_text_widget.dart';

class EWalletScreen extends StatelessWidget {
  const EWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: CacheHelper.getdata(key: "lang") == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              getLang(context, "E-wallet").toString(),
              style: TextStyles.blackFS15FW500TextStyle,
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 44.h),
            child: ListView(
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Image.asset("assets/image/voda.png"),
                        verticalSpace(10.h),
                        Text(
                          getLang(context, "Vodafone")
                              .toString(),
                          style: TextStyles.gray800FS16FW500CairoTextStyle,
                        ),
                      ],
                    ),
                    horizontalSpace(10.w),
                    Column(
                      children: [
                        Image.asset("assets/image/orange.png"),
                        verticalSpace(10.h),
                        Text(
                          getLang(context, "Orange")
                              .toString(),
                          style: TextStyles.gray800FS16FW500CairoTextStyle,
                        ),
                      ],
                    ),
                    horizontalSpace(10.w),
                    Column(
                      children: [
                        Image.asset("assets/image/we.png"),
                        verticalSpace(10.h),
                        Text(
                          getLang(context, "We")
                              .toString(),
                          style: TextStyles.gray800FS16FW500CairoTextStyle,
                        ),
                      ],
                    ),


                  ],
                ),
                SizedBox(height: 60.h), // For spacing between items
                CopyTextWidget(),
              ],
            ),

          ),
        ),
      ),
    );
  }
}
