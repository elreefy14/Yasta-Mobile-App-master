import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/helper/cache_helper/cache_helper.dart';
import 'package:yasta/core/theme/text_styles.dart';
import 'package:yasta/features/bot_massage/presentation/widget/message_list.dart';
import 'package:yasta/features/chat_screen/data/logic/chat_cubit.dart';
import 'package:yasta/features/chat_screen/data/model/fetch_chat.dart';
import 'package:yasta/features/chat_screen/data/model/send_message_model.dart';
import 'package:yasta/features/chat_screen/data/model/start_model.dart';

import '../../../../core/helper/app_color/app_color.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yasta/core/theme/text_styles.dart';
import 'package:yasta/features/bot_massage/presentation/widget/message_list.dart';
import 'package:yasta/features/chat_screen/data/logic/chat_cubit.dart';
import 'package:yasta/features/chat_screen/data/model/fetch_chat.dart';
import 'package:yasta/features/chat_screen/data/model/send_message_model.dart';

import '../../../../core/helper/app_color/app_color.dart';
import '../../../../core/pucher_config/pucher_config.dart';

class ChatService {
  static final ChatService _instance = ChatService._internal();

  factory ChatService() => _instance;

  ChatService._internal();

  // late PusherClient pusher;
  dynamic chatChannel;
  late FirebaseMessaging messaging;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  bool isInForeground = true;

