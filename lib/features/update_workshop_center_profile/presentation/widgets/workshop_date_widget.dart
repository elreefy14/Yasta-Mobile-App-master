import 'dart:io';
import 'package:yasta/features/auth/widgets/mandatory_text.dart';
import 'package:yasta/features/update_workshop_center_profile/data/logic/update_center_cubit.dart';

import '../../../../../../core/di/dependency_injection.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yasta/features/auth/logic/auth_cubit/auth_cubit.dart';
import 'package:yasta/features/auth/service_provider_screens/sign_up_screen/logic/select_location_map_cubit.dart';
import '../../../../../../core/app_local/app_local.dart';
import '../../../../../../core/componant/custom_text_form_field_with_label.dart';
import '../../../../../../core/componant/dashed_border_container.dart';
import '../../../../../../core/componant/phone_number_Input.dart';
import '../../../../../../core/componant/text_form_field_with_mandatory_label.dart';
import '../../../../../../core/helper/spacing/spacing.dart';
import '../../../../../../core/route/route_strings/route_strings.dart';
import '../../../../../../core/theme/text_styles.dart';


class WorkshopDateWidget extends StatefulWidget {
  WorkshopDateWidget(
      {super.key,
        this.isMandatory,
        this.selectLocationMapCubit,
        this.selectedDestination});

  final bool? isMandatory;

  final SelectLocationMapCubit? selectLocationMapCubit;
  LatLng? selectedDestination;

  @override
  State<WorkshopDateWidget> createState() => _WorkshopDateWidgetState();
}

class _WorkshopDateWidgetState extends State<WorkshopDateWidget> {
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        getIt<UpdateCenterCubit>().selectedLogo = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.isMandatory == null
            ? TextFormFieldWithMandatoryLabel(
          label: getLang(context, "Workshop name").toString(),
          hintText:
          getLang(context, "Please enter your place name").toString(),
          controller: getIt<UpdateCenterCubit>().WorkshopNameController,
          validator: (value) {
            if (value!.isEmpty) {
              return getLang(context, "Please enter your place name").toString();
            }
            return null;
          },
        )
            : CustomTextFormFieldWithLabel(
          label: getLang(context, "Workshop name").toString(),
          hintText:
          getLang(context, "Please enter your place name").toString(),
          controller: getIt<UpdateCenterCubit>().WorkshopNameController,
          validator: (value) {
            if (value!.isEmpty) {
              return getLang(context, "Please enter your place name").toString();
            }
            return null;
          },
        ),
        verticalSpace(40),
        widget.isMandatory == null
            ? MandatoryText(
          label: getLang(context, "logo").toString(),
        )
            : const SizedBox.shrink(),
        widget.isMandatory == null ? verticalSpace(8) : const SizedBox.shrink(),
        widget.isMandatory == null
            ? InkWell(
          onTap: () async {
            await _pickImage();
          },
          child: getIt<UpdateCenterCubit>().selectedLogo == null
              ? DashedBorderContainer(
            width: MediaQuery.of(context).size.width,
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.black,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/image/upload.svg",
                    width: 80.w,
                    height: 40.h,
                  ),
                  verticalSpace(5),
                  Text(
                    getLang(context, "Upload image here")
                        .toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                    TextStyles.gray600FS14FW400CairoTextStyle,
                  ),
                ],
              ),
            ),
          )
              : Image.file(
            getIt<UpdateCenterCubit>().selectedLogo!,
            width: 100.w,
            height: 100.h,
            fit: BoxFit.cover,
          ),
        )
            : const SizedBox.shrink(),
        widget.isMandatory == null
            ? verticalSpace(40)
            : const SizedBox.shrink(),
        widget.isMandatory == null
            ? TextFormFieldWithMandatoryLabel(
          label: getLang(context, "Address").toString(),
          hintText:
          getLang(context, "Please enter your address").toString(),
          controller: getIt<UpdateCenterCubit>().WorkshopAddressController,
          validator: (value) {
            if (value!.isEmpty) {
              return getLang(context, "Please enter your address").toString();
            }
            return null;
          },
        )
            : CustomTextFormFieldWithLabel(
          label: getLang(context, "Address").toString(),
          hintText:
          getLang(context, "Please enter your address").toString(),
          controller: getIt<UpdateCenterCubit>().WorkshopAddressController,
          validator: (value) {
            if (value!.isEmpty) {
              return getLang(context, "Please enter your address").toString();
            }
            return null;
          },
        ),
        verticalSpace(20),
        widget.selectLocationMapCubit == null
            ? const SizedBox.shrink()
            : InkWell(
          onTap: () async {
            final selectedDestination = await Navigator.pushNamed(
              context,
              RouteStrings.selectLocationMapScreen,
              arguments: {
                "selectLocationMapCubit":
                SelectLocationMapCubit.get(context),
                "selectedDestination":
                getIt<UpdateCenterCubit>().selectedDestination,
              },
            );

            if (selectedDestination != null &&
                selectedDestination is LatLng) {
              setState(() {
                getIt<UpdateCenterCubit>().selectedDestination =
                    selectedDestination;
              });
              print("Selected Destination: $selectedDestination");
            }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/icons/location_icon.svg",
                  color: Colors.black),
              horizontalSpace(5),
              Expanded(
                child: Text(
                  getLang(context, "Select Location on the map")
                      .toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style:
                  TextStyles.gray950FS16FW600CairoTextStyle.copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
        verticalSpace(40),
        PhoneNumberInput(
          controller: getIt<UpdateCenterCubit>().WorkshopphoneNumberController,
          onPhoneCodeChanged: getIt<AuthCubit>().onPhoneCodeChanged,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return getLang(context, "Please enter phone number");
            }
            else if (value.length != 11) {
              return getLang(context, "Please enter valid phone number");
            }
            return null;
          },
        ),
        verticalSpace(40),
        CustomTextFormFieldWithLabel(
          label: getLang(context, "Description").toString(),
          hintText: getLang(
              context, "Add a short and clear description of your services")
              .toString(),
          controller: getIt<UpdateCenterCubit>().WorkshopDescriptionController,
          minLines: 5,
          validator: (value) {
            if (value!.isEmpty) {
              return getLang(context, "Add a short and clear description of your services").toString();
            }
            return null;
          },
        ),
      ],
    );
  }
}
