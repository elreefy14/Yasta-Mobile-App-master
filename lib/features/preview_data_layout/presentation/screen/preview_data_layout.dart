import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';
import 'package:yasta/core/theme/colors.dart';
import 'package:yasta/core/theme/text_styles.dart';

import '../../../../core/componant/custom_app_bar.dart';

class PreviewDataLayout extends StatelessWidget {
  const PreviewDataLayout(
      {super.key,
      required this.children,
      this.onBackPressed,
      required this.appBarTitle});

  final List<Widget> children;
  final String appBarTitle;
  final Function()? onBackPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray100,
      appBar: CustomAppBar(
        title: appBarTitle,
        onBackPressed: onBackPressed,
      ),
      body: Builder(
        builder: (context) {
          return ListView(
            children: children,
          );
        },
      ),
    );
  }
}

// PreviewDataUpdateItem(
// children: [
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// const UserImageWidget(
// imageUrl: "",
// ),
// verticalSpace(20),
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// "الاسم",
// style: TextStyles.gray500FS12FW500CairoTextStyle,
// ),
// verticalSpace(5),
// Text(
// "كريم سيد ابراهيم",
// style: TextStyles.gray800FS16FW500CairoTextStyle,
// ),
// ],
// ),
// ],
// ),
// ],
// onCancelPressed: () {
//
// },
// onSavedPressed: () {
//
// },
// ),
