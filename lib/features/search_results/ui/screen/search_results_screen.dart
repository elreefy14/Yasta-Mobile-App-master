import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yasta/core/componant/custom_app_bar.dart';
import 'package:yasta/core/componant/work_shop_card.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';
import 'package:yasta/features/chat_screen/data/logic/chat_cubit.dart';
import 'package:yasta/features/chat_screen/data/model/start_model.dart';

// import 'package:yasta/features/favourite_screen/data/models/get_favorite_workshops_response.dart';
import 'package:yasta/features/search/logic/search_cubit.dart';
import '../../../../core/app_local/app_local.dart';
import '../../../../core/helper/app_color/app_color.dart';
import '../../../../core/helper/cache_helper/cache_helper.dart';
import '../../../../core/route/route_strings/route_strings.dart';
import '../../../../core/theme/text_styles.dart';
import '../widget/filtter_button.dart';
import '../widget/show_modal_bottom_sheet.dart';
import 'package:yasta/features/search/data/model/get_filtered_workshop_response.dart';

class SearchResultsScreen extends StatefulWidget {
  SearchResultsScreen({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  double _userRating = 3.5;

  List<Data> filteredWorkshopData = [];

  void _sortData(String criteria) {
    setState(() {
      if (criteria == "Top Ratings") {
        filteredWorkshopData.sort((a, b) {
          // Convert `rating` to `double` and handle `null` values
          double aRating = double.tryParse(a.rating?.toString() ?? '') ?? 0.0;
          double bRating = double.tryParse(b.rating?.toString() ?? '') ?? 0.0;
          return bRating.compareTo(aRating); // Sort descending
        });
      } else if (criteria == "From the closest to the farthest") {
        filteredWorkshopData.sort((a, b) {
          // Convert `distance` to `double` and handle `null` values
          double aDistance =
              double.tryParse(a.distance?.toString() ?? '') ?? double.infinity;
          double bDistance =
              double.tryParse(b.distance?.toString() ?? '') ?? double.infinity;
          return aDistance.compareTo(bDistance); // Sort ascending
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    print(widget.data["serviceId"].length);
    print(widget.data);

    SearchCubit.get(context).filterNormalWorkshops(queryParams: {
      "search_text": widget.data["search_text"],
      "latitude": widget.data["addLocationManually"]
          ? widget.data["latitude"]
          : CacheHelper.getdata(key: "latitude"),
      "longitude": widget.data["addLocationManually"]
          ? widget.data["longitude"]
          : CacheHelper.getdata(key: "longitude"),
      // "latitude": "29.9792",
      // "longitude": "31.2357",
      "type": widget.data["type"],
      "serivces": widget.data["serviceId"] != null
          ? widget.data["serviceId"].isNotEmpty
              ? '[${widget.data["serviceId"].join(",")}]'
              : null
          : null,
      "model_id": widget.data["model_id"],
      // "time":""
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: CacheHelper.getdata(key: "lang") == "en"
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ColorsManager.gray100,
          appBar: CustomAppBar(
            title: getLang(context, "Search Results").toString(),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 32.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                            context,
                            RouteStrings.mapResultScreen,
                            arguments: {
                              "data": {
                                "search_text": widget.data["search_text"],
                                "latitude": widget.data["addLocationManually"]
                                    ? widget.data["latitude"]
                                    : CacheHelper.getdata(key: "latitude"),
                                "longitude": widget.data["addLocationManually"]
                                    ? widget.data["longitude"]
                                    : CacheHelper.getdata(key: "longitude"),
                                "type": "map",
                                "addLocationManually":
                                    widget.data["addLocationManually"],
                                "serivces": widget.data["serviceId"] != null
                                    ? widget.data["serviceId"].isNotEmpty
                                        ? '[${widget.data["serviceId"].join(",")}]'
                                        : null
                                    : null,
                                "model_id": widget.data["model_id"],
                              }
                            },
                          );
                          // SearchCubit.get(context).filterMapWorkshops(
                          //   queryParams: {
                          //     // "latitude": widget.data["addLocationManually"]? widget.data["latitude"] : CacheHelper.getdata(key: "latitude"),
                          //     // "longitude": widget.data["addLocationManually"]? widget.data["longitude"] : CacheHelper.getdata(key: "longitude"),
                          //     "latitude": "29.9792",
                          //     "longitude": "31.2357",
                          //     "type": "map",
                          //     "serivces": widget.data["serviceId"].toString(),
                          //     "model_id": widget.data["model_id"],
                          //     // "time":""
                          //   },
                          // );
                        },
                        child: FiltterButton(
                          children: [
                            SvgPicture.asset("assets/icons/map_icon.svg"),
                          ],
                        ),
                      ),
                    ),
                    horizontalSpace(10.w),
                    Expanded(
                      flex: 2,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RouteStrings.searchScreen);
                        },
                        child: FiltterButton(
                          children: [
                            SvgPicture.asset("assets/icons/Frame (4).svg"),
                            horizontalSpace(8.w),
                            Flexible(
                              child: Text(
                                getLang(context, "Filtration").toString(),
                                style: TextStyles.blackFS15FW500TextStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    horizontalSpace(10.w),
                    Expanded(
                      flex: 2,
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            // barrierColor: Colors.grey,
                            backgroundColor: Colors.white,
                            context: context,
                            constraints: BoxConstraints(maxHeight: 250.h),
                            builder: (BuildContext context) {
                              return ShowModalBottomSheet(
                                onSortSelected: (criteria) {
                                  _sortData(criteria);
                                },
                              );
                            },
                          );
                        },
                        child: FiltterButton(
                          children: [
                            SvgPicture.asset("assets/icons/Frame 3.svg"),
                            horizontalSpace(8.w),
                            Flexible(
                              child: Text(
                                getLang(context, "Sort By").toString(),
                                style: TextStyles.blackFS15FW500TextStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                verticalSpace(20.h),
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
                  child: SizedBox.shrink(),
                ),
                BlocConsumer<SearchCubit, SearchState>(
                  listener: (context, state) {
                    // TODO: implement listener
                    if (state is GetFilteredWorkshopSuccessState) {
                      filteredWorkshopData = state.data!.data!;
                    }
                  },
                  builder: (context, state) {
                    if (state is GetFilteredWorkshopLoadingState) {
                      return const Expanded(
                          child: Center(child: CircularProgressIndicator()));
                    }
                    if (state is GetFilteredWorkshopErrorState) {
                      return Expanded(
                          child: Center(child: Text(state.message)));
                    }
                    if (filteredWorkshopData.isEmpty) {
                      return Expanded(
                        child: Center(
                            child: Text(getLang(context, "No Workshops Found")
                                .toString())),
                      );
                    } else {
                      return Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return WorkshopCard(
                              onTap2: () {
                                ChatCubit.get(context).startConversations(
                                    startConversationsModel:
                                        StartConversationsModel(
                                            workshopId: int.parse(
                                                filteredWorkshopData[index]
                                                    .id
                                                    .toString())));
                              },
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RouteStrings.workshopProfileScreen,
                                    arguments: {
                                      "workshopId":
                                          filteredWorkshopData[index].id
                                    });
                              },
                              onRatingUpdate: (p0) {
                                // setState(() {
                                //   _userRating = p0;
                                // });
                              },
                              userRating:
                                  filteredWorkshopData[index].rating != null
                                      ? double.parse(filteredWorkshopData[index]
                                          .rating
                                          .toString())
                                      : 0.0,
                              workShopDistance: filteredWorkshopData[index]
                                  .distance
                                  .toString(),
                              workShopImage:
                                  filteredWorkshopData[index].logo ?? "",
                              workShopPreviewImage:
                                  filteredWorkshopData[index].logo ?? "",
                              workShopLocation:
                                  filteredWorkshopData[index].address ?? "",
                              workShopName:
                                  filteredWorkshopData[index].name ?? "",
                            );
                          },
                          separatorBuilder: (context, index) {
                            return verticalSpace(30);
                          },
                          itemCount: filteredWorkshopData.length,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
