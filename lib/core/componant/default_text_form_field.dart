import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/text_styles.dart';

class DefaultTextFormField extends StatelessWidget {
  const DefaultTextFormField({super.key, required this.hintText, this.validator, required this.controller,  this.minLines, this.fillColor});
  final String hintText;
  final TextEditingController controller;
  final int? minLines ;
  final Color? fillColor ;
  final String? Function(String?)? validator;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: minLines,
      maxLines: null,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyles.gray600FS14FW400CairoTextStyle,
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
        fillColor: fillColor?? const Color(0xFFF9FAFB),
      ),
    );
  }
}
