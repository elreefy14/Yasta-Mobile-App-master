import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';
import 'package:yasta/core/theme/text_styles.dart';

class NotificationItem extends StatelessWidget {
  final String text;
  final String image;

  const NotificationItem({super.key, required this.text, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.12,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.r, // Adjust radius as needed
            backgroundImage: NetworkImage(
              image, // Replace with the actual image URL
            ),
          ),
          horizontalSpace( 10.w),
          Expanded(
            child: Text(
              text,
              style: TextStyles.blackFS15FW500TextStyle,
            ),
          ),
        ],
      ),
    );
  }
}