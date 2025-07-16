import 'package:flutter/material.dart';

import 'header_of_place_widget.dart';
import 'loading_of_place_header_widget.dart';

class MarkerOfUserOnMapWidget extends StatelessWidget {
  const MarkerOfUserOnMapWidget(
      {super.key, required this.buscando, required this.header});

  final bool buscando;
  final String header;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buscando == true
              ? HeaderOfPlaceWidget(
            header: header,
          )
              : LoadingOfPlaceHeaderWidget(),
          // _getMarker(),
          Image.asset(
            "assets/image/markeruser.png",
            height: 150,
          ),
        ],
      ),
    );
  }
}
