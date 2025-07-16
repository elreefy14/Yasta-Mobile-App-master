import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/componant/custom_app_bar.dart';
import 'package:yasta/core/componant/user_image_widget.dart';
import 'package:yasta/core/constants/constants.dart';
import 'package:yasta/core/helper/cache_helper/cache_helper.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';
import 'package:yasta/core/theme/colors.dart';
import 'package:yasta/core/theme/text_styles.dart';
import 'package:yasta/features/center_profile/presentation/screen/center_profile.dart';
import 'package:yasta/features/messages_screen/data/logic/message_cubit.dart';
import 'package:yasta/features/messages_screen/data/pusher/pusher_confige.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/route/route_strings/route_strings.dart';
import '../../data/model/get_conversations_model.dart';
import '../widgets/message_date.dart';
import '../widgets/message_preview_from_me.dart';
import '../widgets/message_preview_with_seen_sign.dart';
import '../widgets/message_preview_with_unseen_sign.dart';
import '../widgets/username_with_number_of_messages.dart';
import '../widgets/username_with_number_of_messages_and_message_date.dart';
import '../widgets/username_without_number_of_messages.dart';
import '../widgets/username_without_number_of_messages_and_message_date.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> with RouteAware {
  List<Data> data = [];
  late PusherConfig pusherConfig;
  void requestNotificationPermission() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }
  @override
  void initState() {
    super.initState();
    print(CacheHelper.getdata(key: "id"));
    getIt<MessageCubit>().getAllConversations();
    _initializeChat();
    requestNotificationPermission();
  }

  void _initializeChat() async {
    // Initialize Pusher for real-time messages
    pusherConfig = PusherConfig();
    await pusherConfig.initPusher(onEvent);
  }

  void onEvent(PusherEvent event) {
    print(event.eventName == "conversation.message");
    print(event.eventName);
    log("Event received: ${event}");

    if (event.eventName == "conversation.message") {
      try {
        Map<String, dynamic> eventData = jsonDecode(event.data!);
        log("Decoded event data: $eventData");

        setState(() {
          getIt<MessageCubit>().getAllConversations();
        });
      } catch (e) {
        log("Error processing message: $e");
      }
    } else {
      print("Event name mismatch or not handled: ${event.eventName}");
      print(event.data);
    }
  }

  Future<void> _refreshData() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate network request
    setState(() {
      getIt<MessageCubit>().getAllConversations();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      routeObserver.subscribe(this, route); // Subscribe to the route
    }
  }

  @override
  void didPopNext() {
    // Called when the user navigates back to this screen
    setState(() {
      getIt<MessageCubit>().getAllConversations();
    });
  }

  @override
  void dispose() {
    // Unsubscribe from RouteObserver
    routeObserver.unsubscribe(this);
    pusherConfig.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: getLang(context, "Messages").toString(),
        centerTitle: true,
        titleStyle: TextStyles.darkBlue300FS14FW600CairoTextStyle,
        iconColor: AppColors.darkBlue300,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 20.h,
            horizontal: Constants.hPadding,
          ),
          color: AppColors.gray100,
          child: BlocConsumer<MessageCubit, MessageState>(
            listener: (context, state) {
              if (state is GetAllConversationsSuccessState) {
                data = state.data!.data!;
              }
            },
            builder: (context, state) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  return data.isEmpty
                      ? Center(child: Text("لا يوجد رسائل"))
                      : Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteStrings.chatScreen,
                          arguments: {
                            "conversationsId":
                            int.parse(data[index].id.toString()),
                          },
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UserImageWidget(
                            imageUrl: data[index].image,
                            radius: 30.r,
                          ),
                          horizontalSpace(12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                data[index].noNewMessage != 0
                                    ? UsernameWithNumberOfMessagesAndMessageDate(
                                  userName:
                                  data[index].name.toString(),
                                  numberOfMessages: data[index]
                                      .noNewMessage
                                      .toString(),
                                  month: data[index]
                                      .lastSentAt
                                      .toString(),
                                )
                                    : UsernameWithoutNumberOfMessagesAndMessageDate(
                                  userName:
                                  data[index].name.toString(),
                                  month: data[index]
                                      .lastSentAt
                                      .toString(),
                                ),
                                verticalSpace(10),
                                if (data[index].seen == false)
                                  MessagePreviewWithUnseenSign(
                                    message:
                                    data[index].lastMessage ?? "",
                                  )
                                else if (data[index].seen == true)
                                  MessagePreviewWithSeenSign(
                                    message:
                                    data[index].lastMessage ?? "",
                                  )
                                else if (data[index].seen == null)
                                    MessagePreviewFromMe(
                                      message:
                                      data[index].lastMessage ?? "",
                                    )
                                  else
                                    SizedBox.shrink(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: const Divider(),
                  );
                },
                itemCount: data.length,
              );
            },
          ),
        ),
      ),
    );
  }
}

