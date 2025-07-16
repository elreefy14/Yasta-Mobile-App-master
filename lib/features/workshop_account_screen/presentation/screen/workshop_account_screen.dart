import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/componant/profile_item_widget.dart';
import 'package:yasta/core/constants/constants.dart';
import 'package:yasta/core/helper/cache_helper/cache_helper.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';
import 'package:yasta/features/auth/logic/auth_cubit/auth_cubit.dart';
import 'package:yasta/features/user_profile_screen/logic/user_profile_cubit.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/route/route_strings/route_strings.dart';
import '../../../logout/presentation/logout_widget.dart';
import '../../../my_account_screen/presentation/widgets/user_image_with_name_widget.dart';

class WorkshopAccountScreen extends StatelessWidget {
  const WorkshopAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Constants.hPadding),
        child: ListView(
          children: [
            verticalSpace(MediaQuery.of(context).size.height * 0.1),
            BlocBuilder<UserProfileCubit, UserProfileState>(
              builder: (context, state) {
                return UserImageWithNameWidget(
                  userName: CacheHelper.getdata(key: "userName").toString(),
                  imagePath: CacheHelper.getdata(key: "userImage").toString(),
                );
              },
            ),
            verticalSpace(20),
            ProfileItemWidget(
              text: getLang(context, "Center Profile").toString(),
              image: "assets/icons/center_profile.svg",
              onTap: () {
                 Navigator.pushNamed(context, RouteStrings.centerProfile);
              },
            ),
            const Divider(),
            ProfileItemWidget(
              text: getLang(context, "personal data").toString(),
              image: "assets/icons/person.svg",
              onTap: () {
                Navigator.pushNamed(context, RouteStrings.userProfileScreen);
              },
            ),
            const Divider(),
            ProfileItemWidget(
              text: getLang(context, "Messages").toString(),
              image: "assets/icons/message.svg",
              onTap: () {
                Navigator.pushNamed(context, RouteStrings.messagesScreen);
              },
            ),
            // const Divider(),
            // ProfileItemWidget(
            //   text: getLang(context, "Packages").toString(),
            //   image: "assets/icons/packages.svg",
            //   onTap: () {
            //     // Navigator.pushNamed(context, RouteStrings.userProfileScreen);
            //   },
            // ),
            // const Divider(),
            // ProfileItemWidget(
            //   text: getLang(context, "Payment Methods").toString(),
            //   image: "assets/icons/payment_methods.svg",
            //   onTap: () {
            //     Navigator.pushNamed(context, RouteStrings.paymentMethodScreen);
            //   },
            // ),
            const Divider(),
            ProfileItemWidget(
              text: getLang(context, "Ratings").toString(),
              image: "assets/icons/ratings.svg",
              onTap: () {
                Navigator.pushNamed(context, RouteStrings.workshopFeedbacksScreen);
              },
            ),
            const Divider(),
            ProfileItemWidget(
              text: getLang(context, "my car").toString(),
              image: "assets/icons/car.svg",
              onTap: () {
                Navigator.pushNamed(context, RouteStrings.userCarScreen);
              },
            ),
            const Divider(),
            ProfileItemWidget(
              text: getLang(context, "Favorites").toString(),
              image: "assets/icons/heart.svg",
              onTap: () {
                Navigator.pushNamed(context, RouteStrings.favouriteScreen);
              },
            ),
            const Divider(),
            ProfileItemWidget(
              text: getLang(context, "Safety").toString(),
              image: "assets/icons/safe.svg",
              onTap: () {
                Navigator.pushNamed(context, RouteStrings.securityScreen);
              },
            ),
            const Divider(),
            ProfileItemWidget(
              text: getLang(context, "Logout").toString(),
              image: "assets/icons/logout.svg",
              onTap: () {
                showDialog(context: context, builder: (context) {
                  return BlocProvider.value(
                    value: getIt<AuthCubit>(),
                    child: const LogoutWidget(),
                  );
                },);
              },
            ),
          ],
        ),
      ),
    );
  }
}
