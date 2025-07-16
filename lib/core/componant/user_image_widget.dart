import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserImageWidget extends StatelessWidget {
  const UserImageWidget(
      {super.key, required this.imageUrl, this.radius});

  final dynamic imageUrl;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius ?? 20.r,
      backgroundImage: imageUrl is String && imageUrl.isNotEmpty
          ? NetworkImage(imageUrl) as ImageProvider<Object>
          : FileImage(File(imageUrl)) as ImageProvider<Object>?,
      onBackgroundImageError: (e, stackTrace) {
        print(e);
      },
    );
  }
}
