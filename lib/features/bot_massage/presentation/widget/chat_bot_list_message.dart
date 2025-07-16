import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/componant/work_shop_card.dart';
import 'package:yasta/features/bot_massage/data/model/feedback_body.dart';
import 'package:yasta/features/bot_massage/presentation/widget/receiver_message_widget.dart';
import 'package:yasta/features/bot_massage/presentation/widget/send_message_widget.dart';
import 'package:yasta/features/bot_massage/presentation/widget/sender_message_widget.dart';

import 'package:yasta/features/bot_massage/data/model/fetch_message_from_bot.dart';
import 'package:yasta/features/chat_screen/data/model/start_model.dart';

import '../../../../core/route/route_strings/route_strings.dart';
import '../../../chat_screen/data/logic/chat_cubit.dart';
import '../../../chat_screen/data/model/send_message_model.dart';

class ChatBotListMessage extends StatefulWidget {
  ChatBotListMessage(
      {super.key,
      required this.scrollController,
      required this.messageController,
      required this.onTap,
      required this.onSendAttachment,
      required this.fetchData});

  final ScrollController scrollController;
  final TextEditingController messageController;

  final Function() onTap;
  final Function() onSendAttachment;
  final List<Data> fetchData;

  @override
  State<ChatBotListMessage> createState() => _ChatBotListMessageState();
}

class _ChatBotListMessageState extends State<ChatBotListMessage> {
  bool isMe = true;

  String? feedbackType;

  // key: aiChatbotId, value: 'like' | 'dislike' | null
  Map<int, String?> feedbackMap = {}; // If id is int

  void sendFeedback(String type, int id) {
    setState(() {
      if (feedbackMap[id] == type) {
        feedbackMap[id] = null;
      } else {
        feedbackMap[id] = type;
      }
    });

    ChatCubit.get(context).feedBackMessage(
      feedbackBody: FeedbackBody(
        aiChatbotId: id,
        type: type,
      ),
    );
  }

  // can be 'like', 'dislike', or null

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 24.0.w,
      ),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // BlocListener<ChatCubit,ChatState>(listener: (context, state){
          //   if()
          // }),
          widget.fetchData.isEmpty
              ? Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset("assets/lottie/1 screen.json"),
                        Text(
                          getLang(context,
                                  "Ask me anything! I am happy to help you at any time.")
                              .toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF374151),
                            fontSize: 16,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w500,
                            // height: 0.09,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      int? messageId = widget.fetchData[index].id;
                      if (widget.fetchData[index].senderType == "bot") {
                        return widget.fetchData[index].response!.message != null
                            ? Column(
                                children: [
                                  SenderMsgItemWidget(
                                    message: widget
                                        .fetchData[index].response!.message!,
                                    time: widget.fetchData[index].createdAt!,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          feedbackMap[messageId] == 'like'
                                              ? Icons.thumb_up
                                              : Icons.thumb_up_alt_outlined,
                                          color:
                                              feedbackMap[messageId] == 'like'
                                                  ? Colors.blue
                                                  : Colors.grey,
                                        ),
                                        onPressed: () =>
                                            sendFeedback('like', messageId!),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          feedbackMap[messageId] == 'dislike'
                                              ? Icons.thumb_down
                                              : Icons.thumb_down_alt_outlined,
                                          color: feedbackMap[messageId] ==
                                                  'dislike'
                                              ? Colors.red
                                              : Colors.grey,
                                        ),
                                        onPressed: () =>
                                            sendFeedback('dislike', messageId!),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  WorkshopCard(
                                    onTap2: () {
                                      ChatCubit.get(context).startConversations(
                                          startConversationsModel:
                                              StartConversationsModel(
                                                  workshopId: widget
                                                      .fetchData[index]
                                                      .response!
                                                      .id));
                                    },
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        RouteStrings.workshopProfileScreen,
                                        arguments: {
                                          "workshopId": widget
                                              .fetchData[index].response!.id
                                        },
                                      );
                                    },
                                    onRatingUpdate: (p0) {
                                      // setState(() {
                                      //   _userRating = p0;
                                      // });
                                    },
                                    userRating: double.parse(widget
                                        .fetchData[index].response!.rating
                                        .toString()),
                                    workShopDistance: widget
                                        .fetchData[index].response!.distance
                                        .toString(),
                                    workShopImage:
                                        widget.fetchData[index].response!.logo!,
                                    workShopPreviewImage: widget
                                        .fetchData[index].response!.image!,
                                    workShopLocation: widget.fetchData[index]
                                            .response!.address ??
                                        "",
                                    workShopName: widget
                                            .fetchData[index].response!.name ??
                                        "",
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          feedbackMap[messageId] == 'like'
                                              ? Icons.thumb_up
                                              : Icons.thumb_up_alt_outlined,
                                          color:
                                          feedbackMap[messageId] == 'like'
                                              ? Colors.blue
                                              : Colors.grey,
                                        ),
                                        onPressed: () =>
                                            sendFeedback('like', messageId!),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          feedbackMap[messageId] == 'dislike'
                                              ? Icons.thumb_down
                                              : Icons.thumb_down_alt_outlined,
                                          color: feedbackMap[messageId] ==
                                              'dislike'
                                              ? Colors.red
                                              : Colors.grey,
                                        ),
                                        onPressed: () =>
                                            sendFeedback('dislike', messageId!),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              );
                      } else {
                        return ReceiverMsgItemWidget(
                          message: widget.fetchData[index].response!.message!,
                          time: widget.fetchData[index].createdAt!,
                        );
                      }
                    },
                    itemCount: widget.fetchData.length,
                    controller: widget.scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    //   reverse: true,
                  ),
                ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SendMessageWidget(
              onTap: widget.onTap,
              onSendAttachment: widget.onSendAttachment,
              messageController: widget.messageController,
            ),
          ),
        ],
      ),
    );
  }
}
