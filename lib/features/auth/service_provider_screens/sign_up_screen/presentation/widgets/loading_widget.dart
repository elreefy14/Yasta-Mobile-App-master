import 'package:flutter/material.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent closing by tapping outside
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children:  [
          const  CircularProgressIndicator(),
            verticalSpace(10),
            Text(getLang(context, "Processing... Please wait").toString()),
          ],
        ),
      );
    },
  );
}