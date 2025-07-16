import 'package:flutter/material.dart';
import 'package:yasta/core/app_local/app_local.dart';
import '../../../../core/componant/empty_state_screen.dart';
import '../../../../core/route/route_strings/route_strings.dart';

class MyAccountNotRegisteredScreen extends StatelessWidget {
  const MyAccountNotRegisteredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyStateScreen(
      buttonText: getLang(context, "Login").toString(),
      message:
          getLang(context, "You have not logged in yet. Click here to login.")
              .toString(),
      onButtonPressed: () {
        Navigator.pushReplacementNamed(context, RouteStrings.loginScreen);
      },
      lottieAnimation: 'assets/lottie/sad_face.json',
    );
  }
}
