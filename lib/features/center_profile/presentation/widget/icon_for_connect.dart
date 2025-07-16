
import 'package:flutter/material.dart';
 import 'package:url_launcher/url_launcher.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/componant/circular_icon_button.dart';
import 'package:yasta/core/di/dependency_injection.dart';
import 'package:yasta/core/theme/text_styles.dart';
import 'package:yasta/features/update_workshop_center_profile/data/logic/update_center_cubit.dart';

import '../../../../core/helper/spacing/spacing.dart';
import '../../../../core/theme/colors.dart';
class IconForConnect extends StatefulWidget {
  final List<dynamic> socialMediaData; // Accept the data as a parameter

  const IconForConnect({super.key, required this.socialMediaData});

  @override
  State<IconForConnect> createState() => _IconForConnectState();
}

class _IconForConnectState extends State<IconForConnect> {
 @override
  void initState() {
    // TODO: implement initState
   getIt<UpdateCenterCubit>().socialMediaLink.clear();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getLang(context, "Social Media Link :").toString(),
          style: TextStyles.gray950FS18FW500TextStyle,
        ),
        Row(

          children: widget.socialMediaData.map((social) {
            String iconPath;
            getIt<UpdateCenterCubit>().socialMediaLink.add(social.url!);
            // Assign icon paths based on the platform
            switch (social.platform?.toLowerCase()) {
              case 'facebook':
                iconPath = "assets/icons/facebook_icon.svg";
                break;
              case 'twitter':
                iconPath = "assets/icons/twitter_icon.svg";
                break;
              case 'instagram':
                iconPath = "assets/icons/instagram_icon.svg";
                break;
              case 'youtube':
                iconPath = "assets/icons/youtube_icon.svg";
                break;
                case null:
                iconPath = "assets/icons/default_icon.svg";
                break;
              default:
                iconPath = "assets/icons/default_icon.svg";
                break;
            }
            return Row(
              children: [

                CircularIconButton(
                  backgroundColor: AppColors.gray100,
                  onPressed: () {
                    // Open the URL for the respective platform
                    if (social.url != null) {
                      _launchURL( context,social.url!);
                    }
                  },
                  iconPath: iconPath,
                  iconColor: AppColors.blackColor,
                ),
                horizontalSpace(15),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  // Future<void> _launchURL(String url) async {
  void _launchURL(BuildContext context, String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw Exception('Cannot launch $url');
      }
    } catch (e, stackTrace) {
      debugPrint('Error launching URL: $url\n$e\n$stackTrace');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to open URL: $e')),
      );
    }
  }
}
