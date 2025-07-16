import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';
import 'package:yasta/core/theme/text_styles.dart';

class UserImageWithNameWidget extends StatelessWidget {
  const UserImageWithNameWidget(
      {super.key, required this.imagePath, required this.userName});

  final String imagePath;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 100.h,
          width: 100.w,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: Image.network(
              imagePath,
              fit: BoxFit.cover, // Ensures the image covers the circle
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                // If the image fails to load, show the asset image.
                return Image.asset(
                  'assets/image/user_profile.png',
                  fit: BoxFit
                      .cover, // Ensures the fallback asset image covers the circle
                );
              },
            ),
          ),
        ),
        verticalSpace(5),
        Text(
          userName,
          style: TextStyles.gray900FS18FW500CairoTextStyle,
        ),
      ],
    );
  }
}
