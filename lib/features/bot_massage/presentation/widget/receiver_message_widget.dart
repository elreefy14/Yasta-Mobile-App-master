import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/helper/app_color/app_color.dart';
import 'package:yasta/core/theme/text_styles.dart';


class ReceiverMsgItemWidget extends StatelessWidget {
  final String message;
  final String time;

  const ReceiverMsgItemWidget({
    super.key,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                width: MediaQuery.of(context).size.width * 0.72,
                decoration:  BoxDecoration(
                  color: Color(0xFFE5E7EB),
                  borderRadius:  BorderRadius.only(
                    bottomRight: Radius.circular(20.r),
                    bottomLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                    topLeft: Radius.circular(20.r),
                  ),
                ),
                child: Text(
                  message.toString(),
                  style: TextStyles.gray800FS16FW500CairoTextStyle,
                ),
              ),
              Text(
                time.toString(),
                style: TextStyles.gray500FS14FW400CairoTextStyle,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}
