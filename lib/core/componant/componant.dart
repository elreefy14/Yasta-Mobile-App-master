import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/theme/colors.dart';

Widget buildDropdown({
  required List<String> itemList,
  required String selectedValue,
  required Function(String?) onChanged,
  required BuildContext context,
  Color? titleColor,
  Color? color,
  Color? color1,
})
{
  return DropdownButton<String>(
    value: selectedValue,

    onChanged: onChanged,
    padding: const EdgeInsets.symmetric(horizontal: 10),
    isExpanded: false,
    dropdownColor: AppColors.gray600,
    autofocus: false,
    underline: Container(
      height: 0,

    ),
    items: itemList.map((itemValue) {
      return DropdownMenuItem(
        value: itemValue,
        child: Text(
           itemValue,
          style: TextStyle(color: color1),
        ),
      );
    }).toList(),
  );
}


class DefaultButton extends StatelessWidget {
  DefaultButton(
      {
        super.key,
        required this.onPressed,
        this.color = const Color(0xFFF4F9F3),
        this.color2 = const Color(0xFFF4F9F3),
        this.borderRadius,

        required this.child,
      }
      );

  final Widget child;
  dynamic onPressed;
  double? borderRadius;


  Color color;
  Color color2;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        // padding:  EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
        backgroundColor: color,
        side: BorderSide(color: color2,),
        shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(borderRadius??6,),
        ),
      ),
      onPressed: onPressed,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.05,
       // width:width?? 220.w,
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
