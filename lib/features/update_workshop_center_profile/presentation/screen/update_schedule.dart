import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/componant/custom_app_bar.dart';
import 'package:yasta/core/componant/default_button.dart';
import 'package:yasta/core/componant/success_bottom_sheet_widget.dart';
import 'package:yasta/core/constants/constants.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/helper/app_color/app_color.dart';
import '../../../../core/helper/spacing/spacing.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../auth/logic/auth_cubit/auth_cubit.dart';
import '../../../auth/service_provider_screens/sign_up_screen/presentation/widgets/appointments_widget.dart';
import '../../../auth/service_provider_screens/sign_up_screen/presentation/widgets/from_widget.dart';
import '../../../workshop_profile/model/get_workshop_byId_response.dart';

class UpdateSchedule extends StatefulWidget {
  final List<Schedule> schedules;

  const UpdateSchedule({super.key, required this.schedules});

  @override
  State<UpdateSchedule> createState() => _UpdateScheduleState();
}

class _UpdateScheduleState extends State<UpdateSchedule> {
  @override
  void initState() {
    super.initState();

    // Prepopulate working hours in AuthCubit from existing schedules
    getIt<AuthCubit>().workingHours = widget.schedules.map((schedule) {
      final openingTimeParts = schedule.openingTime?.split(':') ?? ['00', '00'];
      final closingTimeParts = schedule.closingTime?.split(':') ?? ['00', '00'];
      print("schedule.dayWeek");
      print(schedule.dayWeek);
      return {
        'dayController': [schedule.dayWeek!],
        // Start with the existing day
        'fromHourController': TextEditingController(text: openingTimeParts[0]),
        'fromMinuteController':
            TextEditingController(text: openingTimeParts[1]),
        'toHourController': TextEditingController(text: closingTimeParts[0]),
        'toMinuteController': TextEditingController(text: closingTimeParts[1]),
      };
    }).toList();
  }

  @override
  void dispose() {
    // Dispose controllers in workingHours
    for (var entry in getIt<AuthCubit>().workingHours) {
      entry['fromHourController'].dispose();
      entry['fromMinuteController'].dispose();
      entry['toHourController'].dispose();
      entry['toMinuteController'].dispose();
    }
    super.dispose();
  }

  void saveUpdatedSchedule() {
    // Map working hours back to Schedule model

    List<Schedules> updatedSchedules =
        getIt<AuthCubit>().workingHours.map((entry) {
      return Schedules(
        dayWeek:
            entry['dayController'].isNotEmpty ? entry['dayController'] : null,
        openingTime:
            '${entry['fromHourController'].text}:${entry['fromMinuteController'].text == "" ? "00" : entry['fromMinuteController'].text}',
        closingTime:
            '${entry['toHourController'].text}:${entry['toMinuteController'].text == "" ? "00" : entry['fromMinuteController'].text}',
      );
    }).toList();

    // Debugging: Print schedules
    print(updatedSchedules.map((schedule) => schedule.toJson()).toList());

    getIt<AuthCubit>().updateSchedules(
      schedules: UpdateScheduleModel(
        schedules: updatedSchedules,
      ),
    );

    // Add API call or further processing here


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getLang(context, "Working hours").toString()),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            AppointmentsWidget(isEdit: true),
            verticalSpace(20),
            DefaultButton(
              label: getLang(context, "Save").toString(),
              onPressed: saveUpdatedSchedule,
            ),
            BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is UpdateScheduleSuccessState) {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(45.0.r)),
                    ),
                    builder: (context) {
                      return SuccessBottomSheetWidget(
                        successText:
                          state.data!.message!.toString()
                          // getLang(context,
                          //   "Your center profile data has been updated successfully.")
                          //   .toString(),
                      );
                    },
                  ).then((_){
                    Navigator.pop(context);
                  });
                } if (state is UpdateScheduleErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message )),
                  );
                }
              },
              child: SizedBox.shrink(),
            )
          ],
        ),
      ),
    );
  }
}

class UpdateScheduleModel {
  List<Schedules>? schedules;

  UpdateScheduleModel({this.schedules});

  UpdateScheduleModel.fromJson(Map<String, dynamic> json) {
    if (json['schedules'] != null) {
      schedules = <Schedules>[];
      json['schedules'].forEach((v) {
        schedules!.add(new Schedules.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.schedules != null) {
      data['schedules'] = this.schedules!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Schedules {
  List<String>? dayWeek;
  String? openingTime;
  String? closingTime;

  Schedules({this.dayWeek, this.openingTime, this.closingTime});

  Schedules.fromJson(Map<String, dynamic> json) {
    dayWeek = json['day_week'].cast<String>();
    openingTime = json['opening_time'];
    closingTime = json['closing_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day_week'] = this.dayWeek;
    data['opening_time'] = this.openingTime;
    data['closing_time'] = this.closingTime;
    return data;
  }
}
