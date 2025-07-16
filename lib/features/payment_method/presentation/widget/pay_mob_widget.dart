import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app_local/app_local.dart';
import '../../../../core/theme/text_styles.dart';

class PayMobWidget extends StatelessWidget {
  const PayMobWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset("assets/image/Ellipse 34.svg"),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            getLang(context,
                    "Pay with ease and security. Enjoy paying via e-wallets and credit cards.")
                .toString(),
            style: TextStyles.gray800FS16FW500CairoTextStyle,
          ),
        ),
      ],
    );
  }
}
