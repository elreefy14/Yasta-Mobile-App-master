import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../model/get_workshop_byId_response.dart';

class WorkshopDescriptionAndServices extends StatelessWidget {
  const WorkshopDescriptionAndServices(
      {super.key, required this.workShopDescription, required this.services});

  final String workShopDescription;

  final List<Services> services;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getLang(context, "Description").toString(),
          style: TextStyles.gray950FS18FW500TextStyle,
        ),
        verticalSpace(5),
        Text(
          workShopDescription,
          style: TextStyles.gray800FS16FW500CairoTextStyle,
        ),
        verticalSpace(20),
        Text(
          getLang(context, "Our services").toString(),
          style: TextStyles.gray950FS18FW500TextStyle,
        ),
        verticalSpace(10),
        ServicesListWidget(
          services: services,
        ),
      ],
    );
  }
}

class ServicesListWidget extends StatelessWidget {
  final List<Services> services;

  const ServicesListWidget({required this.services, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 5.w,
                height: 5.h,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: AppColors.blackColor,
                  // image: service.image != null
                  //     ? DecorationImage(
                  //         image: NetworkImage(service.image!),
                  //         fit: BoxFit.cover,
                  //         onError: (exception, stackTrace) {
                  //           print(exception);
                  //         },
                  //       )
                  //     : null,
                ),
              ),
              horizontalSpace(10),
              Expanded(
                child: Text(
                  service.name ?? "",
                  style: TextStyles.gray950FS18FW500TextStyle,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
