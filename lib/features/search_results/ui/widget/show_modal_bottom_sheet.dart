import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/componant/componant.dart';
import 'package:yasta/core/constants/constants.dart';

import '../../../../core/app_local/app_local.dart';
import '../../../../core/helper/app_color/app_color.dart';
import '../../../../core/helper/spacing/spacing.dart';
import '../../../../core/theme/text_styles.dart';

class ShowModalBottomSheet extends StatefulWidget {
  final Function(String criteria) onSortSelected;

  const ShowModalBottomSheet({super.key, required this.onSortSelected});

  @override
  State<ShowModalBottomSheet> createState() => _ShowModalBottomSheetState();
}

class _ShowModalBottomSheetState extends State<ShowModalBottomSheet> {
  final List<Map<String, dynamic>> options = [
    {"label": "Top Ratings", "isSelected": false},
    {"label": "From the closest to the farthest", "isSelected": false},
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding:
      EdgeInsets.symmetric(horizontal: Constants.hPadding, vertical: 15.h),
      child: ListView(
        children: [
          Row(
            children: [
              Text(
                getLang(context, "Sort By").toString(),
                style: TextStyles.blackFS15FW500TextStyle,
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  color: ColorsManager.blackColor,
                ),
              ),
            ],
          ),
          verticalSpace(10.h),
          ...options.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> option = entry.value;

            return CheckboxListTile(
              title: Text(
                getLang(context, option["label"]).toString(),
                style: TextStyles.gray800FS16FW500CairoTextStyle,
              ),
              contentPadding: const EdgeInsets.all(0),
              value: option["isSelected"],
              onChanged: (bool? value) {
                setState(() {
                  options[index]["isSelected"] = value ?? false;

                  // Ensure only one option can be selected at a time
                  for (int i = 0; i < options.length; i++) {
                    if (i != index) options[i]["isSelected"] = false;
                  }
                });
              },
            );
          }),
          verticalSpace(15.h),
          DefaultButton(
            color: ColorsManager.blackColor,
            onPressed: () {
              final selectedOption = options
                  .firstWhere((option) => option["isSelected"], orElse: () => options[0]);
              if (selectedOption != null) {
                widget.onSortSelected(selectedOption["label"]);
              }
              Navigator.pop(context);
            },
            child: Text(
              getLang(context, "Rank the results").toString(),
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
