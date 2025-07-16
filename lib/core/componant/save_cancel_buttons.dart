import 'package:flutter/material.dart';

import '../app_local/app_local.dart';
import '../helper/spacing/spacing.dart';
import '../theme/colors.dart';
import 'default_button.dart';

class SaveCancelButtons extends StatelessWidget {
  final VoidCallback onSavedPressed;
  final VoidCallback onCancelPressed;

  Color? cancelButtonBackgroundColor;

   SaveCancelButtons({
    Key? key,
    required this.onSavedPressed,
    required this.onCancelPressed,
    this.cancelButtonBackgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          // width: MediaQuery.of(context).size.width * 0.3,
          child: DefaultButton(
            label: getLang(context, "Save").toString(), // Save
            onPressed: onSavedPressed,
          ),
        ),
        horizontalSpace(20),
        Expanded(
          // width: MediaQuery.of(context).size.width * 0.3,
          child: DefaultButton(
            backgroundColor: cancelButtonBackgroundColor?? AppColors.gray200,
            textColor: AppColors.gray800,
            label: getLang(context, "cancel").toString(), // Cancel
            onPressed: onCancelPressed,
          ),
        ),
      ],
    );
  }
}

class LogOutButtons extends StatelessWidget {
  final VoidCallback onSavedPressed;
  final VoidCallback onCancelPressed;

  Color? cancelButtonBackgroundColor;

  LogOutButtons({
    Key? key,
    required this.onSavedPressed,
    required this.onCancelPressed,
    this.cancelButtonBackgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          // width: MediaQuery.of(context).size.width * 0.3,
          child: DefaultButton(
            label: getLang(context, "Logout").toString(), // Save
            onPressed: onSavedPressed,
          ),
        ),
        horizontalSpace(20),
        Expanded(

          // width: MediaQuery.of(context).size.width * 0.3,
          child: DefaultButton(
            backgroundColor: cancelButtonBackgroundColor?? AppColors.gray200,
            textColor: AppColors.gray800,
            label: getLang(context, "cancel").toString(), // Cancel
            onPressed: onCancelPressed,
          ),
        ),
      ],
    );
  }
}
