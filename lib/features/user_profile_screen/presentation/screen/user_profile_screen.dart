import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/di/dependency_injection.dart';
import 'package:yasta/core/helper/cache_helper/cache_helper.dart';
import '../../../../core/componant/success_bottom_sheet_widget.dart';
import '../../../../core/componant/user_image_widget.dart';
import '../../../../core/helper/spacing/spacing.dart';
import '../../../../core/route/route_strings/route_strings.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../preview_data_layout/presentation/screen/preview_data_layout.dart';
import '../../../preview_data_layout/presentation/widgets/preview_data_item.dart';
import '../../logic/user_profile_cubit.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PreviewDataLayout(
      appBarTitle: getLang(context, "personal data").toString(),
      children: [
        BlocBuilder<UserProfileCubit, UserProfileState>(
          builder: (context, state) {
            return PreviewDataItem(
              updateTap: () {
                Navigator.pushNamed(
                  context,
                  RouteStrings.updatePersonalInformationScreen,
                  arguments: {
                    "userName": CacheHelper.getdata(key: "userName").toString(),
                  },
                );
              },
              title: getLang(context, "My personal data").toString(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserImageWidget(
                    imageUrl: CacheHelper.getdata(key: "userImage")
                        .toString(),
                    radius: 40.r,
                  ),
                  verticalSpace(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getLang(context, "Name").toString(),
                        style: TextStyles.gray500FS12FW500CairoTextStyle,
                      ),
                      verticalSpace(5),
                      Text(
                        CacheHelper.getdata(key: "userName").toString(),
                        style: TextStyles.gray800FS16FW500CairoTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        BlocBuilder<UserProfileCubit, UserProfileState>(
          builder: (context, state) {
            return PreviewDataItem(
              updateTap: () {
                Navigator.pushNamed(
                  context,
                  RouteStrings.updatePhoneNumberScreen,
                  arguments: {
                    "phoneNumber": CacheHelper.getdata(key: "phone").toString(),
                  },
                );
              },
              title: getLang(context, "Phone number").toString(),
              child: Text(
                CacheHelper.getdata(key: "phone").toString(),
                style: TextStyles.gray800FS14FW500CairoTextStyle,
              ),
            );
          },
        ),
      ],
    );
  }
}
