import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yasta/core/theme/colors.dart';

import '../../../../core/componant/work_shop_card.dart';
import '../../../../core/route/route_strings/route_strings.dart';
import '../../../../core/utils/directions_service.dart';
import '../../../chat_screen/data/logic/chat_cubit.dart';
import '../../../chat_screen/data/model/start_model.dart';
import '../../data/models/get_map_workshops_response.dart';
import '../../logic/map_cubit.dart';
import '../widgets/map_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapScreen extends StatefulWidget {
  MapScreen({super.key, required this.isVisible});

  bool isVisible;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class MarkerModel {
  final int id;
  final String title;
  final String address;
  final String type;
  final String workShopImage;
  final String workShopProfileImage;
  final String distance;
  final double rating;
  final LatLng location;

  MarkerModel({
    required this.id,
    required this.title,
    required this.address,
    required this.type,
    required this.workShopImage,
    required this.workShopProfileImage,
    required this.distance,
    required this.location,
    required this.rating,
  });
}

List<MarkerModel> markers = [
  // MarkerModel(
  //   title: 'title1',
  //   type: 'type1',
  //   address: 'address1',
  //   workShopImage: "assets/image/test_image.png",
  //   workShopProfileImage: "assets/image/test_image.png",
  //   distance: '3.7',
  //   rating: 4,
  //   location: const LatLng(29.910106292526795, 31.2937043979764),
  // ),
  // MarkerModel(
  //   title: 'title2',
  //   type: 'type2',
  //   address: 'address2',
  //   distance: '2.5',
  //   workShopImage: "assets/image/test_image.png",
  //   workShopProfileImage: "assets/image/test_image.png",
  //   rating: 3,
  //   location: const LatLng(26.8207, 30.8026),
  // ),
  // MarkerModel(
  //   title: 'title3',
  //   type: 'type3',
  //   address: 'address3',
  //   workShopImage: "assets/image/test_image.png",
  //   workShopProfileImage: "assets/image/test_image.png",
  //   distance: '4.9',
  //   rating: 1,
  //   location: const LatLng(26.8210, 30.8030),
  // ),
];

class _MapScreenState extends State<MapScreen> {
  late MapCubit cubit;
  int? selectedCarIndex; // Index of the selected car marker

  // void onCameraMove(CameraPosition position) {
  //   cubit.zoomLevel = position.zoom;
  //   cubit.mapBearing = position.bearing;
  //   cubit.mapLocation = position.target;
  // }

  void onMapCreated(GoogleMapController controller) {
    cubit.controller.complete(controller);
  }
  void onCameraMove(CameraPosition position) {
    cubit.zoomLevel = position.zoom;
    cubit.mapBearing = position.bearing;
    cubit.mapLocation = position.target;

    // Update the camera position in the cubit for reference
    cubit.cameraPosition = position;
  }



  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // Earth's radius in kilometers

