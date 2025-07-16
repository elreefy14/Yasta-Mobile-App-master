import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/route/route_strings/route_strings.dart';
import 'package:yasta/features/auth/data/models/add_car_request_body.dart';
import 'package:yasta/features/auth/logic/auth_cubit/auth_cubit.dart';
import 'package:yasta/features/my_car_screen/logic/model/show_car_model.dart';
import '../../../../core/componant/custom_dropdown_field_with_label.dart';
import '../../../../core/componant/success_bottom_sheet_widget.dart';
import '../../../../core/helper/spacing/spacing.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../preview_data_layout/presentation/screen/preview_data_layout.dart';
import '../../../preview_data_layout/presentation/widgets/preview_data_update_item.dart';
import '../screen/car_selection_data.dart';
import '../../../../../../core/di/dependency_injection.dart';

class UpdateCarDataScreen extends StatefulWidget {
  const UpdateCarDataScreen({super.key, required this.showCarResponse});

  final Data showCarResponse;

  @override
  State<UpdateCarDataScreen> createState() => _UpdateCarDataScreenState();
}

class _UpdateCarDataScreenState extends State<UpdateCarDataScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PreviewDataLayout(
        appBarTitle:
            "${getLang(context, "Edit")} ${getLang(context, "car data")}",
        children: [
          PreviewDataUpdateItem(
            onSavedPressed: () {
              // Show BottomSheet on save

              if (getIt<AuthCubit>().userYearValue != null) {
                // Find the corresponding `id` for the selected `userYearValue`
                var selectedYear = getIt<AuthCubit>().yearList.firstWhere(
                      (item) =>
                          item['year'] == getIt<AuthCubit>().userYearValue,
                      orElse: () => {}, // Return null if not found
                    );
                int yearId = int.parse(selectedYear['id']!);
                getIt<AuthCubit>().updateCarForUser(
                  addCarRequestBody: AddCarRequestBody(
                    yearId: yearId,
                  ),
                );
              }
            },
            onCancelPressed: () {
              Navigator.pop(context);
            },
            children: [
              BlocListener<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is UpdateCarForUserSuccessState) {
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
                                  "Your car details have been added successfully.")
                              .toString(),
                        );
                      },
                    ).then((_) {
                      Navigator.pop(context, true);
                      // Navigator.pushReplacementNamed(
                      //   context,
                      //   RouteStrings.userCarScreen,
                      //       // This clears all previous routes
                      // );
                    });
                  }
                },
                child: const SizedBox.shrink(),
              ),
              Text(
                getLang(context, "Edit car data").toString(),
                style: TextStyles.gray900FS16FW500CairoTextStyle,
              ),
              verticalSpace(30),
              CarSelectionData(
                carResponse: widget.showCarResponse,
              ),
              verticalSpace(20),
            ],
          ),
        ],
      ),
    );
  }
}
