import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/componant/custom_text_form_field_with_label.dart';
import 'package:yasta/core/componant/edit_user_image_widget.dart';
import 'package:yasta/features/user_profile_screen/data/models/update_username_request_body.dart';
import '../../../../core/componant/error_bottom_sheet_widget.dart';
import '../../../../core/componant/success_bottom_sheet_widget.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/helper/cache_helper/cache_helper.dart';
import '../../../../core/helper/spacing/spacing.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../preview_data_layout/presentation/screen/preview_data_layout.dart';
import '../../../preview_data_layout/presentation/widgets/preview_data_update_item.dart';
import '../../logic/user_profile_cubit.dart';

class UpdatePersonalInformationScreen extends StatefulWidget {
  const UpdatePersonalInformationScreen({super.key, required this.userName});

  final String userName;

  @override
  State<UpdatePersonalInformationScreen> createState() =>
      _UpdatePersonalInformationScreenState();
}

class _UpdatePersonalInformationScreenState
    extends State<UpdatePersonalInformationScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  // final userProfileCubit = getIt<UserProfileCubit>();

  @override
  void initState() {
    // TODO: implement initState
    firstNameController.text = widget.userName.split(" ")[0];
    lastNameController.text = widget.userName.split(" ")[1];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PreviewDataLayout(
      appBarTitle:
          "${getLang(context, "Edit")} ${getLang(context, "personal data")}",
      children: [
        PreviewDataUpdateItem(
          onSavedPressed: () {
            // Show BottomSheet on save
            print(getIt<UserProfileCubit>().image);

            if(firstNameController.text.isEmpty){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      getLang(context, "Enter your first name").toString()),
                ),
              );
            }   if(lastNameController.text.isEmpty){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      getLang(context, "Enter your last name").toString()),
                ),
              );
            }
            if(lastNameController.text.isNotEmpty &&firstNameController.text.isNotEmpty ){
            getIt<UserProfileCubit>().updateUserNameWithImage(
              updateUsernameRequestBody:  UpdateUsernameRequestBody(
                firstName: firstNameController.text,
                lastName: lastNameController.text,
                imageFile: getIt<UserProfileCubit>().image,
              ),
              // updateUsernameRequestBody: getIt<UserProfileCubit>().image == null
              //     ? UpdateUsernameRequestBody(
              //         firstName: firstNameController.text,
              //         lastName: lastNameController.text,
              //         // imageFile: getIt<UserProfileCubit>().image,
              //       )
              //     : UpdateUsernameRequestBody(
              //         firstName: firstNameController.text,
              //         lastName: lastNameController.text,
              //         imageFile: getIt<UserProfileCubit>().image,
              //       ),
            );
          }},
          onCancelPressed: () {
            Navigator.pop(context);
          },
          children: [
            Text(
              getLang(context, "My personal data").toString(),
              style: TextStyles.gray900FS16FW500CairoTextStyle,
            ),
            verticalSpace(30),
            EditUserImageWidget(
              imageUrl: CacheHelper.getdata(key: "userImage").toString(),
            ),
            verticalSpace(20),
            CustomTextFormFieldWithLabel(
              label: getLang(context, "first name").toString(),
              hintText: "",
              controller: firstNameController,
            ),
            verticalSpace(20),
            CustomTextFormFieldWithLabel(
              label: getLang(context, "last name").toString(),
              hintText: "",
              controller: lastNameController,
            ),
            BlocListener<UserProfileCubit, UserProfileState>(
              listener: (context, state) {
                if (state is UpdateUsernameSuccessState) {
                  CacheHelper.saveData(
                    key: "userName",
                    value:
                        "${firstNameController.text} ${lastNameController.text}",
                  );
                  CacheHelper.saveData(
                    key: "userImage",
                    value: state.data.data!.image,
                  );
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(45.0.r)),
                    ),
                    builder: (context) {
                      return SuccessBottomSheetWidget(
                        successText: getLang(context,
                                "Your profile has been updated successfully.")
                            .toString(),
                      );
                    },
                  ).then((_){
                    Navigator.pop(context);
                  });
                } else if (state is UpdateUsernameErrorState) {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(45.0.r)),
                    ),
                    builder: (context) => ErrorBottomSheetWidget(
                      errorText: state.message.toString(),
                    ),
                  );
                }
              },
              child: const SizedBox.shrink(),
            ),
          ],
        ),
      ],
    );
  }
}
