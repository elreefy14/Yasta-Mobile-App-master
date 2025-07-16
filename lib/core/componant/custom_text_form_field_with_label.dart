import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';

import '../theme/text_styles.dart';
import 'default_text_form_field.dart';

class CustomTextFormFieldWithLabel extends StatelessWidget {
  final String label;
  final String hintText;
  final int? minLines;
  final Color? fillColor;
  final TextEditingController controller;
  final String? Function(String?)? validator;


  const CustomTextFormFieldWithLabel({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.minLines,
    this.fillColor,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles.gray950FS16FW500CairoTextStyle,
        ),
        verticalSpace(5),
        DefaultTextFormField(
          controller: controller,
          hintText: hintText,
          minLines: minLines,
          fillColor: fillColor,
          validator: validator,
        ),
      ],
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyles.gray100FS14FW400CairoTextStyle,
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xFFE5E7EB),
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 0.5,
                color: Color(0xFFE5E7EB),
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 0.5,
                color: Color(0xFFE5E7EB),
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
          ),
        ),
      ],
    );
  }
}
