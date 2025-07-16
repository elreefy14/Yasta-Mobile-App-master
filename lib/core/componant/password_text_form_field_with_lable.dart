import 'package:flutter/material.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';

import '../theme/text_styles.dart';

class PasswordTextFormFieldWithLable extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const PasswordTextFormFieldWithLable({
    Key? key,
    required this.label,
    required this.hintText,
    this.validator,
    required this.controller,
  }) : super(key: key);

  @override
  _PasswordTextFormFieldWithLableState createState() => _PasswordTextFormFieldWithLableState();
}

class _PasswordTextFormFieldWithLableState extends State<PasswordTextFormFieldWithLable> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyles.gray950FS16FW500CairoTextStyle,
        ),
        verticalSpace(5),
        TextFormField(
          controller: widget.controller,
          obscureText: _isObscured,
          keyboardType: TextInputType.visiblePassword,
          validator: widget.validator,
          decoration: InputDecoration(
            hintText: widget.hintText,
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
            suffixIcon: IconButton(
              icon: Icon(
                _isObscured
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
              onPressed: () {
                setState(() {
                  _isObscured = !_isObscured;
                });
              },
            ),
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
          ),
        ),
      ],
    );
  }
}
