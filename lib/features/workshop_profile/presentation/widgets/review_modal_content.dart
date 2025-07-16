import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/componant/custom_text_form_field_with_label.dart';
import 'package:yasta/core/componant/default_button.dart';
import 'package:yasta/core/constants/constants.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';
import 'package:yasta/core/theme/colors.dart';
import 'package:yasta/core/theme/text_styles.dart';
import 'package:yasta/features/workshop_profile/logic/work_shop_for_reviews_cubit.dart';
import 'package:yasta/features/workshop_profile/model/add_reviwe_model.dart';
import '../../../favourite_screen/presentation/widgets/five_star_rating.dart';
import '../../model/add_Reviews_response.dart';
import '../../model/get_workshop_byId_response.dart';

class ReviewModalContent extends StatefulWidget {
  const ReviewModalContent({super.key, required this.workshopId, required this.updateReview});

  final int workshopId;
 final Function(AddReviewsResponseModel) updateReview;

  @override
  State<ReviewModalContent> createState() => ReviewModalContentState();
}

class ReviewModalContentState extends State<ReviewModalContent> {
  double rating = 0;

  @override
  Widget build(BuildContext context) {
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
          _buildModalHeader(context),
          verticalSpace(10),
          FiveStarRating(
            onRatingUpdate: (newRating) => setState(() => rating = newRating),
            rating: rating,
            starSize: 60,
            filledStarColor: const Color(0xffFDE047),
          ),
          verticalSpace(10),
          _buildReviewInput(context),
          verticalSpace(10),
          _buildSubmitButton(context),
          BlocListener<WorkShopForReviewsCubit,
              WorkShopForReviewsState>(
            listener: (context, state) {
              if (state is AddReviewsSuccessState) {
                widget.updateReview(state.data!);
                Navigator.of(context).pop(); // Pop the bottom sheet
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.data!.message??'')),
                );
                // cubit.getWorkshopDataById(id: widget.id);
              }
            },
            child: const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildModalHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          getLang(context, "Your rating").toString(),
          style: TextStyles.gray950FS18FW500TextStyle,
        ),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),

      ],
    );
  }

  Widget _buildReviewInput(BuildContext context) {
    return Column(
      children: [
        Text(
          getLang(context, "Share with us").toString(),
          textAlign: TextAlign.center,
          style: TextStyles.gray900FS16FW500CairoTextStyle,
        ),
        CustomTextFormFieldWithLabel(
          label: "",
          hintText: getLang(context, "Write your review").toString(),
          controller: WorkShopForReviewsCubit.get(context).reviewsController,
          minLines: 4,
          fillColor: AppColors.gray200,
        ),
      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return DefaultButton(
      label: getLang(context, "Send").toString(),
      onPressed: () {
        final cubit = WorkShopForReviewsCubit.get(context);
        cubit.addReviews(
          addReviewsModel: AddReviewsModel(
            comment: cubit.reviewsController.text,
            workshopId: widget.workshopId.toString(),
            rate: rating.toString(),
          ),
        );
        // Navigator.pop(context);
      },
    );
  }
}
