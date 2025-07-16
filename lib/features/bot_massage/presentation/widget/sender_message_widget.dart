

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/theme/text_styles.dart';
class SenderMsgItemWidget extends StatelessWidget {
  const SenderMsgItemWidget({
    super.key,
    required this.message,
    required this.time,
  });

  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                width: MediaQuery.of(context).size.width * 0.72,
                decoration:  BoxDecoration(
                  color: Colors.white,
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
           //   const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}
