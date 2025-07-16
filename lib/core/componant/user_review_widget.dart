import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/componant/user_info.dart';
import 'package:yasta/core/helper/cache_helper/cache_helper.dart';
import 'package:yasta/core/theme/colors.dart';
import 'package:yasta/core/theme/text_styles.dart';
import 'package:yasta/features/workshop_profile/logic/work_shop_for_reviews_cubit.dart';
import 'package:yasta/features/workshop_profile/model/get_workshop_byId_response.dart';
import 'package:yasta/features/workshop_profile/presentation/widgets/update_review.dart';
import '../constants/constants.dart';
import 'review_text.dart';
import 'user_image_widget.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';
import 'package:yasta/features/favourite_screen/presentation/widgets/five_star_rating.dart';
import 'package:yasta/features/workshop_profile/model/show_all_reviews.dart';

class UserReviewWidget extends StatefulWidget {
  UserReviewWidget({
    super.key,
    required this.listReviews,
  });

  // ShowAllReviewsResponseModel ss = ShowAllReviewsResponseModel();
  dynamic listReviews;

  @override
  State<UserReviewWidget> createState() => _UserReviewWidgetState();
}

class _UserReviewWidgetState extends State<UserReviewWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UserImageWidget(
              radius: 40.r,
              imageUrl: widget.listReviews.userImage,
            ),
            horizontalSpace(10),
            UserInfo(
              userName: widget.listReviews.username ?? "",
              created_at: widget.listReviews.created_at ?? "",
              isVerified: true,
            ),

          ],
        ),
        verticalSpace(10),
        FiveStarRating(
          rating: double.parse(widget.listReviews.rate.toString()),
          starSize: 15.sp,
        ),
        verticalSpace(10),
        Row(
          children: [
            ReviewText(
              reviewText: widget.listReviews.comment.toString(),
            ),
            Spacer(),
            CacheHelper.getdata(
              key: "id",
            ) ==
                widget.listReviews.userId
                ? TextButton(
                onPressed: () =>  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) =>
                              WorkShopForReviewsCubit(),
                          child: UpdateReviewModalContent(
                            comment:
                            widget.listReviews.comment.toString(),
                            commentId: int.parse(
                                widget.listReviews.id.toString()),
                            rating: double.parse(
                                widget.listReviews.rate.toString()),
                            updateReview: (updateReview) {},
                          ),
                        ))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/edit.svg",
                      color: AppColors.blackColor,
                    ),
                    horizontalSpace(5),
                    Text(
                      getLang(context, "Update your review").toString(),
                      style: TextStyles.gray950FS16FW600CairoTextStyle.copyWith(
                        //  decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ))
                : SizedBox.shrink(),
          ],
        ),
      ],
    );
  }

  void _updateReviewModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: AppColors.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0.r)),
      ),
      enableDrag: true,
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15.0.r)),
          ),
          height: MediaQuery.of(context).size.height * 0.6,
          padding: EdgeInsets.symmetric(
            horizontal: Constants.hPadding,
            vertical: 20.h,
          ),
          child: ListView(
            children: [
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) =>
                              WorkShopForReviewsCubit(),
                          child: UpdateReviewModalContent(
                            comment:
                            widget.listReviews.comment.toString(),
                            commentId: int.parse(
                                widget.listReviews.id.toString()),
                            rating: double.parse(
                                widget.listReviews.rate.toString()),
                            updateReview: (updateReview) {},
                          ),
                        ))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/edit.svg",
                      color: AppColors.blackColor,
                    ),
                    horizontalSpace(5),
                    Text(
                      getLang(context, "Update your review").toString(),
                      style: TextStyles.gray950FS16FW600CairoTextStyle.copyWith(
                      //  decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) =>
                              WorkShopForReviewsCubit(),
                          child: UpdateReviewModalContent(
                            comment:
                            widget.listReviews.comment.toString(),
                            commentId: int.parse(
                                widget.listReviews.id.toString()),
                            rating: double.parse(
                                widget.listReviews.rate.toString()),
                            updateReview: (updateReview) {},
                          ),
                        ))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                   Icon(Icons.delete,color: Colors.red,),
                    horizontalSpace(5),
                    Text(
                      getLang(context, "Delete your review").toString(),
                      style: TextStyles.gray950FS16FW600CairoTextStyle.copyWith(
                      //  decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
