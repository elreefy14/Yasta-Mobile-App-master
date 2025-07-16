import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../features/favourite_screen/presentation/widgets/five_star_rating.dart';
import '../../features/favourite_screen/presentation/widgets/how_far_workshop.dart';
import '../../features/favourite_screen/presentation/widgets/workshop_location.dart';
import '../../features/favourite_screen/presentation/widgets/workshop_name_with_logo.dart';
import '../../features/favourite_screen/presentation/widgets/workshop_preview_image.dart';
import '../helper/spacing/spacing.dart';
import '../theme/colors.dart';

class WorkshopCard extends StatelessWidget {
  final double userRating;
  final Function(double) onRatingUpdate;
  final String workShopImage;
  final String workShopPreviewImage;
  final String workShopName;
  final String workShopLocation;
  final String workShopDistance;
  final Function() onTap;
  final Function() onTap2;

  const WorkshopCard({
    super.key,
    required this.userRating,
    required this.onRatingUpdate,
    required this.workShopPreviewImage,
    required this.workShopImage,
    required this.workShopName,
    required this.workShopLocation,
    required this.workShopDistance,
    required this.onTap,
    required this.onTap2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WorkshopPreviewImage(
            imagePath: workShopPreviewImage,
          ),
          Padding(
            padding: EdgeInsets.only(
                right: 10.w, left: 10.w, bottom: 15.h, top: 15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WorkshopNameWithLogo(
                  workshopImage: workShopImage,
                  workshopName: workShopName,
                  onTap: onTap,
                  onTap2: onTap2,
                ),
                verticalSpace(5),
                FiveStarRating(
                  rating: userRating,
                  starSize: 22,
                  filledStarColor: Colors.amber,
                  unfilledStarColor: Colors.grey,
                  onRatingUpdate: onRatingUpdate,
                ),
                verticalSpace(10),
                Column(
                  children: [
                    WorkshopLocation(
                      location: workShopLocation,
                      icon: "location_icon.svg",
                    ),
                    verticalSpace(10),
                    HowFarWorkshop(
                      far: workShopDistance,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
