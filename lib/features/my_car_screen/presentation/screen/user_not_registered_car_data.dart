import 'package:flutter/material.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/route/route_strings/route_strings.dart';
import '../../../../core/componant/custom_app_bar.dart';
import '../../../../core/componant/empty_state_screen.dart';
import '../../../../core/theme/colors.dart';

class UserNotRegisteredCarData extends StatelessWidget {
  const UserNotRegisteredCarData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: getLang(context, "car data").toString(),
      ),
      body: EmptyStateScreen(
        backgroundColor: AppColors.gray100,
        buttonText: getLang(context, "Add your car").toString(),
        message: getLang(context, "Your car details have not been entered yet.")
            .toString(),
        onButtonPressed: () {
          Navigator.pushNamed(context, RouteStrings.addCarDataScreen);
        },
        lottieAnimation: 'assets/lottie/not_found.json',
      ),
    );
  }
}
