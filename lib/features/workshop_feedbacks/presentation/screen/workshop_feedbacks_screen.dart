import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/componant/custom_app_bar.dart';
import 'package:yasta/core/constants/constants.dart';
import 'package:yasta/features/workshop_profile/logic/work_shop_for_reviews_cubit.dart';

import '../../../../core/componant/user_image_widget.dart';
import '../../../../core/componant/user_review_widget.dart';
import '../../../../core/helper/cache_helper/cache_helper.dart';
import '../../../../core/helper/spacing/spacing.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../favourite_screen/presentation/widgets/five_star_rating.dart';
import 'package:yasta/features/workshop_profile/model/show_all_reviews.dart';

class WorkshopFeedbacksScreen extends StatefulWidget {
  const WorkshopFeedbacksScreen({super.key});

  @override
  State<WorkshopFeedbacksScreen> createState() =>
      _WorkshopFeedbacksScreenState();
}

class _WorkshopFeedbacksScreenState extends State<WorkshopFeedbacksScreen> {
  List<Reviews> listReviews = [];
  Workshop? workshop;

  @override
  void initState() {
    // TODO: implement initState
    CacheHelper.getdata(key: "workshop_id") == ""
        ? null
        : WorkShopForReviewsCubit.get(context).getAllReviews(
            workshopId: CacheHelper.getdata(key: "workshop_id") == ""
                ? null
                : CacheHelper.getdata(key: "workshop_id"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: getLang(context, "Ratings").toString(),
        centerTitle: true,
      ),
      body: BlocConsumer<WorkShopForReviewsCubit, WorkShopForReviewsState>(
        listener: (context, state) {
          if (state is GetReviewsSuccessState) {
            listReviews = state.data!.data!.reviews!;
            workshop = state.data!.data!.workshop;
            print(workshop);
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          return CacheHelper.getdata(key: "workshop_id") == ""
              ? Center(
                  child: Text(
                    getLang(context, "No Reviews").toString(),
                    style: TextStyles.gray950FS18FW700TextStyle,
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: Constants.hPadding),
                  child: ListView(
                    children: [
                      workshop != null
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                UserImageWidget(
                                  imageUrl: workshop!.logo.toString(),
                                  radius: 40.r,
                                ),
                                horizontalSpace(10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      workshop!.name.toString(),
                                      style:
                                          TextStyles.gray950FS18FW700TextStyle,
                                    ),
                                    verticalSpace(5),
                                    FiveStarRating(
                                      rating: double.parse(
                                          workshop!.rating.toString()),
                                      starSize: 15,
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                      verticalSpace(20),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              verticalSpace(10),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: const Divider(),
                              ),
                              verticalSpace(10),
                            ],
                          );
                        },
                        itemBuilder: (context, index) {
                          return UserReviewWidget(
                            listReviews: listReviews[index],
                          );
                        },
                        itemCount: listReviews.length,
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
