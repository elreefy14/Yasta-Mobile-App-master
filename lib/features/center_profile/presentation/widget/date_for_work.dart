import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/features/workshop_profile/model/get_workshop_byId_response.dart';

import '../../../../core/helper/spacing/spacing.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../data/models/show_workshop_data_response.dart';

class DateForWork extends StatelessWidget {
  final List<Schedule> schedules;

  const DateForWork({super.key, required this.schedules});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getLang(context, "Appointments").toString(),
          style: TextStyles.gray950FS18FW500TextStyle,
        ),
        Column(
          children: schedules.map((schedule) {
            // Formatting the time strings (e.g., removing seconds)
            String formattedOpeningTime = schedule.openingTime!.substring(0, 5);
            String formattedClosingTime = schedule.closingTime!.substring(0, 5);

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 10.w,
                    height: 10.h,
                    decoration: const BoxDecoration(
                      color: AppColors.blackColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  horizontalSpace(10),
                  Expanded(
                    child: Text(
                      "${schedule.dayWeek} ${getLang(context, "from hour").toString()} $formattedOpeningTime ${getLang(context, "to").toString()} $formattedClosingTime",
                      style: TextStyles.gray800FS14FW500CairoTextStyle,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
