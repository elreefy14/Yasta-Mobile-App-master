import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CenterImage extends StatelessWidget {

  CenterImage({super.key,   this.imageUrl, this.width, this.height});


    String? imageUrl;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(

      width: width ?? 100.w,
      height: height ?? 100.h,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image:  AssetImage(imageUrl??'assets/image/user_profile.png') ,
            fit: BoxFit.cover,
          )),
    );
  }
}
