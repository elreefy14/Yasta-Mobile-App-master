import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yasta/core/helper/cache_helper/cache_helper.dart';

import '../../../core/networks/api_exception.dart';
import '../../../core/networks/api_manager.dart';
import '../../../core/networks/api_response.dart';
import '../data/models/get_map_workshops_response.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial());

  static MapCubit get(context) => BlocProvider.of(context);
  CameraPosition? cameraPosition;

  void changeLocation(
    LatLng lat,
  ) {
    this.mapLocation = lat;
    emit(ChangeLocationMapState(latLng: lat));
  }

  LatLng mapLocation = const LatLng(0, 0);

  bool locationButtonFlag = false;

  Completer<GoogleMapController> controller = Completer();

  Future<void> animateCamera() async {
    final GoogleMapController controller = await this.controller.future;
    CameraPosition cameraPosition;
    cameraPosition = CameraPosition(
      target: mapLocation,
      zoom: zoomLevel,
      bearing: mapBearing,
    );
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  Location location = Location();

  bool buscando = false;
  var zoomLevel = 12.0;
  var mapBearing = 0.0;

  getMyLocation() async {
    location.getLocation().then((value) {
      debugPrint('get location');
      changeLocation(
        LatLng(value.latitude!, value.longitude!),
      );
      debugPrint(
        "${value.latitude} and ${value.longitude}",
      );
      CacheHelper.saveData(key: "latitude", value: value.latitude!).then((v) {
        CacheHelper.saveData(key: "longitude", value: value.longitude!);
      });
      // firebaseRepo.saveUserLocation(
      //     lat: value.latitude ?? 0, lng: value.longitude ?? 0, speed: 0);
      animateCamera();
      return LatLng(value.latitude!, value.longitude!);
    });
  }

  // filter/workshops
  getMapWorkshops({required Map<String, dynamic> queryParams}) async {
    emit(GetMapWorkshopsLoadingState());
    try {
      ApiResponse? response = await ApiManager.sendRequest(
        link: 'filter/workshops',
        queryParams: queryParams,
        method: Method.GET,
      );

      // Add debug statement for verification
      debugPrint('Response status: ${response?.data!['status']}');
      debugPrint('Response message: ${response?.data!['message']}');
      // debugPrint('Response data: ${response?.data}');

      if (response != null && response.statusCode == 200) {
        emit(GetMapWorkshopsSuccessState(
            data: GetMapWorkshopsResponse.fromJson(response.data!)));
      } else {
        emit(GetMapWorkshopsErrorState(message: response?.message ?? ''));
      }
    } catch (e) {
      emit(GetMapWorkshopsErrorState(
          message:
              e is ApiException ? e.message : 'An unexpected error occurred'));
    }
  }
}
