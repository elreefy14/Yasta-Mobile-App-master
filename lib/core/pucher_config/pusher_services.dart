import 'dart:developer';
import 'dart:convert';
import 'package:pusher_channels_flutter/pusher-js/core/channels/channel.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:yasta/features/chat_screen/data/model/fetch_chat.dart';


class PusherService {
  late PusherChannelsFlutter pusher;
  final Function(DataMessages) onNewMessage;
  String APP_ID = "1920896";
  String API_KEY = "904e38772f4148efce13";
  String SECRET = "8626dccb122c9fb34c6d";
  String API_CLUSTER = "eu";

  PusherService({required this.onNewMessage});

  Future<void> initPusher(String roomId) async {
    try {
      pusher = PusherChannelsFlutter.getInstance();

      await pusher.init(
        apiKey: API_KEY,
        cluster: API_CLUSTER,
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
      );

      // Subscribe to the channel
      await pusher.subscribe(channelName: "conversation.${roomId}");
      // dynamic channel =await pusher.subscribe(channelName: "conversation.${roomId}");
      //
      // channel.bind('MessageSent', (PusherEvent event) {
      //   print('Received MessageSent Event: ${event.data}');
      // });
      // Listen to events on that channel
      // await pusher.onError!(roomId, eventName: "message", callback: onEvent);

      await pusher.connect();
    } catch (e) {
      log("Error initializing Pusher: $e");
    }
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    log("Connection state changed from $previousState to $currentState");
  }

  void onError(String message, int? code, dynamic exception) {
    log("Pusher error: $message, code: $code, exception: $exception");
  }

  void onEvent(PusherEvent event) {
    log("Event received: ${event.data}");
    if (event.eventName == "message.send") {
      try {
        final data = jsonDecode(event.data!);
        final message = DataMessages.fromJson(data["data"]);
        log("Event received44444444444444444444444444: ${message}");
        onNewMessage(message);
      } catch (e) {
        log("Error processing message: $e");
      }
    }
  }

  void disconnect() {
    pusher.disconnect();
  }
}
