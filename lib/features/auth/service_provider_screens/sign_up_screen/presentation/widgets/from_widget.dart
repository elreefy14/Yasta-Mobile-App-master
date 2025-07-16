import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/features/auth/logic/auth_cubit/auth_cubit.dart';

import '../../../../../../core/app_local/app_local.dart';
import '../../../../../../core/helper/spacing/spacing.dart';
import '../../../../../../core/theme/text_styles.dart';
import '../../../../../../core/utils/max_value_formatter.dart';
import 'am_pm_selector.dart';

class FromOrToWidget extends StatefulWidget {
  const FromOrToWidget({
    super.key,
    required this.label,
    required this.minuteController,
    required this.hourController,
  });

  final String label;
  final TextEditingController minuteController;
  final TextEditingController hourController;

  @override
  _FromOrToWidgetState createState() => _FromOrToWidgetState();
}

class _FromOrToWidgetState extends State<FromOrToWidget> {
  bool isAmSelected = true; // AM is selected by default

  void _onAmPmChanged(bool isAm) {
    setState(() {
      isAmSelected = isAm;
      _updateHour();
    });
  }

  // Update the hour based on AM/PM selection
  void _updateHour() {
    int hour = int.tryParse(widget.hourController.text) ?? 0;
    if (!isAmSelected && hour < 12) {
      widget.hourController.text = (hour + 12).toString(); // Add 12 for PM
    } else if (isAmSelected && hour >= 12) {
      widget.hourController.text = (hour - 12).toString(); // Adjust for AM (if hour > 12)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyles.gray950FS18FW500TextStyle,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AmPmSelector(onChanged: _onAmPmChanged), // Pass the callback here
            horizontalSpace(10),
            Column(
              children: [
                SizedBox(
                  width: 80.w,
                  child: TextFormField(
                    style: TextStyles.gray950FS18FW700TextStyle,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(2),
                      MaxValueFormatter(59),
                    ],
                    controller: widget.minuteController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "00",
                      hintStyle: TextStyles.gray950FS18FW700TextStyle,
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFE5E7EB),
                        ),
                        borderRadius: BorderRadius.circular(5.0.r),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 0.5,
                          color: Color(0xFFE5E7EB),
                        ),
                        borderRadius: BorderRadius.circular(5.0.r),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 0.5,
                          color: Color(0xFFE5E7EB),
                        ),
                        borderRadius: BorderRadius.circular(5.0.r),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF9FAFB),
                    ),
                  ),
                ),
                Text(
                  getLang(context, "Minute").toString(),
                  style: TextStyles.gray950FS18FW500TextStyle,
                ),
              ],
            ),
            horizontalSpace(10),
            Column(
              children: [
                Container(
                  width: 10.w,
                  height: 10.h,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                ),
                verticalSpace(10),
                Container(
                  width: 10.w,
                  height: 10.h,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            horizontalSpace(10),
            Column(
              children: [
                SizedBox(
                  width: 80.w,
                  child: TextFormField(
                    controller: widget.hourController,
                    keyboardType: TextInputType.number,
                    style: TextStyles.gray950FS18FW700TextStyle,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(2),
                      MaxValueFormatter(23),
                    ],
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "00",
                      hintStyle: TextStyles.gray950FS18FW700TextStyle,
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFE5E7EB),
                        ),
                        borderRadius: BorderRadius.circular(5.0.r),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 0.5,
                          color: Color(0xFFE5E7EB),
                        ),
                        borderRadius: BorderRadius.circular(5.0.r),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 0.5,
                          color: Color(0xFFE5E7EB),
                        ),
                        borderRadius: BorderRadius.circular(5.0.r),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF9FAFB),
                    ),
                  ),
                ),
                Text(
                  getLang(context, "Hour").toString(),
                  style: TextStyles.gray950FS18FW500TextStyle,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
