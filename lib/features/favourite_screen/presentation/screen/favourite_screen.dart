import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:yasta/core/di/dependency_injection.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';
import 'package:yasta/features/chat_screen/data/logic/chat_cubit.dart';
import 'package:yasta/features/favourite_screen/logic/favorite_cubit.dart';
import '../../../../core/app_local/app_local.dart';
import '../../../../core/componant/custom_app_bar.dart';
import '../../../../core/componant/work_shop_card.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/route/route_strings/route_strings.dart';
import '../../../../core/theme/colors.dart';
import '../../../chat_screen/data/model/start_model.dart';
import '../../data/models/get_favorite_workshops_response.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  List<Data> favoriteWorkshops = [];

  @override
  void initState() {
    getIt<FavoriteCubit>().getFavoriteWorkshops();
    super.initState();
  }

  double _userRating = 3.5;

  // Initial rating value
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: getLang(context, "Favorites").toString(),
        centerTitle: true,
      ),
      body: Column(
        children: [
          BlocListener<ChatCubit, ChatState>(
            listener: (context, state) {
              if (state is StartConversationsSuccessState) {
                Navigator.pushNamed(
                  context,
                  RouteStrings.chatScreen,
                  arguments: {
                    "conversationsId":
                        int.parse(state.data!.data!.id.toString()),
                  },
                );
              }
            },
            child: const SizedBox.shrink(),
          ),
          BlocConsumer<FavoriteCubit, FavoriteState>(
            listener: (context, state) {
              // TODO: implement listener
              if (state is GetFavoriteWorkshopsSuccessState) {
                favoriteWorkshops = state.data.data!;
              }
            },
            builder: (context, state) {
              if (state is GetFavoriteWorkshopsLoadingState) {
                return const Expanded(
                    child: Center(child: CircularProgressIndicator()));
              }
              if (state is GetFavoriteWorkshopsErrorState) {
                return Expanded(
                    child: Center(child: Text(state.message)));
              }
                if (favoriteWorkshops.isEmpty) {
                  return SizedBox(
                    width: double.infinity,
                    height: 400.h,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Lottie.asset("assets/lottie/no_data.json"),
                          Text(
                            'لا يوجد بيانات',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF374151),
                              fontSize: 16,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w500,
                              // height: 0.09,
                            ),
                          ),
                        ],
                      ),
                  );
                } else {
                  return Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                      top: 20.h,
                      right: Constants.hPadding,
                      left: Constants.hPadding,
                    ),
                    color: AppColors.gray100,
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return WorkshopCard(
                          onTap2: () {
                            ChatCubit.get(context).startConversations(
                                startConversationsModel:
                                StartConversationsModel(
                                    workshopId:
                                    favoriteWorkshops[index]
                                        .workshop!
                                        .id));
                          },
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RouteStrings.workshopProfileScreen,
                              arguments: {
                                "workshopId":
                                favoriteWorkshops[index].workshop!.id
                              },
                            );
                          },
                          onRatingUpdate: (p0) {
                            // setState(() {
                            //   _userRating = p0;
                            // });
                          },
                          userRating: double.parse(
                              favoriteWorkshops[index]
                                  .workshop!
                                  .rating
                                  .toString()),
                          workShopDistance: favoriteWorkshops[index]
                              .workshop!
                              .distance
                              .toString(),
                          workShopImage:
                          favoriteWorkshops[index].workshop!.image!,
                          workShopPreviewImage: favoriteWorkshops[index]
                              .workshop!
                              .images!
                              .image!,
                          workShopLocation: favoriteWorkshops[index]
                              .workshop!
                              .address ??
                              "",
                          workShopName:
                          favoriteWorkshops[index].workshop!.name ??
                              "",
                        );
                      },
                      separatorBuilder: (context, index) {
                        return verticalSpace(30);
                      },
                      itemCount: favoriteWorkshops.length,
                    ),
                  ),
                );
                }

            },
          ),
        ],
      ),
    );
  }
}
