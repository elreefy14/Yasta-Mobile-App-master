import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/features/workshop_profile/model/get_workshop_byId_response.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/helper/spacing/spacing.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../update_workshop_center_profile/data/logic/update_center_cubit.dart';

class OurService extends StatefulWidget {
  final List<Services> services;

  const OurService({super.key, required this.services});

  @override
  State<OurService> createState() => _OurServiceState();
}

class _OurServiceState extends State<OurService> {
  @override
  void initState() {
    // TODO: implement initState
    getIt<UpdateCenterCubit>().selectedWorkshopServices.clear();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getLang(context, "Our services").toString(),
          style: TextStyles.gray950FS18FW500TextStyle,
        ),
        ListView.builder(
          itemCount: widget.services.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final service = widget.services[index];

            getIt<UpdateCenterCubit>().selectedWorkshopServices.add(service.name!);
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 8.w,
                    height: 8.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: AppColors.blackColor,
                    ),
                  ),
                  horizontalSpace(10),
                  Expanded(
                    child: Text(
                      service.name??"",
                      style: TextStyles.gray950FS18FW500TextStyle,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
