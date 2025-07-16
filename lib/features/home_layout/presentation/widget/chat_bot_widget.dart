import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yasta/features/bot_massage/data/model/fetch_message_from_bot.dart';
import 'package:yasta/features/bot_massage/presentation/widget/chat_bot_list_message.dart';
import 'package:yasta/features/bot_massage/presentation/widget/message_list.dart';
import 'package:yasta/features/chat_screen/data/logic/chat_cubit.dart';
import 'package:yasta/features/chat_screen/data/model/send_message_model.dart';

import '../../../../core/helper/app_color/app_color.dart';

class BotChatWidget extends StatefulWidget {
  const BotChatWidget({super.key});

  @override
  State<BotChatWidget> createState() => _BotChatWidgetState();
}

class _BotChatWidgetState extends State<BotChatWidget> {
  ScrollController scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.gray200,
      body:  ChatBotListMessage(
        scrollController: scrollController,
        messageController: messageController,
        fetchData: [],
        onSendAttachment: () {},
        onTap: () {
          messageController.clear();
        }
    ),
    );
  }
}
