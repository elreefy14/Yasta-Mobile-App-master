import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/componant/componant.dart';
import 'package:yasta/core/componant/custom_dropdown_field_with_label.dart';
import 'package:yasta/core/helper/cache_helper/cache_helper.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';
import 'package:yasta/features/auth/auth_layput_screen.dart';
import 'package:yasta/features/auth/data/models/add_car_request_body.dart';
import 'package:yasta/features/my_car_screen/presentation/screen/car_selection_data.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/helper/app_color/app_color.dart';
import '../../../../core/route/route_strings/route_strings.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../service_provider/ui/widget/or_widget.dart';
import '../../logic/auth_cubit/auth_cubit.dart';

class AddCarData extends StatefulWidget {
  const AddCarData({super.key});

  @override
  State<AddCarData> createState() => _AddCarDataState();
}

class _AddCarDataState extends State<AddCarData> {
  @override


  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      children: [
        Text(
          getLang(context, "Your car data").toString(),
          style: TextStyles.blackFS18FW700CandaraTextStyle,
          textAlign: TextAlign.center,
        ),
        Text(
          getLang(context,
                  "Save time and effort by registering your vehicle details in advance.")
              .toString(),
          style: TextStyles.gray100FS14FW400CairoTextStyle,
          textAlign: TextAlign.center,
        ),
        verticalSpace(30),
        CarSelectionData(),
        verticalSpace(20),
        DefaultButton(
          color: ColorsManager.blackColor,
          onPressed: () {
            if (getIt<AuthCubit>().userYearValue != null) {
              // Find the corresponding `id` for the selected `userYearValue`
              var selectedYear = getIt<AuthCubit>().yearList.firstWhere(
                    (item) =>
                        item['year'] == getIt<AuthCubit>().userYearValue,
                    orElse: () => {}, // Return null if not found
                  );

              int yearId = int.parse(selectedYear['id']!);

              getIt<AuthCubit>().addCarForUser(
                addCarRequestBody: AddCarRequestBody(
                  yearId: yearId,
                ),
              );
            }
          },
          child: Text(
            getLang(context, "Getting started").toString(),
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AddCarForUserSuccessState) {
              Navigator.pushReplacementNamed(
                context,
                RouteStrings.accountCreatedSuccessfullyScreen,
                arguments: {
                  "isGuest": false,
                  "isUser": CacheHelper.getdata(key: 'userType') == "user"
                      ? true
                      : false,
                },
              );
            }
            if (state is AddCarForUserErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: const SizedBox.shrink(),
        ),
        verticalSpace(24.h),
        OrWidget(),
        verticalSpace(24.h),
        DefaultButton(
          color: ColorsManager.whiteColor,
          color2: Colors.grey[400]!,
          onPressed: () {
            Navigator.pushReplacementNamed(
              context,
              RouteStrings.accountCreatedSuccessfullyScreen,
              arguments: {
                "isGuest": false,
                "isUser": CacheHelper.getdata(key: 'userType') == "user"
                    ? true
                    : false,
              },
            );
          },
          child: Text(
            getLang(context, "I will do that later").toString(),
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey[500],
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        verticalSpace(24.h),
      ],
    );
  }
}
