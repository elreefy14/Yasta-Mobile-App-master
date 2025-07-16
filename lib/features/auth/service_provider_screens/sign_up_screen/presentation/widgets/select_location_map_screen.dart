import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yasta/features/auth/service_provider_screens/sign_up_screen/logic/select_location_map_cubit.dart';
import '../../../../../map_screen/presentation/widgets/map_widget.dart';
import 'marker_of_user_on_map_widget.dart';

class SelectLocationMapScreen extends StatefulWidget {
  final SelectLocationMapCubit selectLocationMapCubit;
  LatLng? selectedDestination;

  SelectLocationMapScreen(
      {required this.selectLocationMapCubit,
      required this.selectedDestination});

  @override
  _SelectLocationMapScreenState createState() =>
      _SelectLocationMapScreenState();
}

class _SelectLocationMapScreenState extends State<SelectLocationMapScreen> {
  GoogleMapController? mapController;

  @override
  void initState() {
    // TODO: implement initState
    SelectLocationMapCubit.get(context).getMyLocation();
    super.initState();
  }

  void onCameraIdle() {
    widget.selectLocationMapCubit.openTripContainer();
    if (widget.selectedDestination != null) {
      // widget.selectLocationMapCubit.getDestinationAddress(
      //   lat: selectedDestination!.latitude,
      //   lng: selectedDestination!.longitude,
      // );
      widget.selectLocationMapCubit.setDestination(
        LatLng(
          widget.selectedDestination!.latitude,
          widget.selectedDestination!.longitude,
        ),
      );
    }
  }

  void onCameraMove(CameraPosition position) {
    widget.selectedDestination = position.target;
  }

  void onCameraMoveStarted() {
    widget.selectLocationMapCubit.changeBuscandoFlagForDestination(false);
    widget.selectLocationMapCubit.closeTripContainer().then((value) {});
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;

    // Check if the Completer is already completed
    if (!widget.selectLocationMapCubit.controller.isCompleted) {
      widget.selectLocationMapCubit.controller.complete(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Select Destination"),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              if (widget.selectedDestination != null) {
                // Return the selected LatLng to the previous screen
                Navigator.pop(context, widget.selectedDestination);
              }
            },
          )
        ],
      ),
      body: Stack(
        children: [
          BlocConsumer<SelectLocationMapCubit, SelectLocationMapState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Stack(
                children: [
                  MapWidget(
                    cars: [],
                    target: widget.selectLocationMapCubit.mapLocation,
                    polylines: {},
                    onMarkerTap: (p0) {},
                    zoom: 12,
                    // Use the selectLocationMapCubit to get the initial mapLocation
                    // When the map is created
                    onMapCreated: onMapCreated,
                    // Called when camera movement starts
                    onCameraMoveStarted: onCameraMoveStarted,

                    // Called when the camera moves (e.g., user drags the map)
                    onCameraMove: onCameraMove,

                    // Called when the camera stops moving
                    onCameraIdle: onCameraIdle,
                  ),
                  Center(
                    child: MarkerOfUserOnMapWidget(
                      buscando:
                          widget.selectLocationMapCubit.destinationBuscando,
                      header: widget.selectLocationMapCubit.destinationAddress,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
