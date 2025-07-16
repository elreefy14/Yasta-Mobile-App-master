import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/features/auth/data/models/schedule_model.dart';
import 'package:yasta/features/auth/logic/auth_cubit/auth_cubit.dart';

import '../../../../../../core/app_local/app_local.dart';
import '../../../../../../core/componant/custom_multi_select_dropdown_field.dart';
import '../../../../../../core/di/dependency_injection.dart';
import '../../../../../../core/helper/spacing/spacing.dart';
import '../../../../../../core/theme/colors.dart';
import '../../../../../../core/theme/text_styles.dart';
import 'from_and_to_widget.dart';

class AppointmentsWidget extends StatefulWidget {
  AppointmentsWidget({super.key, this.isEdit = false});

  bool isEdit = false;

  @override
  State<AppointmentsWidget> createState() => _AppointmentsWidgetState();
}

class _AppointmentsWidgetState extends State<AppointmentsWidget> {
  // Store controllers for each FromAndToWidget

  void addWorkingHours() {
    // print("addWorkingHours called ${workingHours.length} and ${workingHours[0]['fromHourController'].text}");
    // print("addWorkingHours called ${workingHours.length} and ${workingHours[0]['fromMinuteController'].text}");

    setState(() {
      getIt<AuthCubit>().workingHours.add({
        'dayController': <String>[], // Days selected
        'fromHourController': TextEditingController(),
        'fromMinuteController': TextEditingController(),
        'toHourController': TextEditingController(),
        'toMinuteController': TextEditingController(),
      });
    });
  }

  void removeWorkingHours(int index) {
    setState(() {
      getIt<AuthCubit>().workingHours[index]['fromHourController'].dispose();
      getIt<AuthCubit>().workingHours[index]['fromMinuteController'].dispose();
      getIt<AuthCubit>().workingHours[index]['toHourController'].dispose();
      getIt<AuthCubit>().workingHours[index]['toMinuteController'].dispose();
      getIt<AuthCubit>().workingHours.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        !widget.isEdit
            ? Text(
                getLang(context, "Appointments").toString(),
                style: TextStyles.gray950FS18FW500TextStyle,
              )
            : const SizedBox.shrink(),
        !widget.isEdit ? verticalSpace(5) : const SizedBox.shrink(),
        !widget.isEdit
            ? Text(
                getLang(context,
                        "If you have different working hours on different days, you can easily add new working hours by clicking on the “Add another working hours” button")
                    .toString(),
                style: TextStyles.gray600FS14FW400CairoTextStyle,
              )
            : const SizedBox.shrink(),
        !widget.isEdit ? verticalSpace(10) : const SizedBox.shrink(),

        // Render all widgets dynamically
        ...getIt<AuthCubit>().workingHours.asMap().entries.map((entry) {
          int index = entry.key;
          Map<String, dynamic> controllers = entry.value;

          return Column(
            children: [
              FromAndToWidget(
                index: index,
                selectedDays: controllers['dayController'],
                fromHourController: controllers['fromHourController'],
                fromMinuteController: controllers['fromMinuteController'],
                toHourController: controllers['toHourController'],
                toMinuteController: controllers['toMinuteController'],
                onDelete: () => removeWorkingHours(index),
              ),
              verticalSpace(20),
            ],
          );
        }),
        verticalSpace(30),

        // Add new working hours button
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.gray100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.r),
              side: const BorderSide(
                color: Color(0xFF9CA3AF),
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 15.h,
            ),
          ),
          onPressed: addWorkingHours,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add,
                color: AppColors.gray600,
              ),
              horizontalSpace(10),
              Text(
                getLang(context, "Add another working hours").toString(),
                style: TextStyles.gray600FS14FW400CairoTextStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
