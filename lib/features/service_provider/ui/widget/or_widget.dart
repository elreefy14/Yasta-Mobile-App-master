import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/helper/app_color/app_color.dart';

import '../../../../core/app_local/app_local.dart';

class OrWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 150.w,
          height: 2,
          color: ColorsManager.gray300,
        ),
        Text(
          getLang(context, "or").toString()
          ,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          width: 150.w,
          height: 2,
          color: ColorsManager.gray300,
        ),
      ],
    );
  }
}
