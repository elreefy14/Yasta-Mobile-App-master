import 'package:flutter/material.dart';
import 'package:yasta/features/auth/widgets/mandatory_text.dart';

import '../helper/spacing/spacing.dart';
import 'default_text_form_field.dart';

class TextFormFieldWithMandatoryLabel extends StatelessWidget {
  const TextFormFieldWithMandatoryLabel(
      {super.key,
      required this.label,
      required this.hintText,
      required this.controller, this.validator});

  final String label;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MandatoryText(
          label: label,
        ),
        verticalSpace(8),
        DefaultTextFormField(
          controller: controller,
          validator: validator,
          hintText: hintText,
        ),
      ],
    );
  }
}
