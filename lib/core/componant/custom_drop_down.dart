import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/colors.dart';

class CustomDropdown extends StatelessWidget {
  final String? value;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String?> onChanged;
  final String hintText;

  const CustomDropdown({
    Key? key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(10.r),
        ),
        isExpanded: true,
        isDense: true,
        // Reduce the extra height
        itemHeight: 48.h,
        // Set item height
        style: TextStyle(
          fontSize: ScreenUtil().setSp(16),
          color: AppColors.blackColor,
          fontWeight: FontWeight.bold,
        ),
        value: value,
        iconSize: 27.w,
        iconEnabledColor: const Color(0xFF777777),
        alignment: Alignment.center,
        hint: Text(
          hintText,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(16),
          ),
        ),
        // selectedItemBuilder: (context) {
        //   return items.map((item) {
        //     return Text(
        //       item.value!,
        //       style: TextStyle(
        //         fontSize: ScreenUtil().setSp(16),
        //       ),
        //     );
        //   }).toList();
        // },
        items: items,
        onChanged: onChanged,
      ),
    );
  }
}
