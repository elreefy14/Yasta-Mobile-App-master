import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/componant/user_image_widget.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';
import 'package:yasta/features/center_profile/presentation/widget/center_image.dart';

import '../../../../core/theme/text_styles.dart';

class ImageAndCenterName extends StatelessWidget {
  const ImageAndCenterName({super.key, required this.imageUrl, required this.centerName});
  final String imageUrl ;
  final String centerName;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        UserImageWidget(
          imageUrl: imageUrl,
          radius: 50.r,
        ),
        horizontalSpace(10),
        Expanded(
          child: Text(
            centerName,
            style: TextStyles.gray950FS18FW700TextStyle,
          ),
        ),
      ],
    );
  }
}
