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

class CopyTextWidget extends StatelessWidget {
  const CopyTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(16.w),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.r)),
      ),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getLang(context, "Use this link to pay:").toString(),
            style: TextStyles.blackFS15FW500TextStyle,
            textAlign: TextAlign.start,
          ),
          verticalSpace(20.h),

          Container(
            width: double.infinity,
            height: 40.h,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: ColorsManager.gray100,
              ),
            ),
            child: Center(
              child: Text(
                'http://vodafonecash/yastaa12',
                textAlign: TextAlign.center,
                style: TextStyles.gray900FS16FW500CairoTextStyle,
              ),
            ),),
          verticalSpace(20.h),
          Divider(color:ColorsManager.gray300 ,),
          Text(
            getLang(context, "Or you can copy the link").toString(),
            textAlign: TextAlign.center,
            style: TextStyles.gray100FS14FW400CairoTextStyle,
          ),
          GestureDetector(
            onTap: () {
              Clipboard.setData(const ClipboardData(text: "Copy link"))
                  .then((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Text copied to clipboard")),
                );
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/icons/copy-alt 1.svg"),
                horizontalSpace(10.w),
                Text(
                  getLang(context, "Copy link").toString(),
                  textAlign: TextAlign.center,
                  style: TextStyles.gray700FS16FW500CairoTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
