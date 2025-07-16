import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/features/auth/logic/auth_cubit/auth_cubit.dart';

import '../../../../../../core/app_local/app_local.dart';
import '../../../../../../core/componant/custom_text_form_field_with_label.dart';
import '../../../../../../core/helper/spacing/spacing.dart';
import '../../../../../../core/theme/colors.dart';
import '../../../../../../core/theme/text_styles.dart';
import '../../../../../../core/di/dependency_injection.dart';

class SocialMediaWidget extends StatefulWidget {
  const SocialMediaWidget({super.key});

  @override
  State<SocialMediaWidget> createState() => _SocialMediaWidgetState();
}

class _SocialMediaWidgetState extends State<SocialMediaWidget> {

  void addSocialMediaLink() {
    setState(() {
      // Create a new controller for each new social media link
      TextEditingController newController = TextEditingController();

      // Add the controller to the list
      getIt<AuthCubit>().workshopSocialControllers.add(newController);

      // Add the text form field with a remove button to the social media links list
      getIt<AuthCubit>().socialMediaLinks.add(
        Column(
          key: ValueKey(newController), // Unique key for proper identification
          children: [
            verticalSpace(20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomTextFormFieldWithLabel(
                    label: getLang(context, "Social media").toString(),
                    hintText: getLang(context, "Add link here").toString(),
                    controller: newController,
                  ),
                ),
                // horizontalSpace(10),
                // Align(
                //   alignment: Alignment.center,
                //   child: IconButton(
                //     icon: const Icon(
                //       Icons.delete,
                //       color: Colors.red,
                //       size: 40,
                //     ),
                //     onPressed: () => removeSocialMediaLink(newController),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      );
    });
  }

  void removeSocialMediaLink(TextEditingController controller) {
    setState(() {
      // Find the index of the controller to remove
      int index = getIt<AuthCubit>().workshopSocialControllers.indexOf(
          controller);

      if (index != -1) {
        // Remove the controller and its associated widget
        getIt<AuthCubit>().workshopSocialControllers.removeAt(index);
        getIt<AuthCubit>().socialMediaLinks.removeAt(index);
      }
    });
  }

    @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: CustomTextFormFieldWithLabel(
                label: getLang(context, "Social media").toString(),
                hintText: getLang(context, "Add link here").toString(),
                controller: getIt<AuthCubit>().workshopSocialControllers[0],
              ),
            ),
            horizontalSpace(10),
            // IconButton(
            //   icon: const Icon(Icons.delete, color: Colors.red),
            //   onPressed: () => removeSocialMediaLink(getIt<AuthCubit>().workshopSocialControllers[0]),
            // ),
          ],
        ),
        ...getIt<AuthCubit>().socialMediaLinks,
        verticalSpace(30),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.gray100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.r),
              side: const BorderSide(
                color: Color(0xFF9CA3AF),
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 15.h,
            ),
          ),
          onPressed: addSocialMediaLink,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add,
                color: AppColors.gray600,
              ),
              horizontalSpace(10),
              Text(
                getLang(context, "Add another link").toString(),
                style: TextStyles.gray600FS14FW400CairoTextStyle,
              ),
            ],
          ),
        )
      ],
    );
  }
}
