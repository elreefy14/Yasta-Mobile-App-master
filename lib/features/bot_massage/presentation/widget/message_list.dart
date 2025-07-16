import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yasta/features/bot_massage/presentation/widget/receiver_message_widget.dart';
import 'package:yasta/features/bot_massage/presentation/widget/send_message_widget.dart';
import 'package:yasta/features/bot_massage/presentation/widget/sender_message_widget.dart';

import 'package:yasta/features/chat_screen/data/model/fetch_chat.dart';

class MessagesListWidget extends StatelessWidget {
  MessagesListWidget(
      {super.key,
      required this.scrollController,
      required this.messageController,
      required this.onTap,
      required this.onSendAttachment,
      this.fetchData});

  final ScrollController scrollController;
  final TextEditingController messageController;

  final Function() onTap;
  final Function() onSendAttachment;
  Data? fetchData;
  bool isMe = true;

  @override
  Widget build(BuildContext context) {
    return fetchData == null ? const Center(child: CircularProgressIndicator()) : Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 24.0.w,
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                if (fetchData!.messages!.dataMessages![index].send_me!) {
                  return SenderMsgItemWidget(
                    message: fetchData!.messages!.dataMessages![index].message.toString() ,
                    time: fetchData!.messages!.dataMessages![index].createdAt.toString(),
                  );
                } else {
                  return ReceiverMsgItemWidget(
                  message: fetchData!.messages!.dataMessages![index].message.toString(),
                  time: fetchData!.messages!.dataMessages![index].createdAt.toString(),
                  );

                }
                // if(message.isEmpty)
                //   Center(child: Text(
                //     'اسألني أي شيء! يسعدني أن أقدم لك المساعدة في أي وقت.',
                //     textAlign: TextAlign.center,
                //     style: TextStyle(
                //       color: Color(0xFF374151),
                //       fontSize: 16,
                //       fontFamily: 'Cairo',
                //       fontWeight: FontWeight.w500,
                //       height: 0.09,
                //     ),
                //   ),)
              },
              itemCount: fetchData?.messages!.dataMessages!.length,
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),

             reverse: true,
            ),
          ),
          SendMessageWidget(
            onTap: onTap,
            onSendAttachment: onSendAttachment,
            messageController: messageController,
          ),
        ],
      ),
    );
  }
}
