// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// import '../../../../../../core/app_local/app_local.dart';
// import '../../../../../../core/componant/dashed_border_container.dart';
// import '../../../../../../core/helper/spacing/spacing.dart';
// import '../../../../../../core/theme/text_styles.dart';
//
// class PhotoAlbum extends StatefulWidget {
//   @override
//   _PhotoAlbumState createState() => _PhotoAlbumState();
// }
//
// class _PhotoAlbumState extends State<PhotoAlbum> {
//   // List to store selected images (for demo, using placeholders)
//   List<ImageProvider> selectedImages = [];
//
//   // Function to simulate picking an image and adding it to the list
//   Future<void> _pickImage() async {
//     // Replace this with actual image picker logic.
//     final newImage =
//         AssetImage("assets/image/placeholder.png"); // Placeholder image
//     setState(() {
//       selectedImages.add(newImage);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           getLang(context, "Photo Album").toString(),
//           style: TextStyles.gray950FS18FW500TextStyle,
//         ),
//         const SizedBox(height: 8),
//         Wrap(
//           spacing: 10,
//           runSpacing: 10,
//           children: [
//             // Display selected images
//             for (var image in selectedImages)
//               Container(
//                 width: 100.w,
//                 height: 100.h,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   image: DecorationImage(image: image, fit: BoxFit.cover),
//                 ),
//               ),
//             // Dashed container for adding new images
//             DashedBorderContainer(
//               width: MediaQuery.of(context).size.width * 0.3,
//               borderRadius: BorderRadius.circular(10),
//               color: Colors.black,
//               child: InkWell(
//                 onTap: _pickImage,
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SvgPicture.asset(
//                         "assets/image/upload.svg",
//                         width: 80.w,
//                         height: 40.h,
//                       ),
//                       verticalSpace(5),
//                       Text(
//                         getLang(context, "Upload image here").toString(),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyles.gray600FS14FW400CairoTextStyle,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yasta/features/auth/logic/auth_cubit/auth_cubit.dart';
import 'dart:io'; // For handling file paths

import '../../../../../../core/app_local/app_local.dart';
import '../../../../../../core/componant/dashed_border_container.dart';
import '../../../../../../core/helper/spacing/spacing.dart';
import '../../../../../../core/theme/text_styles.dart';
import '../../../../../../core/di/dependency_injection.dart';
import '../../../../widgets/mandatory_text.dart';

class PhotoAlbum extends StatefulWidget {
  @override
  _PhotoAlbumState createState() => _PhotoAlbumState();
}

class _PhotoAlbumState extends State<PhotoAlbum> {
  // List to store selected image files


  // Function to pick an image using ImagePicker
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        getIt<AuthCubit>(). selectedImages.add(File(pickedFile.path));
      });
      for (var image in getIt<AuthCubit>(). selectedImages) {
        debugPrint(image.path.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MandatoryText(
          label:getLang(context, "Photo Album").toString(),
        ),
        const SizedBox(height: 8),
        getIt<AuthCubit>(). selectedImages.isEmpty
            ? Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  // Display selected images
                  for (var image in getIt<AuthCubit>(). selectedImages)
                    Container(
                      width: 130.w,
                      height: 130.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: FileImage(image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  // Dashed container for adding new images
                  DashedBorderContainer(
                    width: 130.w,
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                    child: InkWell(
                      onTap: _pickImage,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/image/upload.svg",
                              width: 80.w,
                              height: 40.h,
                            ),
                            verticalSpace(5),
                            Text(
                              getLang(context, "Upload image here").toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyles.gray600FS14FW400CairoTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Center(
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    // Display selected images
                    for (var image in getIt<AuthCubit>(). selectedImages)
                      Container(
                        width: 130.w,
                        height: 130.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: FileImage(image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    // Dashed container for adding new images
                    DashedBorderContainer(
                      width: 130.w,
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black,
                      child: InkWell(
                        onTap: _pickImage,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/image/upload.svg",
                                width: 80.w,
                                height: 40.h,
                              ),
                              verticalSpace(5),
                              Text(
                                getLang(context, "Upload image here")
                                    .toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    TextStyles.gray600FS14FW400CairoTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
