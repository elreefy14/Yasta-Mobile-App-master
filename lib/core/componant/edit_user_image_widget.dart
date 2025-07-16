import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yasta/core/componant/user_image_widget.dart';
import 'package:yasta/core/di/dependency_injection.dart';
import 'package:yasta/features/user_profile_screen/logic/user_profile_cubit.dart';

import '../theme/colors.dart';

class EditUserImageWidget extends StatefulWidget {
  const EditUserImageWidget(
      {super.key, required this.imageUrl, this.width, this.height});

  final String imageUrl;
  final double? width;
  final double? height;

  @override
  State<EditUserImageWidget> createState() => _EditUserImageWidgetState();
}

class _EditUserImageWidgetState extends State<EditUserImageWidget> {
  File? selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
        getIt<UserProfileCubit>().image=selectedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await _pickImage();
        getIt<UserProfileCubit>().image=selectedImage;
      },
      child: Stack(
        children: [
           UserImageWidget(
            imageUrl: selectedImage?.path ?? widget.imageUrl,
             radius: 40.r,
          ),
          Positioned(
            bottom: 0,
            right: 5.w,
            child: Container(
              width: 30.w,
              height: 30.h,
              decoration: BoxDecoration(
                color: AppColors.blackColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.blackColor,
                ),
              ),
              child: Icon(
                Icons.edit_outlined,
                color: AppColors.whiteColor,
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
