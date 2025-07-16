import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/di/dependency_injection.dart';
import 'package:yasta/core/theme/colors.dart';
import '../../../../core/componant/error_bottom_sheet_widget.dart';
import '../../../../core/componant/phone_number_Input.dart';
import '../../../../core/helper/spacing/spacing.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../preview_data_layout/presentation/screen/preview_data_layout.dart';
import '../../../preview_data_layout/presentation/widgets/preview_data_update_item.dart';
import '../../data/models/update_phone_number_request_body.dart';
import '../../logic/user_profile_cubit.dart';
import 'verification_code_with_success_widget.dart';

class UpdatePhoneNumberScreen extends StatefulWidget {
  const UpdatePhoneNumberScreen({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  State<UpdatePhoneNumberScreen> createState() =>
      _UpdatePhoneNumberScreenState();
}

class _UpdatePhoneNumberScreenState extends State<UpdatePhoneNumberScreen> {
  TextEditingController phoneNumberController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    phoneNumberController.text = widget.phoneNumber;
    super.initState();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: PreviewDataLayout(
          appBarTitle:
              "${getLang(context, "Edit")} ${getLang(context, "Phone number")}",
          children: [
            PreviewDataUpdateItem(
              onSavedPressed: () {
                // Show BottomSheet on save
                getIt<UserProfileCubit>().updatePhoneNumber(
                  updatePhoneNumberRequestBody: UpdatePhoneNumberRequestBody(
                    phone: phoneNumberController.text,
                  ),
                );
              },
              onCancelPressed: () {
                Navigator.pop(context);
              },
              children: [
                Text(
                  getLang(context, "Edit phone number").toString(),
                  style: TextStyles.gray900FS16FW500CairoTextStyle,
                ),
                verticalSpace(30),
                PhoneNumberInput(
                  controller: phoneNumberController,
                  onPhoneCodeChanged: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return getLang(context, "Please enter phone number");
                    } else if (value.length != 11) {
                      return getLang(
                          context, "Please enter valid phone number");
                    }
                    return null;
                  },
                ),
                BlocListener<UserProfileCubit, UserProfileState>(
                  listener: (context, state) {
                    if (state is UpdatePhoneNumberSuccessState) {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        backgroundColor: AppColors.whiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(45.0.r)),
                        ),
                        builder: (context) => BlocProvider.value(
                          value: getIt<UserProfileCubit>(),
                          child: VerificationCodeWithSuccessWidget(
                            phoneNumber: phoneNumberController.text,
                          ),
                        ),
                      );
                    } else if (state is UpdatePhoneNumberErrorState) {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(45.0.r)),
                        ),
                        builder: (context) => ErrorBottomSheetWidget(
                          errorText: state.message.toString(),
                        ),
                      );
                    }
                  },
                  child: const SizedBox.shrink(),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
