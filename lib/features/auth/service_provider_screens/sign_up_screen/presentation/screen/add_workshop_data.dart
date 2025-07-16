import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yasta/core/app_cubit/app_cubit.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';
import 'package:yasta/features/auth/auth_layput_screen.dart';
import 'package:yasta/features/auth/data/models/add_models.dart';
import 'package:yasta/features/auth/data/models/add_services_model.dart';
import 'package:yasta/features/auth/data/models/add_socials_model.dart';
import 'package:yasta/features/auth/logic/auth_cubit/auth_cubit.dart';
import 'package:yasta/features/auth/service_provider_screens/sign_up_screen/presentation/widgets/loading_widget.dart';
import '../../../../../../core/app_local/app_local.dart';
import '../../../../../../core/componant/default_button.dart';
import '../../../../../../core/helper/cache_helper/cache_helper.dart';
import '../../../../../../core/route/route_strings/route_strings.dart';
import '../../../../data/models/add_workshop_model.dart';
import '../../../../data/models/schedule_model.dart';
import '../../../../data/models/workshop_schedules_request_body.dart';
import '../../logic/select_location_map_cubit.dart';
import '../widgets/appointments_widget.dart';
import '../widgets/available_brand_widget.dart';
import '../widgets/header_widget.dart';
import '../widgets/photo_album.dart';
import '../widgets/social_media_widget.dart';
import '../widgets/workshop_details_widget.dart';
import '../../../../../../core/di/dependency_injection.dart';

class AddWorkshopData extends StatefulWidget {
  const AddWorkshopData({super.key});

  @override
  State<AddWorkshopData> createState() => _AddWorkshopDataState();
}

class _AddWorkshopDataState extends State<AddWorkshopData> {
  @override
  void initState() {
    // TODO: implement initState
    debugPrint(getIt<AuthCubit>().selectedDestination.toString());
    super.initState();
  }
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      children: [
        HeaderWidget1(
          headerTitle:
              getLang(context, "Sign up as service provider").toString(),
          title: getLang(context,
                  "Record all your business details, expand your business, and make more profits")
              .toString(),
          greenIndicators: 0, // Number of green indicators
          totalIndicators: 4, // Optional, defaults to 5
        ),
        verticalSpace(40),
        WorkshopDetailsWidget(
          selectLocationMapCubit: SelectLocationMapCubit(),
          selectedDestination: getIt<AuthCubit>().selectedDestination,
        ),
        verticalSpace(30),
        const Divider(),
        PhotoAlbum(),
        verticalSpace(40),
        const Divider(),
        DefaultButton(
          label: getLang(context, "Save data").toString(),
          onPressed: () {
            print(getIt<AuthCubit>().selectedDestination);
            print(getIt<AuthCubit>().selectedLogo!);
            print(getIt<AuthCubit>().selectedImages);
            print(getIt<AuthCubit>().selectedDestination);
            print(getIt<AuthCubit>().WorkshopNameController.text);
            print("ddddddddddddd");
            print(  getIt<AuthCubit>().selectedDestination != null &&
                getIt<AuthCubit>().selectedLogo != null &&
                getIt<AuthCubit>().selectedImages.isNotEmpty &&
                getIt<AuthCubit>().WorkshopNameController.text.isNotEmpty &&
                getIt<AuthCubit>().WorkshopAddressController.text.isNotEmpty &&
                getIt<AuthCubit>()
                    .WorkshopphoneNumberController
                    .text
                    .isNotEmpty &&
                getIt<AuthCubit>()
                    .WorkshopDescriptionController
                    .text
                    .isNotEmpty);

            if (getIt<AuthCubit>()
                .WorkshopNameController
                .text
                .isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      getLang(context, "Please enter your place name")
                          .toString()),
                ),
              );
            }
            if (getIt<AuthCubit>()
                .WorkshopDescriptionController
                .text
                .isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(getLang(context,
                      "Add a short and clear description of your services")
                      .toString()),
                ),
              );
            }
            if (getIt<AuthCubit>()
                .WorkshopAddressController
                .text
                .isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      getLang(context, "Please enter your address")
                          .toString()),
                ),
              );
            }
            if (getIt<AuthCubit>()
                .WorkshopphoneNumberController
                .text
                .isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      getLang(context, "Please enter phone number")
                          .toString()),
                ),
              );
            }
            if (getIt<AuthCubit>().selectedImages.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      getLang(context, "Photo Album is required").toString()),
                ),
              );
            }
            if (getIt<AuthCubit>().selectedLogo == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text(getLang(context, "logo is required").toString()),
                ),
              );
            }
            if (getIt<AuthCubit>().selectedDestination == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      getLang(context, "Destination is required").toString()),
                ),
              );
            }
            if (
            getIt<AuthCubit>().selectedDestination != null &&
                getIt<AuthCubit>().selectedLogo != null &&
                getIt<AuthCubit>().selectedImages.isNotEmpty &&
                getIt<AuthCubit>().WorkshopNameController.text.trim().isNotEmpty &&
                getIt<AuthCubit>().WorkshopAddressController.text.trim().isNotEmpty &&
                getIt<AuthCubit>()
                    .WorkshopphoneNumberController
                    .text.trim()
                    .isNotEmpty &&
                getIt<AuthCubit>()
                    .WorkshopDescriptionController
                    .text.trim()
                    .isNotEmpty
                ) {
              getIt<AuthCubit>().addWorkshop(
                workshop: Workshop(
                  name: getIt<AuthCubit>().WorkshopNameController.text,
                  description: getIt<AuthCubit>().WorkshopDescriptionController.text,
                  imageFile: getIt<AuthCubit>().selectedLogo!,
                  address: getIt<AuthCubit>().WorkshopAddressController.text,
                  phone: getIt<AuthCubit>().WorkshopphoneNumberController.text,
                  images: getIt<AuthCubit>().selectedImages,
                  latitude: getIt<AuthCubit>()
                      .selectedDestination!
                      .latitude
                      .toString(),
                  longitude: getIt<AuthCubit>()
                      .selectedDestination!
                      .longitude
                      .toString(),
                ),
              );
            }
            if (
            getIt<AuthCubit>().WorkshopNameController.text.isEmpty ||
                getIt<AuthCubit>().WorkshopAddressController.text.isEmpty ||
                getIt<AuthCubit>()
                    .WorkshopphoneNumberController
                    .text
                    .isEmpty ||
                getIt<AuthCubit>()
                    .WorkshopDescriptionController
                    .text
                    .isEmpty
                ) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      getLang(context, "All Data is required").toString()),
                ),
              );
            }
          },
        ),
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AddWorkshopSuccessState) {
              print(state.data!.data?.workshop_id);
              CacheHelper.saveData(
                      key: "workshop_id",
                      value: state.data!.data?.workshop_id ?? "")
                  .then((_) {
                CacheHelper.saveData(
                    key: "stage",
                    value:  "2");
              }).then((_) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteStrings.addServiceAndModel,
                      (Route<dynamic> route) => false,
                );
              });
            }
            if (state is AddWorkshopErrorState) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
            if (state is AddWorkshopLoadingState) {
              showLoadingDialog(context);
            }
          },
          child: const SizedBox.shrink(),
        ),
        verticalSpace(40),
      ],
    );
  }
}
