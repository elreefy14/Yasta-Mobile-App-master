part of 'select_location_map_cubit.dart';

@immutable
sealed class SelectLocationMapState {}

final class SelectLocationMapInitial extends SelectLocationMapState {}

class InitialSelectLocationMapState extends SelectLocationMapState {}

class ChangeLocationSelectLocationMapState extends SelectLocationMapState {}

class GetMyLocationSelectLocationMapState extends SelectLocationMapState {}

class GetMyLocationUpDateSelectLocationMapState extends SelectLocationMapState {}

class CarSpeedSelectLocationMapState extends SelectLocationMapState {}

class ChangeBuscandoFlagSelectLocationMapState extends SelectLocationMapState {}

class LoadingCreateAlertSelectLocationMapState extends SelectLocationMapState {}

class SuccessCreateAlertSelectLocationMapState extends SelectLocationMapState {}

class ErrorCreateAlertSelectLocationMapState extends SelectLocationMapState {
  final String error;

  ErrorCreateAlertSelectLocationMapState(this.error);
}

class LoadingSendNotificationSelectLocationMapState extends SelectLocationMapState {}

class SuccessSendNotificationSelectLocationMapState extends SelectLocationMapState {}

class ErrorSendNotificationSelectLocationMapState extends SelectLocationMapState {
  final String error;

  ErrorSendNotificationSelectLocationMapState(this.error);
}

class LoadingGetAddressSelectLocationMapState extends SelectLocationMapState {}

class SuccessGetAddressSelectLocationMapState extends SelectLocationMapState {}
class SuccessGetDestinationAddressSelectLocationMapState extends SelectLocationMapState {}

class ErrorGetAddressSelectLocationMapState extends SelectLocationMapState {
  final String error;

  ErrorGetAddressSelectLocationMapState(this.error);
}

class OpenTripContainerSelectLocationMapState extends SelectLocationMapState {}

class CloseTripContainerSelectLocationMapState extends SelectLocationMapState {}



class CalcPriceAndTimeDistanceLoadingState extends SelectLocationMapState {}


class CalcPriceAndTimeDistanceErrorState extends SelectLocationMapState {
  final String error;

  CalcPriceAndTimeDistanceErrorState({required this.error});
}



class RideRequestLoadingState extends SelectLocationMapState {}


class RideRequestErrorState extends SelectLocationMapState {
  final String error;

  RideRequestErrorState({required this.error});
}



class CancelRideRequestPassengerLoadingState extends SelectLocationMapState {}


class CancelRideRequestPassengerErrorState extends SelectLocationMapState {
  final String error;

  CancelRideRequestPassengerErrorState({required this.error});
}



final class GetCategoryOfVehicleLoading extends SelectLocationMapState {}


final class GetCategoryOfVehicleFailure extends SelectLocationMapState {
  final String message;
  GetCategoryOfVehicleFailure({required this.message});
}
