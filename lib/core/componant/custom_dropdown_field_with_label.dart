import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class CustomDropdownField<T> extends StatelessWidget {
  final String label;
  final String hintText;
  final T? value;
  final Color? fillColor;
  final BorderSide? borderSide;
  final bool? isMandatory;
  final List<T> items;
  final ValueChanged<T?>? onChanged;

  const CustomDropdownField({
    Key? key,
    required this.label,
    required this.hintText,
    this.value,
    this.fillColor,
    this.borderSide,
    this.isMandatory,
    required this.items,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyles.gray950FS16FW500CairoTextStyle,
            ),
            isMandatory == true ?  Text(
              "*",
              style: TextStyle(
                color: const Color(0xFFDC2626),
                fontSize: 16.sp,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w500,
              ),
            ): SizedBox(),
          ],
        ),
        SizedBox(height: 5.h),
        DropdownButtonFormField<T>(
          value: value,
          hint: Text(
            hintText,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: ScreenUtil().setSp(16)),
          ),
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(
                item.toString(),
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(16),
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          isExpanded: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: fillColor?? Color(0xFFF9FAFB),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: borderSide?? BorderSide.none,
            ),
            // focusedBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(8.r),
            //   borderSide: borderSide?? BorderSide.none,
            // ),
            // enabledBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(8.r),
            //   borderSide: borderSide?? BorderSide.none,
            // ),
            // errorBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(8.r),
            //   borderSide: borderSide?? BorderSide.none,
            // ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: borderSide?? BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
