import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/componant/user_image_widget.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';
import 'package:yasta/core/theme/colors.dart';
import 'package:yasta/features/chat_screen/data/model/start_model.dart';
import 'package:yasta/features/favourite_screen/presentation/widgets/five_star_rating.dart';
import '../../../../core/componant/circular_icon_button.dart';
import '../../../../core/componant/icon_with_text.dart';
import '../../../../core/route/route_strings/route_strings.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../center_profile/presentation/widget/icon_for_connect.dart';
import '../../../chat_screen/data/logic/chat_cubit.dart';
import '../../../favourite_screen/presentation/widgets/workshop_location.dart';
import '../../model/get_workshop_byId_response.dart';

class WorkshopInfoSection extends StatelessWidget {
  const WorkshopInfoSection(
      {super.key,
      required this.workshopName,
      required this.workshopImage,
      required this.rating,
      required this.address,
      required this.phone,
      required this.schedule,
      required this.socialMediaData,
      required this.isOpen,
      required this.workshopId});

  final String workshopName;
  final String workshopImage;
  final String address;
  final String phone;
  final double rating;
  final int workshopId;
  final List<Schedule> schedule;
  final IsOpen isOpen;
  final List<dynamic> socialMediaData; // Accept the data as a parameter

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UserImageWidget(
                  imageUrl: workshopImage,
                  radius: 30.r,
                ),
                horizontalSpace(10),
                Expanded(
                  child: Text(
                    workshopName,
                    style: TextStyles.gray950FS18FW700TextStyle,
                  ),
                ),
              ],
            ),
            verticalSpace(10),
            FiveStarRating(
              rating: rating,
            ),
          ],
        ),
        verticalSpace(10),
        Row(
          children: [
            BlocListener<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is StartConversationsSuccessState) {
                  Navigator.pushNamed(
                    context,
                    RouteStrings.chatScreen,
                    arguments: {
                      "conversationsId":
                          int.parse(state.data!.data!.id.toString()),
                    },
                  );
                }
              },
              child: CircularIconButton(
                backgroundColor: AppColors.green300,
                size: 40,
                onPressed: () {
                  ChatCubit.get(context).startConversations(
                      startConversationsModel:
                          StartConversationsModel(workshopId: workshopId));
                },
                iconPath: "assets/icons/chat_icon.svg",
                iconColor: AppColors.whiteColor,
              ),
            ),
            // horizontalSpace(10),
            // CircularIconButton(
            //   backgroundColor: AppColors.blue300,
            //   onPressed: () {},
            //   iconPath: "assets/icons/directions_icon.svg",
            //   iconColor: AppColors.whiteColor,
            // ),
          ],
        ),
        verticalSpace(10),
        WorkshopLocation(
          location: address,
          icon: "location_icon.svg",
        ),
        verticalSpace(10),
        IconWithText(
          text: phone,
          icon: "phone_icon.svg",
        ),
        verticalSpace(10),
        ScheduleWidget(
          schedule: schedule,
          isOpen: isOpen,
        ),
        verticalSpace(10),
        IconForConnect(
          socialMediaData: socialMediaData,
        ),
        verticalSpace(15),
      ],
    );
  }
}

class ScheduleWidget extends StatelessWidget {
  final List<Schedule> schedule;
final IsOpen isOpen;
  const ScheduleWidget({required this.schedule,required this.isOpen, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sort the schedule by ID or day of the week if needed.
    final sortedSchedule = schedule..sort((a, b) => a.id!.compareTo(b.id!));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 10.w,
              height: 10.h,
              decoration:  BoxDecoration(
                color:isOpen.status==true? AppColors.green300:Colors.red,
                shape: BoxShape.circle,
              ),
            ),
            horizontalSpace(10),
            Text(
              isOpen.message!,
              style: TextStyles.gray800FS14FW500CairoTextStyle,
            ),
          ],
        ),
        verticalSpace(10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sortedSchedule.length,
          itemBuilder: (context, index) {
            final entry = sortedSchedule[index];
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h),
              child: Text(
                "${entry.dayWeek} من ${entry.openingTime} إلى ${entry.closingTime}",
                style: TextStyles.gray800FS14FW500CairoTextStyle,
              ),
            );
          },
        ),
      ],
    );
  }
}
