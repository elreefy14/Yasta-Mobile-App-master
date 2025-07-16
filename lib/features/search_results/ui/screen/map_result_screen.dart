import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yasta/core/componant/custom_app_bar.dart';
import 'package:yasta/core/di/dependency_injection.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';
import 'package:yasta/features/auth/service_provider_screens/sign_up_screen/presentation/widgets/loading_widget.dart';
import 'package:yasta/features/chat_screen/data/logic/chat_cubit.dart';
import 'package:yasta/features/chat_screen/data/model/start_model.dart';
import 'package:yasta/features/map_screen/presentation/screen/map_screen.dart';

import '../../../../core/app_local/app_local.dart';
import '../../../../core/componant/work_shop_card.dart';
import '../../../../core/helper/cache_helper/cache_helper.dart';
import '../../../../core/route/route_strings/route_strings.dart';
import '../../../map_screen/logic/map_cubit.dart';
import '../../../map_screen/presentation/widgets/map_widget.dart';

class MapResultScreen extends StatefulWidget {
  const MapResultScreen({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  State<MapResultScreen> createState() => _MapResultScreenState();
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

class _MapResultScreenState extends State<MapResultScreen> {
  // late MapCubit cubit;
  int? selectedCarIndex; // Index of the selected car marker

  void onCameraMove(CameraPosition position) {
    getIt<MapCubit>().zoomLevel = position.zoom;
    getIt<MapCubit>().mapBearing = position.bearing;
    getIt<MapCubit>().mapLocation = position.target;
  }

  void onMapCreated(GoogleMapController controller) {
    getIt<MapCubit>().controller.complete(controller);
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
    print(widget.data);
    getIt<MapCubit>().getMapWorkshops(queryParams: {
      "search_text": widget.data["search_text"],
      "latitude": widget.data["addLocationManually"]
          ? widget.data["latitude"]
          : CacheHelper.getdata(key: "latitude"),
      "longitude": widget.data["addLocationManually"]
          ? widget.data["longitude"]
          : CacheHelper.getdata(key: "longitude"),
      // "latitude": "29.9792",
      // "longitude": "31.2357",
      "type": "map",
      "serivces":widget.data["serviceId"] !=null?   widget.data["serviceId"].isNotEmpty
          ? '[${widget.data["serviceId"].join(",")}]'
          : null : null,
      "model_id": widget.data["model_id"],
    });
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
  Widget build(BuildContext context) {
    // cubit = MapCubit.get(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: getLang(context, "Search Results").toString(),
        actions: [
          InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  RouteStrings.searchResultsScreen,
                  arguments: {
                    "data": {
                      "latitude": widget.data["addLocationManually"]
                          ? widget.data["latitude"]
                          : CacheHelper.getdata(key: "latitude"),
                      "longitude": widget.data["addLocationManually"]
                          ? widget.data["longitude"]
                          : CacheHelper.getdata(key: "longitude"),
                      "type": "normal",
                      "addLocationManually": widget.data["addLocationManually"],
                      "serivces":widget.data["serviceId"] !=null?   widget.data["serviceId"].isNotEmpty
                          ? '[${widget.data["serviceId"].join(",")}]'
                          : null : null,
                      "model_id": widget.data["model_id"],
                    }
                  },
                );
              },
              child: SvgPicture.asset(
                "assets/icons/drawer2.svg",
              )),
          horizontalSpace(10),
          horizontalSpace(5),
        ],
      ),
      body: BlocConsumer<MapCubit, MapState>(
        listener: (context, state) {
          // TODO: implement listener
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
          if (state is GetMapWorkshopsLoadingState) {
            showLoadingDialog(context);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              MapWidget(
                onCameraIdle: () {},
                zoom: 12.0,
                polylines: _polylines,
                onCameraMove: onCameraMove,
                onCameraMoveStarted: () {},
                onMapCreated: onMapCreated,
                target: LatLng(
                  widget.data["addLocationManually"]
                      ? widget.data["latitude"]
                      : CacheHelper.getdata(key: "latitude"),
                  widget.data["addLocationManually"]
                      ? widget.data["longitude"]
                      : CacheHelper.getdata(key: "longitude"),
                ),
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
