import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yasta/core/helper/cache_helper/cache_helper.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';
import 'package:yasta/features/auth/auth_layput_screen.dart';
import 'package:yasta/features/auth/logic/auth_cubit/auth_cubit.dart';
import '../../../../../../core/app_local/app_local.dart';
import '../../../../../../core/componant/default_button.dart';
import '../../../../../../core/route/route_strings/route_strings.dart';
import '../../../../data/models/schedule_model.dart';
import '../../../../data/models/workshop_schedules_request_body.dart';
import '../widgets/appointments_widget.dart';
import '../widgets/header_widget.dart';
import '../../../../../../core/di/dependency_injection.dart';

class AddScheduleData extends StatefulWidget {
  const AddScheduleData({super.key});

  @override
  State<AddScheduleData> createState() => _AddScheduleDataState();
}

class _AddScheduleDataState extends State<AddScheduleData> {
  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      children: [

        const HeaderWidget(),
        verticalSpace(40),
        const Divider(),
        AppointmentsWidget(),
        verticalSpace(30),
        const Divider(),
        DefaultButton(
          label: getLang(context, "Save data").toString(),
          onPressed: () {
            List<ScheduleModel> schedules =
                getIt<AuthCubit>().workingHours.map((workingHour) {
              return ScheduleModel(
                dayWeek: workingHour['dayController'],
                // Ensure it's a compatible type
                openingTime:
                    "${workingHour['fromHourController'].text}:${workingHour['fromMinuteController'].text == "" ? "00" : workingHour['fromMinuteController'].text}",
                closingTime:
                    "${workingHour['toHourController'].text}:${workingHour['toMinuteController'].text == "" ? "00" : workingHour['fromMinuteController'].text}",
              );
            }).toList();

            getIt<AuthCubit>().addSchedules(
              schedules: WorkshopSchedulesRequestBody(schedules: schedules),
            );
          },
        ),
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AddScheduleSuccessState) {
              CacheHelper.saveData(
                  key: "stage",
                  value:  "4")
                  .then((_) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteStrings.addSocialsData,
                      (Route<dynamic> route) => false,
                );
              });

            }
            if (state is AddScheduleErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: const SizedBox.shrink(),
        ),
        verticalSpace(40),
      ],
    );
  }
}