  Future<void> initialize() async {
    // Initialize Firebase
    await Firebase.initializeApp();
    messaging = FirebaseMessaging.instance;

    // Request notification permissions
    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Initialize local notifications
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettingsIOS = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Initialize Pusher
    // PusherOptions options = PusherOptions(
    //   cluster: 'YOUR_PUSHER_CLUSTER',
    //   encrypted: true,
    // );

    // pusher = PusherClient(
    //   'YOUR_PUSHER_APP_KEY',
    //   options,
    //   autoConnect: true,
    //   enableLogging: true,
    // );

    // Subscribe to chat channel
    // chatChannel = pusher.subscribe('chat-channel');

    // Listen for new messages
    chatChannel.bind('message.sent', (event) {
      if (!isInForeground) {
        showNotification(event?.data);
      }
    });

    // Handle FCM messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (!isInForeground) {
        showNotification(message.data);
      }
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  // Handle background messages
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    // Show notification when app is in background
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await showNotification(message.data);
  }

  static Future<void> showNotification(Map<String, dynamic>? data) async {
    if (data == null) return;

    const androidDetails = AndroidNotificationDetails(
      'conversation.16.auth.4',
      'Chat Notifications',
      channelDescription: 'Notifications for new chat messages',
      importance: Importance.max,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails();

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await FlutterLocalNotificationsPlugin().show(
      DateTime.now().millisecond,
      data['title'] ?? 'New Message',
      data['message'] ?? '',
      notificationDetails,
    );
  }

  void setForegroundState(bool isForeground) {
    isInForeground = isForeground;
  }

  // Call this method when user enters chat screen
  void onEnterChat() {
    setForegroundState(true);
  }

  // Call this method when user leaves chat screen
  void onLeaveChat() {
    setForegroundState(false);
  }

  // Example usage in your chat screen
  void sendMessage(String message) {
    // Your message sending logic here
    // This will trigger the Pusher event for other users
  }
}

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key, required this.conversationsId});

  final int conversationsId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
  final ScrollController scrollController = ScrollController();
  final TextEditingController messageController = TextEditingController();
  late PusherConfig pusherConfig;
  Data? fetchData;
  bool isLoadingMore = false;
  bool Isme = false;
  int currentPage = 1;
  int totalPage = 1;
  final ChatService _chatService = ChatService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _chatService.onEnterChat();
    ChatCubit.get(context).conversationsId = widget.conversationsId;

    // Initial data fetch
    ChatCubit.get(context).fetchConversations();

    // Add scroll listener for pagination
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isLoadingMore &&
          currentPage < totalPage) {
        _loadMoreMessages();
      }
    });
    _initializeChat();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _chatService.setForegroundState(state == AppLifecycleState.resumed);
  }

  static Future<void> showNotification(String message) async {

    const androidDetails = AndroidNotificationDetails(
      '1920896',
      'conversation.16.auth.4',
      channelDescription: 'Notifications for new chat messages',
      importance: Importance.max,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails();

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await FlutterLocalNotificationsPlugin().show(
      0,
      'New Message',
      message,
      notificationDetails,
    );
  }

  void _initializeChat() async {
    // Fetch initial chat message

    // Initialize Pusher for real-time messages
    pusherConfig = PusherConfig();
    await pusherConfig.initPusher(onEvent,
        roomId: widget.conversationsId.toString());
  }

  void onEvent(PusherEvent event) {
    print(event.eventName == "message.sent");
    print(event.eventName);
    log("Event received: ${event}");

    if (event.eventName == "message.sent") {
      try {
        // Decode the JSON data as a Map
        Map<String, dynamic> eventData = jsonDecode(event.data!);
        log("Decoded event data: $eventData");

        // Access the 'message' field
        Map<String, dynamic> messageData = eventData['message'];

        // Extract the message fields
        String message = messageData['message'];
        String createdAt = messageData['created_at'];
        bool sendMe = messageData['send_me'];
        int id = messageData['id'];
        showNotification(message);
        // Add the new message to the list
        setState(() {
          fetchData?.messages?.dataMessages?.insert(
            0,
            DataMessages(
              message: message,
              id: id,
              send_me: sendMe,
              createdAt: createdAt,
            ),
          );
          animateListToTheEnd();
          ChatCubit.get(context).seenConversations();
        });
      } catch (e) {
        log("Error processing message: $e");
      }
    } else {
      print("Event name mismatch or not handled: ${event.eventName}");
      print(event.data);
    }
  }

  animateListToTheEnd({int time = 500}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.minScrollExtent,
          duration: Duration(milliseconds: time),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  Future<void> _loadMoreMessages() async {
    setState(() {
      isLoadingMore = true;
    });

    // Fetch next page
    ChatCubit.get(context).page = currentPage + 1;
    await ChatCubit.get(context).fetchConversations();

    setState(() {
      isLoadingMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state is FetchConversationsSuccessState) {
          if (currentPage < totalPage) {
            // Append new messages when lazy loading
            fetchData?.messages?.dataMessages ??= [];
            fetchData?.messages?.dataMessages
                ?.insertAll(50, state.data!.data!.messages!.dataMessages!);
            totalPage = state.data!.data!.messages!.meta!.totalPages!;
            currentPage++;
          } else {
            // Load messages for the first time
            fetchData = state.data!.data;
            animateListToTheEnd();
            totalPage = state.data!.data!.messages!.meta!.totalPages!;
          }
          ChatCubit.get(context).seenConversations();
        }
      },
      builder: (context, state) {
        if (state is FetchConversationsLoadingState && fetchData == null) {
          return Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 1,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              fetchData?.workshopName ?? '',
              style: TextStyles.blackFS15FW500TextStyle,
            ),
            centerTitle: true,
          ),
          backgroundColor: ColorsManager.gray200,
          body: Stack(
            children: [
              MessagesListWidget(
                scrollController: scrollController,
                fetchData: fetchData,
                messageController: messageController,
                onSendAttachment: () {},
                onTap: () {
                  if (messageController.text.isNotEmpty) {
                    ChatCubit.get(context).sendMessage(
                      sendMessageModel: SendMessageModel(
                        message: messageController.text,
                      ),
                    );
                    setState(() {
                      fetchData?.messages?.dataMessages ??= [];
                      fetchData?.messages?.dataMessages?.insert(
                        0, // Insert at the beginning of the list
                        DataMessages(
                          message: messageController.text.trim(),
                          id: 1,
                          send_me: false,
                          createdAt:
                              "${DateTime.now().hour}:${DateTime.now().minute}",
                        ),
                      );

                      animateListToTheEnd();
                    });

                    messageController.clear();
                  }
                },
              ),
              if (isLoadingMore)
                Positioned(
                  top: 10,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    messageController.dispose();
    pusherConfig.disconnect();
    WidgetsBinding.instance.removeObserver(this);
    _chatService.onLeaveChat();
    super.dispose();
  }
}
