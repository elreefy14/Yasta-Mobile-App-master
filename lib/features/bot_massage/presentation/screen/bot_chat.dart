import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yasta/features/bot_massage/data/model/fetch_message_from_bot.dart';
import 'package:yasta/features/bot_massage/presentation/widget/chat_bot_list_message.dart';
import 'package:yasta/features/bot_massage/presentation/widget/message_list.dart';
import 'package:yasta/features/chat_screen/data/logic/chat_cubit.dart';
import 'package:yasta/features/chat_screen/data/model/send_message_model.dart';

import '../../../../core/helper/app_color/app_color.dart';

class BotChat extends StatefulWidget {
  const BotChat({super.key});

  @override
  State<BotChat> createState() => _BotChatState();
}

class _BotChatState extends State<BotChat> {
  ScrollController scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();
  List<Data> fetchData = [];
  Response? response;
int index=1;
  @override
  void initState() {
    // TODO: implement initState
    ChatCubit.get(context).fetchMessage();
    animateListToTheEnd();
    super.initState();
  }

  animateListToTheEnd({int time = 500}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: time),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.gray200,
      body: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          if (state is FetchMessageSuccessState) {
            fetchData = state.data!.data!;

            animateListToTheEnd();
          }
          if (state is SendMessageBotSuccessState) {
            ChatCubit.get(context).enable=true;
            index++;
            state.data!.workshopIs == false
                ? fetchData.add(Data(
                    // message:state.data!.response!,
                     id:  index,
                    response: Response(message: state.data!.response!),
                    senderType: "bot",
                    //  workshopId: null,
                    createdAt:
                        "  ${DateTime.now().hour.toString()}:${DateTime.now().minute.toString()}"))
                : fetchData.add(Data(
                    // message:state.data!.response!,
                    //  id:  fetchData[0].id!+1,
                    id: index,
                    response: Response(
                      // message: state.data!.response!.message.toString(),
                      image: state.data!.response!.image.toString(),
                      address: state.data!.response!.address.toString(),
                      name: state.data!.response!.name.toString(),
                      logo: state.data!.response!.logo.toString(),
                      distance: int.parse(
                              state.data!.response!.distance.toString()) ??
                          0,
                      rating: double.parse(
                              state.data!.response!.rating.toString()) ??
                          0,
                      id: state.data!.response!.id ?? 1,
                    ),
                    senderType: "bot",
                    //  workshopId: null,
                    createdAt:
                        "  ${DateTime.now().hour.toString()}:${DateTime.now().minute.toString()}"));
            animateListToTheEnd();
          }
          if (state is SendMessageBotLoadingState) {
            ChatCubit.get(context).enable=false;
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text("Loading"),
            //   ),
            // );
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          return ChatBotListMessage(
              scrollController: scrollController,
              messageController: messageController,
              fetchData: fetchData,
              onSendAttachment: () {},
              onTap: () {
                if (messageController.text.isNotEmpty) {
                  ChatCubit.get(context).sendMessageToBot(
                      sendMessageModel: SendMessageModel(
                    message: messageController.text,
                  ));
                  setState(() {
                    fetchData.add(Data(

                        //   message: messageController.text.trim(),
                        // id:  fetchData[0].id!+1,
                        response:
                            Response(message: messageController.text.trim()),
                        senderType: "user",
                        //   workshopId: null,
                        createdAt:
                            "  ${DateTime.now().hour.toString()}:${DateTime.now().minute.toString()}"));
                    animateListToTheEnd();
                  });
                }
                messageController.clear();
              });
        },
      ),
    );
  }
}
