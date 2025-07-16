import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/theme/colors.dart';

import '../../../core/constants/constants.dart';
import '../../../core/theme/text_styles.dart';
import '../../core/componant/select_lang_widget.dart';
import '../../core/helper/cache_helper/cache_helper.dart';

class AuthLayout extends StatelessWidget {
  final List<Widget> children;

  const AuthLayout({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.gray950,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              color: AppColors.gray950,
              padding: EdgeInsets.symmetric(
                horizontal: Constants.hPadding,
                vertical: 20.h,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: SelectLangWidget(
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(44.0.r),
                    topRight: Radius.circular(44.0.r),
                  ),
                ),
                padding: EdgeInsets.only(
                  left: Constants.hPadding,
                  right: Constants.hPadding,
                  top: 44.h,
                ),
                child: ListView(
                  children: children,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
