import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class CustomMultiSelectDropdownField<T> extends StatefulWidget {
  final String label;
  final String hintText;
  final List<T> selectedValues;
  final bool? isMandatory;
  final List<T> items;
  final ValueChanged<List<T>> onChanged;

  const CustomMultiSelectDropdownField({
    Key? key,
    required this.label,
    required this.hintText,
    required this.selectedValues,
    this.isMandatory,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CustomMultiSelectDropdownFieldState<T> createState() =>
      _CustomMultiSelectDropdownFieldState<T>();
}

class _CustomMultiSelectDropdownFieldState<T>
    extends State<CustomMultiSelectDropdownField<T>> {
  bool isDropdownOpen = false; // Track if the dropdown is open or closed

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label ==''? SizedBox.shrink():   Row(
          children: [
            Text(
              widget.label,
              style: TextStyles.gray950FS16FW500CairoTextStyle,
            ),
            if (widget.isMandatory == true)
              Text(
                "*",
                style: TextStyle(
                  color: const Color(0xFFDC2626),
                  fontSize: 16.sp,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
        SizedBox(height: 5.h),
        GestureDetector(
          onTap: () {
            setState(() {
              isDropdownOpen = !isDropdownOpen;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.selectedValues.isEmpty
                        ? widget.hintText
                        : widget.selectedValues
                            .map((e) => e.toString())
                            .join(", "),
                    style: TextStyle(fontSize: 16.sp),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(isDropdownOpen
                    ? Icons.arrow_drop_up
                    : Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        if (isDropdownOpen)
          Container(
            margin: EdgeInsets.only(top: 5.h),
            padding: EdgeInsets.symmetric(vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: widget.items.map((item) {
                bool isSelected = widget.selectedValues.contains(item);
                return CheckboxListTile(
                  value: isSelected,
                  title: Text(item.toString()),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool? checked) {
                    setState(() {
                      if (checked == true) {
                        widget.selectedValues.add(item);
                      } else {
                        widget.selectedValues.remove(item);
                      }
                      widget.onChanged(widget
                          .selectedValues); // Call the callback with updated values
                    });
                  },
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}



class CustomMultiSelectDropdownField2<T> extends StatefulWidget {
  final String label;
  final String hintText;
  final List<T> selectedValues;
  final bool? isMandatory;
  final List<T> items;
  final ValueChanged<List<T>> onChanged;

  const CustomMultiSelectDropdownField2({
    Key? key,
    required this.label,
    required this.hintText,
    required this.selectedValues,
    this.isMandatory,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CustomMultiSelectDropdownField2State<T> createState() =>
      _CustomMultiSelectDropdownField2State<T>();
}

class _CustomMultiSelectDropdownField2State<T>
    extends State<CustomMultiSelectDropdownField2<T>> {
  bool isDropdownOpen = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label.isNotEmpty)
          Row(
            children: [
              Text(
                widget.label,
                style: TextStyles.gray950FS16FW500CairoTextStyle,
              ),
              if (widget.isMandatory == true)
                Text(
                  "*",
                  style: TextStyle(
                    color: const Color(0xFFDC2626),
                    fontSize: 16.sp,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
        SizedBox(height: 5.h),
        GestureDetector(
          onTap: () {
            setState(() {
              isDropdownOpen = !isDropdownOpen;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.selectedValues.isEmpty
                        ? widget.hintText
                        : widget.selectedValues
                        .map((e) => e.toString())
                        .join(", "),
                    style: TextStyle(fontSize: 16.sp),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(isDropdownOpen
                    ? Icons.arrow_drop_up
                    : Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        if (isDropdownOpen)
          Container(
            margin: EdgeInsets.only(top: 5.h),
            padding: EdgeInsets.symmetric(vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
                const BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: widget.items.map((item) {
                final bool isSelected = widget.selectedValues.contains(item);
                return CheckboxListTile(
                  value: isSelected,
                  title: Text(item.toString()),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool? checked) {
                    final updatedSelectedValues =
                    List<T>.from(widget.selectedValues);

                    if (checked == true) {
                      updatedSelectedValues.add(item);
                    } else {
                      updatedSelectedValues.remove(item);
                    }

                    widget.onChanged(updatedSelectedValues);
                  },
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}


class CustomSingleSelectDropdownField<T> extends StatefulWidget {
  final String label;
  final String hintText;
  final T? selectedValue;
  final bool? isMandatory;
  final List<T> items;
  final ValueChanged<T?> onChanged;

  const CustomSingleSelectDropdownField({
    Key? key,
    required this.label,
    required this.hintText,
    required this.selectedValue,
    this.isMandatory,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CustomSingleSelectDropdownFieldState<T> createState() =>
      _CustomSingleSelectDropdownFieldState<T>();
}

class _CustomSingleSelectDropdownFieldState<T>
    extends State<CustomSingleSelectDropdownField<T>> {
  bool isDropdownOpen = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label == ''
            ? SizedBox.shrink()
            : Row(
          children: [
            Text(
              widget.label,
              style: TextStyles.gray950FS16FW500CairoTextStyle,
            ),
            if (widget.isMandatory == true)
              Text(
                "*",
                style: TextStyle(
                  color: const Color(0xFFDC2626),
                  fontSize: 16.sp,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
        SizedBox(height: 5.h),
        GestureDetector(
          onTap: () {
            setState(() {
              isDropdownOpen = !isDropdownOpen;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.selectedValue == null
                        ? widget.hintText
                        : widget.selectedValue.toString(),
                    style: TextStyle(fontSize: 16.sp),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(isDropdownOpen
                    ? Icons.arrow_drop_up
                    : Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        if (isDropdownOpen)
          Container(
            margin: EdgeInsets.only(top: 5.h),
            padding: EdgeInsets.symmetric(vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: widget.items.map((item) {
                bool isSelected = widget.selectedValue == item;
                return RadioListTile<T>(
                  value: item,
                  groupValue: widget.selectedValue,
                  title: Text(item.toString()),
                  onChanged: (T? value) {
                    setState(() {
                      widget.onChanged(value); // Update the selected value
                      isDropdownOpen = false; // Close the dropdown
                    });
                  },
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}

