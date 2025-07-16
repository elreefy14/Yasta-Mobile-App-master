import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/helper/app_color/app_color.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';
import 'package:yasta/features/bot_massage/presentation/widget/message_text_field.dart';
import 'package:yasta/features/chat_screen/data/logic/chat_cubit.dart';

class SendMessageWidget extends StatefulWidget {
  final TextEditingController messageController;

  final Function() onTap;
  final Function() onSendAttachment;

  const SendMessageWidget({
    super.key,
    required this.messageController,
    required this.onTap,
    required this.onSendAttachment,
  });

  @override
  State<SendMessageWidget> createState() => _SendMessageWidgetState();
}

class _SendMessageWidgetState extends State<SendMessageWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          color: Colors.grey,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          decoration: const BoxDecoration(
            color: ColorsManager.gray200,
          ),
          child: Row(
            children: [
              InkWell(
                onTap: ChatCubit.get(context).enable == true
                    ? widget.onTap
                    : () {},
                child: Container(
                  height: 46,
                  width: 46,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ChatCubit.get(context).enable==true? ColorsManager.blackColor:Colors.grey,
                      ),
                  child: ChatCubit.get(context).enable == true
                      ? SvgPicture.asset(
                          "assets/icons/Group.svg",
                          color: Colors.white,
                        )
                      : Lottie.asset('assets/lottie/icon.json'),
                ),
              ),
              horizontalSpace(
                10.w,
              ),
              Expanded(
                child: AppTextFormField(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  horizontalPadding: 0,
                  hintText: getLang(context, "Write your message").toString(),
                  textInputType: TextInputType.text,
                  controller: widget.messageController,
                  borderRadius: 15,
                  backgroundColor: const Color.fromARGB(255, 239, 247, 252),
                ),
              ),
              horizontalSpace(
                10.w,
              ),
              // InkWell(
              //   onTap: widget.onSendAttachment,
              //   child: SvgPicture.asset(
              //     "assets/icons/Attach.svg",
              //     height: 35.h,
              //     width: 35.w,
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
