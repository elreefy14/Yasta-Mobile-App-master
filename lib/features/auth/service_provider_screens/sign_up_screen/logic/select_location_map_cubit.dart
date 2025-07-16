import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocode/geocode.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:meta/meta.dart';

part 'select_location_map_state.dart';

class SelectLocationMapCubit extends Cubit<SelectLocationMapState> {

  //

  SelectLocationMapCubit() : super(SelectLocationMapInitial()) {}

  static SelectLocationMapCubit get(context) => BlocProvider.of(context);
  void changeLocation(
      LatLng lat,
      ) {
    this.mapLocation = lat;
    animateCamera();
  }
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

  void getMyLocation() {
    location.getLocation().then((value) {
      print('get location');
      changeLocation(
        LatLng(value.latitude!, value.longitude!),
      );
      // firebaseRepo.saveUserLocation(
      //     lat: value.latitude ?? 0, lng: value.longitude ?? 0, speed: 0);
      animateCamera();
      return LatLng(value.latitude!, value.longitude!);
    });
  }
  String selectedCategoryName = ""; // To hold the selected trip type name

  LatLng mapLocation = const LatLng(0, 0);

  bool locationButtonFlag = false;

  Completer<GoogleMapController> controller = Completer();
  Location location = Location();
  bool buscando = false;
  var zoomLevel = 17.0;
  var mapBearing = 0.0;


  String address = 'No Address Found';

  String destinationAddress = 'No Address Found';
  bool destinationBuscando = false;
  LatLng destinationLocation = const LatLng(0, 0);

  void setDestination(LatLng latLng) {
    destinationLocation = latLng;
    getDestinationAddress(lat: latLng.latitude, lng: latLng.longitude);
  }

  int streetNumber = 0;
  GeoCode geoCode = GeoCode();

  getDestinationAddress({
    required double lat,
    required double lng,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    geoCode.reverseGeocoding(latitude: lat, longitude: lng).then((value) {
      destinationAddress = value.streetAddress.toString();
      destinationBuscando = true;
      emit(SuccessGetDestinationAddressSelectLocationMapState());
    });
  }
  void changeLocationButtonFlag(bool flag) {
    locationButtonFlag = flag;
  }

  void changeBuscandoFlag(bool flag) {
    buscando = flag;
    emit(ChangeBuscandoFlagSelectLocationMapState());
  }

  void changeBuscandoFlagForDestination(bool flag) {
    destinationBuscando = flag;
    emit(ChangeBuscandoFlagSelectLocationMapState());
  }

  void openTripContainer() {
    emit(OpenTripContainerSelectLocationMapState());
  }

  Future<void> closeTripContainer() async {
    emit(CloseTripContainerSelectLocationMapState());
  }


}
