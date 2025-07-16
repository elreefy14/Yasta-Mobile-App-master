import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/app_local/app_local.dart';

import '../../../../core/helper/spacing/spacing.dart';

class WhoIamWidget extends StatelessWidget {
  const WhoIamWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(getLang(context,"Who are you..?").toString(),
            style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: Colors.grey[950])),
        verticalSpace(10.h),
        Text(getLang(context, "Choose are you a car owner looking for help or a service provider").toString(),
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey[600])),
      ],
    );
  }
}
