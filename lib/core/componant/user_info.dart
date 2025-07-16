import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../helper/spacing/spacing.dart';
import '../theme/text_styles.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key, required this.userName, this.isVerified, required this.created_at});

  final String userName;
  final String created_at;
  final bool? isVerified;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              userName,
              style: TextStyles.gray900FS16FW500CairoTextStyle,
            ),
            isVerified == null ? const SizedBox.shrink() : horizontalSpace(5),
            isVerified == null
                ? const SizedBox.shrink()
                : SvgPicture.asset("assets/icons/verified.svg")
          ],
        ),
        verticalSpace(10),
        Text(
          created_at,
          style: TextStyles.gray500FS12FW500CairoTextStyle,
        ),
      ],
    );
  }
}
