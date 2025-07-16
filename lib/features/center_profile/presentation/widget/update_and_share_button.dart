import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:yasta/core/route/route_strings/route_strings.dart';
import 'package:yasta/features/center_profile/data/models/show_workshop_data_response.dart';
import 'package:yasta/features/center_profile/data/models/show_workshop_models_response.dart';
import 'package:yasta/features/center_profile/data/models/show_workshop_schedules_response.dart';
import 'package:yasta/features/center_profile/data/models/show_workshop_services_response.dart';
import 'package:yasta/features/center_profile/data/models/show_workshop_socials_response.dart';
import 'package:yasta/features/workshop_profile/model/get_workshop_byId_response.dart';
import '../../../../core/theme/text_styles.dart';

class UpdateAndShareButton extends StatelessWidget {
   UpdateAndShareButton({super.key, required this.workshopId,required this.showWorkshopDataResponse});
  final int workshopId ;
 final  GetWorkshopByIdResponse showWorkshopDataResponse;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Expanded(
        //   child: OutlinedButton(
        //     style: OutlinedButton.styleFrom(
        //       backgroundColor: const Color(0xFFF9FAFB), // Light background color
        //       foregroundColor: Colors.black, // Text color
        //       side: const BorderSide(color: Colors.grey), // Border color
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(8), // Rounded corners
        //       ),
        //     ),
        //     onPressed: () {
        //       Navigator.pushNamed(
        //         context,
        //         RouteStrings.updateWorkshopCenterProfile,
        //         arguments: showWorkshopDataResponse,
        //
        //       );
        //     },
        //     child: Row(
        //       children: [
        //         SvgPicture.asset("assets/icons/editIcon.svg"),
        //         horizontalSpace(5.w),
        //         Expanded(
        //           child: Text(
        //             getLang(context, "Update Data").toString(),
        //             maxLines: 1,
        //             overflow: TextOverflow.ellipsis,
        //             style: TextStyles.gray950FS14FW600CairoTextStyle,
        //           ),
        //         ),
        //       ],
        //     ), // Replace with desired text
        //   ),
        // ),
        // horizontalSpace(10), // Space between buttons
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.green, // Light background color
              foregroundColor: Colors.green, // Text color
              side: const BorderSide(color: Colors.green), // Border color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Rounded corners
              ),
            ),
            onPressed: () {
              // Generate the link to the workshop profile screen
              final link = 'https://yasta.megatron-soft.com/share/workshops/$workshopId';
              Share.share(link);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min, // Ensure the row size matches its content
              mainAxisAlignment: MainAxisAlignment.center, // Center content horizontally
              crossAxisAlignment: CrossAxisAlignment.center, // Center content vertically
              children: [
                SvgPicture.asset(
                  "assets/icons/share.svg",
                  height: 20, // Set icon size for proper alignment
                  width: 20,
                ),
                SizedBox(width: 8), // Space between the icon and text
                Text(
                  getLang(context, "Share My Profile").toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.gray500FS14FW400CairoTextStyle
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),

      ],
    );
  }
}
