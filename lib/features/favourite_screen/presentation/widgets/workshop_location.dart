import 'package:flutter/material.dart';
import '../../../../core/componant/icon_with_text.dart';

class WorkshopLocation extends StatelessWidget {
  const WorkshopLocation({super.key, required this.location, required this.icon});

  final String location ;
  final String icon ;

  @override
  Widget build(BuildContext context) {
    return IconWithText(
      text: location,
      icon: icon,
    );
  }
}
