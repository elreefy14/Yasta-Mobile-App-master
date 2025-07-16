import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/componant/default_button.dart';
import '../../../../core/componant/save_cancel_buttons.dart';
import '../../../../core/helper/spacing/spacing.dart';
import '../../../../core/theme/colors.dart';

class PreviewDataUpdateItem extends StatelessWidget {
  PreviewDataUpdateItem(
      {super.key,
      required this.children,
      required this.onSavedPressed,
      required this.onCancelPressed});

  final List<Widget> children;
  final Function() onSavedPressed;

  final Function() onCancelPressed;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(
                    color: AppColors.gray200,
                    width: 1.w,
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
            ),
            verticalSpace(20),
            SaveCancelButtons(
              onCancelPressed: onCancelPressed,
              onSavedPressed: () {
                if (formKey.currentState!.validate()) onSavedPressed();
              },
            ),
          ],
        ),
      ),
    );
  }
}
