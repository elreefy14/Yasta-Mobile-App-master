import 'package:flutter/material.dart';

class LoadingOfPlaceHeaderWidget extends StatelessWidget {
  const LoadingOfPlaceHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 17, vertical: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.blue[600]),
      width: 48,
      height: 38,
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.white),
          strokeWidth: 2.6,
        ),
      ),
    );
  }
}
