import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/theme/text_styles.dart';

class PhotoAlbum extends StatelessWidget {
  const PhotoAlbum({super.key, this.images});

  final List<String>? images;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getLang(context, "Photo Album:").toString(),
          style: TextStyles.gray950FS18FW500TextStyle,
        ),
        GridView.builder(
          shrinkWrap:  true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns in the grid
            mainAxisSpacing: 10, // Vertical space between items
            crossAxisSpacing: 10, // Horizontal space between items
            childAspectRatio: 1, // Aspect ratio of each item
          ),
          itemCount: images!.length, // Number of items in the grid
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    images![index],
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          padding: const EdgeInsets.all(10), // Padding around the grid
        ),
      ],
    );
  }
}
