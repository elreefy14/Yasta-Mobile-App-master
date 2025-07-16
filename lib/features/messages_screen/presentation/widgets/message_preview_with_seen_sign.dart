import 'package:flutter/material.dart';

import 'message_preview_with_icon.dart';

class MessagePreviewWithSeenSign extends StatelessWidget {
  const MessagePreviewWithSeenSign({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return MessagePreviewWithIcon(
      message: message,
      icon: "assets/icons/seen_icon.svg",
    );
  }
}
