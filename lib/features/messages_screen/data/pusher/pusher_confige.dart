import 'dart:developer';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../../../core/helper/cache_helper/cache_helper.dart';
class PusherConfig {
  late PusherChannelsFlutter _pusher;

  String APP_ID = "1920896";
  String API_KEY = "904e38772f4148efce13";
  String SECRET = "8626dccb122c9fb34c6d";
  String API_CLUSTER = "eu";

  Future<void> initPusher(Function(PusherEvent) onEvent,) async {
    _pusher = PusherChannelsFlutter.getInstance();

    try {
      await _pusher.init(
        apiKey: API_KEY,
        cluster: API_CLUSTER,
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
        onDecryptionFailure: onDecryptionFailure,
        onMemberAdded: onMemberAdded,
        onMemberRemoved: onMemberRemoved,
      );

      await _pusher.subscribe(
        channelName: "conversation.auth.${CacheHelper.getdata(key:"id")}",
      );

      log("Subscribed to channel: conversation.${CacheHelper.getdata(key:"id")}");

      await _pusher.connect();
    } catch (e) {
      log("Error in Pusher initialization: $e");
    }
  }

  void disconnect() {
    _pusher.disconnect();
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    log("Connection state: $currentState");
  }

  void onError(String message, int? code, dynamic e) {
    log("Pusher Error: $message, code: $code, exception: $e");
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    log("Subscription succeeded: $channelName, data: $data");
  }

  void onSubscriptionError(String message, dynamic e) {
    log("Subscription error: $message, exception: $e");
  }

  void onDecryptionFailure(String event, String reason) {
    log("Decryption failure: $event, reason: $reason");
  }

  void onMemberAdded(String channelName, PusherMember member) {
    log("Member added: $channelName, member: $member");
  }

  void onMemberRemoved(String channelName, PusherMember member) {
    log("Member removed: $channelName, member: $member");
  }
}


