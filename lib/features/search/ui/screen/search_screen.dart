import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'package:location/location.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/componant/componant.dart';
import 'package:yasta/core/componant/custom_app_bar.dart';
import 'package:yasta/core/componant/custom_multi_select_dropdown_field.dart';
import 'package:yasta/core/componant/custom_text_form_field_with_label.dart';
import 'package:yasta/core/di/dependency_injection.dart';
import 'package:yasta/core/helper/app_color/app_color.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';
import 'package:yasta/core/theme/text_styles.dart';
import 'package:yasta/features/auth/service_provider_screens/sign_up_screen/logic/select_location_map_cubit.dart';
import 'package:yasta/features/search/logic/search_cubit.dart';
import 'package:yasta/features/search/ui/widget/container_widget.dart';
import 'package:yasta/features/my_car_screen/logic/model/show_car_model.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/componant/custom_dropdown_field_with_label.dart';
import '../../../../core/helper/cache_helper/cache_helper.dart';
import '../../../../core/route/route_strings/route_strings.dart';
import '../../../../core/theme/colors.dart';
import '../../../auth/logic/auth_cubit/auth_cubit.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController serviceTypeController = TextEditingController();
  TextEditingController brandTypeController = TextEditingController();
  TextEditingController locationTypeController = TextEditingController();
  bool useRegisteredCar = false;
  bool addNewCar = false;
  bool useCurrentLocation = false;
  bool addLocationManually = false;
  bool now = false;
  bool chooseAnotherTime = false;

  TimeOfDay? _selectedTime;

  @override
  void initState() {
    // TODO: implement initState
    if (CacheHelper.getdata(key: "token").toString() != "null") {
      getIt<AuthCubit>().getAllModels();
      SearchCubit.get(context).showAllCar();
      getIt<AuthCubit>().getServices();
    } else {
      getIt<AuthCubit>().getServices();
    }

    super.initState();
  }

  List<Data> carResponse = [];

  // Function to show the time picker dialog
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: CacheHelper.getdata(key: "lang") == "en"
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ColorsManager.gray100,
          appBar: CustomAppBar(
            title: getLang(context, "Find the service you need").toString(),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 32.h),
            child: ListView(
              children: [
                // ContainerWidget(children: [
                //   CustomDropdownField(
                //     items: getIt<AuthCubit>().typeSearch,
                //     onChanged: (String? value) {
                //       // Find the map entry that matches the selected name
                //       // Set the selected brand value and call getModels with the brand id
                //       getIt<AuthCubit>().searchTypeValue = value;
                //       print(getIt<AuthCubit>().searchTypeValue);
                //     },
                //     label: "نوع البحث",
                //     hintText: "Map",
                //     value: getIt<AuthCubit>().searchTypeValue,
                //   )
                // ]),
                ContainerWidget(children: [
                  CustomTextFormFieldWithLabel(
                    label: getLang(context, "Search").toString(),
                    hintText: getLang(context, "Please enter Workshop name")
                        .toString(),
                    controller: getIt<AuthCubit>().searchKeyController,
                  ),
                ]),
                ContainerWidget(
                  children: [
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is GetServicesSuccessState) {
                          getIt<AuthCubit>().workshopServices = state
                              .data!.data!
                              .map((e) =>
                                  {'name': e.name!, 'id': e.id.toString()})
                              .toList();
                        }
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        return CustomMultiSelectDropdownField<String>(
                          label: getLang(context, "Services").toString(),
                          hintText: getLang(context, "Choose your service")
                              .toString(),
                          selectedValues:
                              getIt<AuthCubit>().selectedWorkshopServices,
                          items: getIt<AuthCubit>()
                              .workshopServices
                              .map((item) => item['name']!)
                              .toList(),
                          onChanged: (selectedItems) {
                            getIt<AuthCubit>().workshopServicesList =
                                getIt<AuthCubit>()
                                    .workshopServices
                                    .where((item) => selectedItems.contains(
                                        item['name'])) // Match based on 'name'
                                    .map((item) => item['id']!) // Extract 'id'
                                    .toList();

                            // getIt<AuthCubit>().workshopServicesList.add(selectedItems.toString());
                            print("Selected items: $selectedItems");
                            print(getIt<AuthCubit>().workshopServicesList);
                          },
                        );
                      },
                    ),
                    // CustomTextFormFieldWithLabel(
                    //   controller: serviceTypeController,
                    //   hintText: getLang(context, "Find the service you need")
                    //       .toString(),
                    //   label: getLang(context, "Service Type").toString(),
                    // ),
                  ],
                ),
                CacheHelper.getdata(key: "token").toString() != "null"
                    ? ContainerWidget(
                        children: [
                          Text(
                            getLang(context, "Car Details:").toString(),
                            style: TextStyles.gray950FS16FW500CairoTextStyle,
                          ),
                          BlocConsumer<SearchCubit, SearchState>(
                            listener: (context, state) {
                              // TODO: implement listener
                              if (state is CarSuccessState) {
                                carResponse = state.data!.data!;
                              }
                            },
                            builder: (context, state) {
                              return carResponse.isEmpty
                                  ? Container()
                                  : CheckboxListTile(
                                      title: Text(
                                        getLang(context,
                                                "Use my registered car")
                                            .toString(),
                                        style: TextStyles
                                            .gray950FS16FW500CairoTextStyle
                                            .copyWith(
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                      value: useRegisteredCar,
                                      onChanged: (value) {
                                        setState(() {
                                          useRegisteredCar = value ?? false;
                                          if (useRegisteredCar)
                                            addNewCar = false;
                                        });
                                      },
                                    );
                            },
                          ),
                          CheckboxListTile(
                            title: Text(
                              getLang(context, "Add a new car").toString(),
                              style: TextStyles.gray950FS16FW500CairoTextStyle
                                  .copyWith(
                                color: Colors.grey[800],
                              ),
                            ),
                            value: addNewCar,
                            onChanged: (value) {
                              setState(() {
                                addNewCar = value ?? false;
                                if (addNewCar) useRegisteredCar = false;
                              });
                            },
                          ),
                          BlocConsumer<AuthCubit, AuthState>(
                            listener: (context, state) {
                              if (state is GetAllModelsSuccessState) {
                                getIt<AuthCubit>().allModels = state.data!.data!
                                    .map((e) => {
                                          'name': e.name!,
                                          'id': e.id.toString()
                                        })
                                    .toList();
                              }
                              // TODO: implement listener
                            },
                            builder: (context, state) {
                              return addNewCar
                                  ? CustomDropdownField(
                                      items: getIt<AuthCubit>()
                                          .allModels
                                          .map((item) => item['name']!)
                                          .toList(),
                                      onChanged: (String? value) {
                                        // Find the map entry that matches the selected name
                                        final selectedValue = getIt<AuthCubit>()
                                            .allModels
                                            .firstWhere((item) =>
                                                item['name'] == value);

                                        // Set the selected brand value and call getModels with the brand id
                                        getIt<AuthCubit>().userModelValue =
                                            value;
                                        getIt<AuthCubit>().selectedModelId =
                                            selectedValue['id']!;
                                        print(
                                            getIt<AuthCubit>().selectedModelId);
                                      },
                                      label:
                                          getLang(context, "Model:").toString(),
                                      hintText: "Corolla",
                                      value: getIt<AuthCubit>().userModelValue,
                                    )
                                  : Container();
                              // return CustomSingleSelectDropdownField<String>(
                              //   label: getLang(context, "Brand").toString(),
                              //   hintText: getLang(context, "Choose the brands available to you").toString(),
                              //   selectedValue: getIt<AuthCubit>().selectedModelId, // Save the ID here
                              //   items: getIt<AuthCubit>()
                              //       .allModels
                              //       .map((item) => item['name']!)
                              //       .toList(),
                              //   onChanged: (selectedName) {
                              //     // Find the corresponding ID based on the selected name
                              //     final selectedId = getIt<AuthCubit>()
                              //         .allModels
                              //         .firstWhere((item) => item['name'] == selectedName)['id'];
                              //
                              //     // Save the selected ID in your state
                              //     getIt<AuthCubit>().selectedModelId = selectedId;
                              //     print("Selected Name: $selectedName, ID: $selectedId");
                              //   },
                              // );
                              // return CustomDropdownField(
                              //   isMandatory: true,
                              //   label: getLang(context, "Services").toString(),
                              //   hintText: getLang(context, "Choose your service").toString(),
                              //   items: AuthCubit
                              //       .get(context)
                              //       .workshopServices,
                              //
                              // );
                            },
                          ),
                        ],
                      )
                    : SizedBox.shrink(),
                ContainerWidget(
                  children: [
                    Text(
                      getLang(context, "location:").toString(),
                      style: TextStyles.gray950FS16FW500CairoTextStyle,
                    ),
                    CheckboxListTile(
                      title: Text(
                        getLang(context, "Use the current location").toString(),
                        style:
                            TextStyles.gray950FS16FW500CairoTextStyle.copyWith(
                          color: Colors.grey[800],
                        ),
                      ),
                      value: useCurrentLocation,
                      onChanged: (value) {
                        setState(() {
                          useCurrentLocation = value ?? false;
                          if (useCurrentLocation) addLocationManually = false;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text(
                        getLang(context, "Add location manually").toString(),
                        style:
                            TextStyles.gray950FS16FW500CairoTextStyle.copyWith(
                          color: Colors.grey[800],
                        ),
                      ),
                      value: addLocationManually,
                      onChanged: (value) {
                        setState(() {
                          addLocationManually = value ?? false;
                          if (addLocationManually) useCurrentLocation = false;
                        });
                      },
                    ),
                    addLocationManually
                        ? InkWell(
                            onTap: () async {
                              final selectedDestination =
                                  await Navigator.pushNamed(
                                context,
                                RouteStrings.selectLocationMapScreen,
                                arguments: {
                                  "selectLocationMapCubit":
                                      getIt<SelectLocationMapCubit>(),
                                  "selectedDestination":
                                      getIt<AuthCubit>().selectedDestination,
                                },
                              );

                              if (selectedDestination != null &&
                                  selectedDestination is LatLng) {
                                setState(() {
                                  getIt<AuthCubit>().selectedDestination =
                                      selectedDestination;
                                });
                                print(
                                    "Selected Destination: $selectedDestination");
                              }
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                    "assets/icons/location_icon.svg",
                                    color: Colors.black),
                                horizontalSpace(5),
                                Expanded(
                                  child: Text(
                                    getLang(context,
                                            "Select Location on the map")
                                        .toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyles
                                        .gray950FS16FW600CairoTextStyle
                                        .copyWith(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink()
                  ],
                ),
                ContainerWidget(
                  children: [
                    Text(
                      getLang(context, "Service Availability:").toString(),
                      style: TextStyles.gray950FS16FW500CairoTextStyle,
                    ),
                    CheckboxListTile(
                      title: Text(
                        getLang(context, "now").toString(),
                        style:
                            TextStyles.gray950FS16FW500CairoTextStyle.copyWith(
                          color: Colors.grey[800],
                        ),
                      ),
                      value: now,
                      onChanged: (value) {
                        setState(() {
                          now = value ?? false;
                          if (now) chooseAnotherTime = false;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text(
                        getLang(context, "Choose another date").toString(),
                        style:
                            TextStyles.gray950FS16FW500CairoTextStyle.copyWith(
                          color: Colors.grey[800],
                        ),
                      ),
                      value: chooseAnotherTime,
                      onChanged: (value) {
                        setState(() {
                          chooseAnotherTime = value ?? false;
                          if (chooseAnotherTime) now = false;
                        });
                      },
                    ),
                    chooseAnotherTime
                        ? Row(
                            children: [
                              Text(
                                _selectedTime != null
                                    ? _selectedTime!.format(context)
                                    : '',
                                style: TextStyles.gray950FS16FW500CairoTextStyle
                                    .copyWith(
                                  color: Colors.grey[800],
                                ),
                              ),
                              horizontalSpace(8.w),
                              // Button to open time picker
                              ElevatedButton(
                                onPressed: () => _selectTime(context),
                                child: Text(
                                    getLang(context, "Choose another date")
                                        .toString()),
                              ),
                            ],
                          )
                        : const SizedBox.shrink()
                  ],
                ),
                DefaultButton(
                    color: ColorsManager.blackColor,
                    onPressed: CacheHelper.getdata(key: "latitude")
                                    .toString() !=
                                "null" &&
                            CacheHelper.getdata(key: "longitude").toString() !=
                                "null"
                        ? () {
                            // getIt<AuthCubit>().searchTypeValue == "normal"
                            //     ?
                            print(CacheHelper.getdata(key: "latitude")
                                .toString());
                            print(CacheHelper.getdata(key: "longitude")
                                .toString());
                            print(CacheHelper.getdata(key: "latitude")
                                        .toString() !=
                                    "null" &&
                                CacheHelper.getdata(key: "longitude")
                                        .toString() !=
                                    "null");
                            Navigator.pushNamed(
                              context,
                              RouteStrings.searchResultsScreen,
                              arguments: {
                                "data": {
                                  "search_text": getIt<AuthCubit>()
                                      .searchKeyController.text.trim(),
                                  "latitude": getIt<AuthCubit>()
                                          .selectedDestination
                                          ?.latitude ??
                                      "",
                                  "longitude": getIt<AuthCubit>()
                                          .selectedDestination
                                          ?.longitude ??
                                      "",
                                  "type": "normal",
                                  "serviceId":
                                      getIt<AuthCubit>().workshopServicesList,
                                  "addLocationManually": addLocationManually,
                                  "model_id": useRegisteredCar
                                      ? carResponse[0].model!.id
                                      : addNewCar
                                          ? getIt<AuthCubit>().selectedModelId
                                          : null,
                                }
                              },
                            );

                            // : getIt<AuthCubit>().searchTypeValue == "map"
                            //     ? Navigator.pushNamed(
                            //         context,
                            //         RouteStrings.mapResultScreen,
                            //         arguments: {
                            //           "data": {
                            //             "latitude": getIt<AuthCubit>()
                            //                     .selectedDestination
                            //                     ?.latitude ??
                            //                 "",
                            //             "longitude": getIt<AuthCubit>()
                            //                     .selectedDestination
                            //                     ?.longitude ??
                            //                 "",
                            //             "type":
                            //                 getIt<AuthCubit>().searchTypeValue,
                            //             "serviceId": getIt<AuthCubit>()
                            //                 .workshopServicesList,
                            //             "addLocationManually":
                            //                 addLocationManually,
                            //             "model_id": useRegisteredCar
                            //                 ? carResponse[0].model!.id
                            //                 : addNewCar
                            //                     ? getIt<AuthCubit>()
                            //                         .selectedModelId
                            //                     : null,
                            //           }
                            //         },
                            //       )
                            //     : null;
                          }
                        : () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  getLang(context,
                                          "Please close the application and reopen it and allow your location to be used.")
                                      .toString(),
                                ),
                                // action: SnackBarAction(
                                //   label: getLang(context, "Ok").toString(),
                                //   textColor: Colors.white,
                                //   // onPressed:  () async {
                                //   //   // Ask for location permission again
                                //   //   PermissionStatus permission = await Permission.location.request();
                                //   //
                                //   //   if (permission == PermissionStatus.granted) {
                                //   //     print("Location permission granted");
                                //   //     ScaffoldMessenger.of(context).showSnackBar(
                                //   //       SnackBar(
                                //   //         content: Text(getLang(context, "Permission granted").toString()),
                                //   //       ),
                                //   //     );
                                //   //   } else {
                                //   //     print("Location permission denied");
                                //   //     ScaffoldMessenger.of(context).showSnackBar(
                                //   //       SnackBar(
                                //   //         content: Text(getLang(context, "Permission denied").toString()),
                                //   //       ),
                                //   //     );
                                //   //   }
                                //   // },
                                // ),
                              ),
                            );
                          },
                    child: Text(
                      getLang(context, "Search").toString(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
