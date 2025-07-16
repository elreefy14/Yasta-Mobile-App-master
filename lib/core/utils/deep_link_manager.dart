import 'package:app_links/app_links.dart';
import 'package:flutter/cupertino.dart';

import '../../main.dart';
import '../route/route_strings/route_strings.dart';

class DeepLinkManager {
  static init() async {
    final appLinks = AppLinks();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        final initialUri = await appLinks.getInitialLink();
        if (initialUri != null) {
          print("Initial deep link: ${initialUri.toString()}");
          handleLink(initialUri);
        }
      } catch (err) {
        print("Failed to get initial deep link: $err");
      }
    });

    appLinks.uriLinkStream.listen(
          (uri) {
        print("Deep link received: ${uri.toString()}");
        handleLink(uri);
      },
      onError: (err) {
        print("Failed to process deep link: $err");
      },
    );
  }

  static handleLink(Uri uri) {
    print("Deep link received: ${uri.toString()}");

    // التأكد أن الرابط من `ifastnet.com`
    if (uri.host == "yasta.megatron-soft.com") {
      int? workshopId = int.tryParse(uri.queryParameters['workshopId'] ?? "");
      if (workshopId != null && workshopId > 0) {
        navigatorKey.currentState?.pushReplacementNamed(
          RouteStrings.workshopProfileScreen,
          arguments: {"workshopId": workshopId},
        );
      } else {
        print("Invalid or missing workshopId in deep link");
      }
    } else {
      print("Unhandled host: ${uri.host}");
    }
  }

}
