import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MaxValueFormatter extends TextInputFormatter {
  final int maxValue;

  MaxValueFormatter(this.maxValue);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // Convert the new value text to an integer
    int? newInt = int.tryParse(newValue.text);

    // If the new value is not a valid integer or is within the allowed range, return it
    if (newInt == null || newInt <= maxValue) {
      return newValue;
    }

    // Otherwise, keep the old value
    return oldValue;
  }
}
