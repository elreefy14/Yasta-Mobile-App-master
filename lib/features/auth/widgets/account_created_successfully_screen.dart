import 'package:flutter/material.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/helper/cache_helper/cache_helper.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';
import 'package:yasta/core/theme/text_styles.dart';
import 'package:yasta/features/auth/auth_layput_screen.dart';
import 'package:lottie/lottie.dart';

import '../../../core/route/route_strings/route_strings.dart';

class AccountCreatedSuccessfullyScreen extends StatelessWidget {
  const AccountCreatedSuccessfullyScreen(
      {super.key, required this.isGuest, required this.isUser});

  final bool isGuest;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 5),
      () {
        // CacheHelper.saveData(key: 'isLogin', value: true).then((value) {
        //   Navigator.pushReplacementNamed(context, RouteStrings.homeLayoutScreen);
        // });
        Navigator.pushNamedAndRemoveUntil(
          context,
          RouteStrings.homeLayoutScreen,
              (Route<dynamic> route) => false,
          arguments: {
            "isGuest": isGuest,
            "isUser": isUser,
          },
        );
      },
    );
    return AuthLayout(
      children: [
        verticalSpace(MediaQuery.of(context).size.height * 0.1),
        Lottie.asset('assets/lottie/success.json'),
        Center(
          child: Text(
            getLang(context, "Your account is now ready! Let's get started!")
                .toString(),
            textAlign: TextAlign.center,
            style: TextStyles.gray950FS18FW500TextStyle,
          ),
        ),
      ],
    );
  }
}
