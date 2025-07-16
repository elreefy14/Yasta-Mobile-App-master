import 'package:flutter/material.dart';
import 'package:yasta/core/app_local/app_local.dart';
import '../../../../core/componant/user_image_widget.dart';
import '../../../../core/helper/spacing/spacing.dart';
import '../../../../core/route/route_strings/route_strings.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../preview_data_layout/presentation/screen/preview_data_layout.dart';
import '../../../preview_data_layout/presentation/widgets/preview_data_item.dart';

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PreviewDataLayout(
      appBarTitle: getLang(context, "Safety").toString(),
      children: [
        PreviewDataItem(
          editText: getLang(context, "Change password").toString(),
          updateTap: () {
            Navigator.pushNamed(context, RouteStrings.updatePasswordScreen);
          },
          title: getLang(context, "your password:").toString(),
          child: Text(
            "*************",
            style: TextStyles.gray800FS16FW500CairoTextStyle,
          ),
        ),
      ],
    );
  }
}
