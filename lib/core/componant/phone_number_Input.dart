import 'package:country_pickers/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/features/auth/logic/auth_cubit/auth_cubit.dart';
import '../../../../../core/app_local/app_local.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/text_styles.dart';
import 'package:country_pickers/country_pickers.dart';

import '../helper/spacing/spacing.dart'; // Assuming you are using this package

class PhoneNumberInput extends StatelessWidget {
  PhoneNumberInput(
      {super.key,
      required this.controller,
      this.validator,
      required this.onPhoneCodeChanged});

  final TextEditingController controller;
  final ValueChanged<String> onPhoneCodeChanged; // Add this callback
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    // Determine whether the current text direction is RTL
    bool isRtl = Directionality.of(context) == TextDirection.rtl;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Adjust text alignment
      children: [
        Text(
          getLang(context, "Enter your phone number").toString(),
          style: TextStyles.gray950FS16FW500CairoTextStyle,
        ),
        verticalSpace(5),
        Row(
          mainAxisAlignment: MainAxisAlignment.start, // Adjust main alignment
          children: [
            // Expanded(
            //   // Country picker container
            //   child: Container(
            //     padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
            //     decoration: BoxDecoration(
            //       color: AppColors.gray100,
            //       borderRadius: BorderRadius.circular(10.r),
            //     ),
            //     child: Center(
            //       child: CountryPickerDropdown(
            //         iconSize: 15.w,
            //         isExpanded: true,
            //         icon: const Icon(
            //           Icons.keyboard_arrow_down_outlined,
            //           color: AppColors.blackColor,
            //         ),
            //         selectedItemBuilder: _buildSelectedItemBuilder,
            //         initialValue: 'EG',
            //         itemBuilder: (country) {
            //           return _buildDropdownItem(country, context);
            //         },
            //         priorityList: [
            //           CountryPickerUtils.getCountryByIsoCode('EG'),
            //           CountryPickerUtils.getCountryByIsoCode('GB'),
            //           CountryPickerUtils.getCountryByIsoCode('CN'),
            //         ],
            //         sortComparator: (Country a, Country b) =>
            //             a.isoCode.compareTo(b.isoCode),
            //         onValuePicked: (Country country) {
            //           onPhoneCodeChanged(country.phoneCode);
            //           debugPrint(country.phoneCode);
            //         },
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(width: 8.w), // Add spacing based on direction
            Expanded(
              flex: 3,
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: AppColors.gray100,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: TextFormField(
                  textDirection:
                      isRtl ? TextDirection.rtl : TextDirection.ltr,
                  // Adjust text direction
                  keyboardType: TextInputType.phone,
                  validator: validator,
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: "01XXXXXXXXX",
                    hintStyle: TextStyles.gray600FS14FW400CairoTextStyle,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSelectedItemBuilder(Country country) => Center(
        child: Text(
          "${country.phoneCode}+",
        ),
      );

  Widget _buildDropdownItem(Country country, BuildContext context) => Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(
            width: 4.w,
          ),
          Expanded(
            child: Text(
              "+${country.phoneCode}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16.sp,
              ),
            ),
          ),
        ],
      );
}
