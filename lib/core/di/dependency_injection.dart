import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:yasta/features/auth/logic/auth_cubit/auth_cubit.dart';
import 'package:yasta/features/favourite_screen/logic/favorite_cubit.dart';
import 'package:yasta/features/update_workshop_center_profile/data/logic/update_center_cubit.dart';

import '../../features/auth/service_provider_screens/sign_up_screen/logic/select_location_map_cubit.dart';
import '../../features/chat_screen/data/logic/chat_cubit.dart';
import '../../features/map_screen/logic/map_cubit.dart';
import '../../features/messages_screen/data/logic/message_cubit.dart';
import '../../features/my_car_screen/logic/cubit/car_cubit.dart';
import '../../features/search/logic/search_cubit.dart';
import '../../features/user_profile_screen/logic/user_profile_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio & ApiService

  // login
  getIt.registerLazySingleton<UserProfileCubit>(() => UserProfileCubit());
  getIt.registerLazySingleton<MapCubit>(() => MapCubit());
  getIt.registerLazySingleton<SearchCubit>(() => SearchCubit());
  getIt.registerLazySingleton<SelectLocationMapCubit>(() => SelectLocationMapCubit());
  getIt.registerLazySingleton<FavoriteCubit>(() => FavoriteCubit());
  getIt.registerLazySingleton<AuthCubit>(() => AuthCubit());
  getIt.registerLazySingleton<CarCubit>(() => CarCubit());
  getIt.registerLazySingleton<ChatCubit>(() => ChatCubit());
  getIt.registerLazySingleton<MessageCubit>(() => MessageCubit());
  getIt.registerLazySingleton<UpdateCenterCubit>(() => UpdateCenterCubit());

}