    // Convert degrees to radians
    double dLat = (lat2 - lat1) * (pi / 180);
    double dLon = (lon2 - lon1) * (pi / 180);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1 * (pi / 180)) * cos(lat2 * (pi / 180)) *
            sin(dLon / 2) * sin(dLon / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c; // Distance in kilometers
  }

  LatLng? _lastLocation;

  void onCameraIdle() {
    final currentLocation = cubit.cameraPosition?.target;

    if (currentLocation != null) {
      if (_lastLocation == null ||
          _calculateDistance(
            _lastLocation!.latitude,
            _lastLocation!.longitude,
            currentLocation.latitude,
            currentLocation.longitude,
          ) > 20) {
        // Update the last known location
        _lastLocation = currentLocation;

        // Trigger the API request
        MapCubit.get(context).getMapWorkshops(queryParams: {
          "type": "map",
          "latitude": currentLocation.latitude.toString(),
          "longitude": currentLocation.longitude.toString(),
        });
      }
    }
  }



  // void onMarkerTap(int index) {
  //   setState(() {
  //     selectedCarIndex = index; // Store index of selected marker
  //   });
  // }

  void onMarkerTap(int index) {
    setState(() {
      selectedCarIndex = index; // Store index of selected marker
    });

    // Get directions from current location to selected marker
    // final destination =
    //     markers[index].location; // Get the location of the tapped marker
    // DirectionsService.getDirections(cubit.mapLocation, destination)
    //     .then((route) {
    //   // Here, you can display the route on the map using polylines
    //   _displayRoute(route);
    // });
  }

  /// for directions
  Set<Polyline> _polylines = {};

  @override
  void initState() {
    // TODO: implement initState
    cubit = MapCubit.get(context);
    // MapCubit.get(context).getMyLocation();

    super.initState();
  }

  /// for directions
  // void _displayRoute(List<LatLng> route) {
  //   // Here you would add a polyline to the map using the route coordinates
  //   final polyline = Polyline(
  //     polylineId: PolylineId('route'),
  //     color: Colors.blue,
  //     points: route,
  //     width: 5,
  //   );
  //
  //   setState(() {
  //     _polylines.add(polyline); // Add to the list of polylines to be displayed
  //   });
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    // cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.isVisible
          ? BlocConsumer<MapCubit, MapState>(
              listener: (context, state) {
                // TODO: implement listener
                if (state is ChangeLocationMapState) {
                  MapCubit.get(context).getMapWorkshops(queryParams: {
                    "type": "map",
                    "latitude": state.latLng.latitude.toString(),
                    // "latitude": "29.9792",
                    "longitude": state.latLng.longitude.toString(),
                    // "longitude": "31.2357",
                  });
                }
                if (state is GetMapWorkshopsSuccessState) {
                  setState(() {
                    markers = state.data.data!
                        .map(
                          (e) => MarkerModel(
                            id: e.id!,
                            title: e.name!,
                            type: e.imageMaker!,
                            address: e.address!,
                            workShopImage: e.image!,
                            workShopProfileImage: e.logo!,
                            distance: e.distance.toString(),
                            rating: double.parse(e.rating.toString()),
                            location: LatLng(double.parse(e.latitude!),
                                double.parse(e.longitude!)),
                          ),
                        )
                        .toList();
                  });
                }
              },
              builder: (context, state) {
                return Stack(
                  children: [
                    MapWidget(
                      onCameraIdle: onCameraIdle,
                      polylines: _polylines,
                      onCameraMove: onCameraMove,
                      zoom: 12.0,
                      onCameraMoveStarted: () {},
                      onMapCreated: onMapCreated,
                      target: cubit.mapLocation,
                      cars: markers,
                      onMarkerTap: onMarkerTap, // Pass marker tap handler
                    ),
                    if (selectedCarIndex != null)
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCarIndex = null; // Clear selected marker
                            });
                          },
                        ),
                      ),
                    if (selectedCarIndex !=
                        null) // Show details container if marker is selected
                      Positioned(
                        bottom: 20,
                        left: 20,
                        right: 20,
                        child: _buildDetailsContainer(),
                      ),
                  ],
                );
              },
            )
          : const SizedBox.shrink(),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: AppColors.blackColor,
        onPressed: () {
          // setState(() {
          //   widget.isVisible = !widget.isVisible;
          // });
          Navigator.pushNamed(context, RouteStrings.searchScreen);
        },
        child: const Icon(Icons.search_rounded, color: AppColors.whiteColor),
      ),
    );
  }

  Widget _buildDetailsContainer() {
    final location = markers[selectedCarIndex!];
    return BlocListener<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state is StartConversationsSuccessState) {
          Navigator.pushNamed(
            context,
            RouteStrings.chatScreen,
            arguments: {
              "conversationsId": int.parse(state.data!.data!.id.toString()),
            },
          );
        }
      },
      child: WorkshopCard(
        onTap: () {
          Navigator.pushNamed(context, RouteStrings.workshopProfileScreen,
              arguments: {"workshopId": markers[selectedCarIndex!].id});
        },
        onRatingUpdate: (p0) {},
        onTap2: () {
          ChatCubit.get(context).startConversations(
              startConversationsModel: StartConversationsModel(
                  workshopId:
                      int.parse(markers[selectedCarIndex!].id.toString())));
        },
        userRating: location.rating,
        workShopDistance: location.distance,
        workShopImage: location.workShopProfileImage,
        workShopPreviewImage: location.workShopImage,
        workShopLocation: location.address,
        workShopName: location.title,
      ),
    );
  }
}
