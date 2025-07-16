import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/componant/circular_icon_button.dart';
import 'package:yasta/core/componant/custom_app_bar.dart';
import 'package:yasta/core/componant/icon_with_text.dart';
import 'package:yasta/core/componant/user_image_widget.dart';
import 'package:yasta/core/di/dependency_injection.dart';
import 'package:yasta/core/helper/app_color/app_color.dart';
import 'package:yasta/core/helper/cache_helper/cache_helper.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';
import 'package:yasta/core/theme/colors.dart';
import 'package:yasta/core/theme/text_styles.dart';
import 'package:yasta/features/center_profile/data/models/show_workshop_schedules_response.dart';
import 'package:yasta/features/center_profile/data/models/show_workshop_socials_response.dart';
import 'package:yasta/features/center_profile/presentation/widget/date_for_work.dart';
import 'package:yasta/features/center_profile/presentation/widget/image_and_centerName.dart';
import 'package:yasta/features/center_profile/presentation/widget/model.dart';
import 'package:yasta/features/center_profile/presentation/widget/our_service.dart';
import 'package:yasta/features/center_profile/presentation/widget/photo_album.dart';
import 'package:yasta/features/center_profile/presentation/widget/update_and_share_button.dart';
import 'package:yasta/features/center_profile/presentation/widget/update_widget.dart';
import 'package:yasta/features/favourite_screen/presentation/widgets/workshop_location.dart';
import 'package:yasta/features/update_workshop_center_profile/data/logic/update_center_cubit.dart';
import 'package:yasta/features/update_workshop_center_profile/presentation/widgets/card_template.dart';
import 'package:yasta/features/workshop_profile/logic/work_shop_for_reviews_cubit.dart';
import 'package:yasta/features/workshop_profile/model/get_workshop_byId_response.dart'
    as GetWorkshopByIdResponse;
import '../../../../core/componant/empty_state_screen.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/route/route_strings/route_strings.dart';
import '../../data/models/show_workshop_data_response.dart';
import '../../data/models/show_workshop_models_response.dart';
import '../../data/models/show_workshop_services_response.dart';
import '../../logic/center_profile_cubit.dart';
import '../widget/icon_for_connect.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class CenterProfile extends StatefulWidget {
  const CenterProfile({super.key});

  @override
  State<CenterProfile> createState() => _CenterProfileState();
}

class _CenterProfileState extends State<CenterProfile> with RouteAware {
  GetWorkshopByIdResponse.GetWorkshopByIdResponse data =
      GetWorkshopByIdResponse.GetWorkshopByIdResponse();

  @override
  void initState() {
    super.initState();
    _fetchWorkshopData();
    getIt<UpdateCenterCubit>().selectedWorkshopServices.clear();
    getIt<UpdateCenterCubit>().selectedAllModel.clear();
  }

  void _fetchWorkshopData() {
    final workshopId = CacheHelper.getdata(key: "workshop_id");
    if (workshopId != "") {
      WorkShopForReviewsCubit.get(context).getWorkshopDataById(id: workshopId);
    }


  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getIt<UpdateCenterCubit>().selectedWorkshopServices.clear();
    getIt<UpdateCenterCubit>().selectedAllModel.clear();
    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      routeObserver.subscribe(this, route); // Subscribe to the route
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    // Called when returning to this page
    _fetchWorkshopData();
    getIt<UpdateCenterCubit>().selectedWorkshopServices.clear();
    getIt<UpdateCenterCubit>().selectedAllModel.clear();// Refresh data
    setState(() {
      getIt<UpdateCenterCubit>().selectedWorkshopServices.clear();
      getIt<UpdateCenterCubit>().selectedAllModel.clear();
    }); // Trigger a rebuild if necessary
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorsManager.gray300,
        appBar: CustomAppBar(
          title: getLang(context, "Center Profile").toString(),
        ),
        body: CacheHelper.getdata(key: "workshop_id") == ""
            ? EmptyStateScreen(
                backgroundColor: ColorsManager.gray300,
                buttonText: getLang(context, "Add your workshop").toString(),
                message:
                    getLang(context, "You have not registered a workshop yet.")
                        .toString(),
                onButtonPressed: () {
                  Navigator.pushNamed(
                    context,
                    RouteStrings.addWorkshopData,
                  );
                },
                lottieAnimation: 'assets/lottie/not_found.json',
              )
            : BlocConsumer<WorkShopForReviewsCubit, WorkShopForReviewsState>(
                listener: (context, state) {
                  // TODO: implement listener
                  if (state is GetWorkshopDatByIdSuccessState) {
                    data = state.data!;
                    getIt<UpdateCenterCubit>().imagesAlbum = data.data!.images!;
                  }
                },
                builder: (context, state) {
                  // if (state is GetWorkshopDatByIdErrorState) {
                  //   return EmptyStateScreen(
                  //     backgroundColor: ColorsManager.gray300,
                  //     buttonText: getLang(context, "Add your workshop").toString(),
                  //     message: getLang(context, "You have not registered a workshop yet.")
                  //         .toString(),
                  //     onButtonPressed: () {
                  //       Navigator.pushNamed(
                  //         context,
                  //         RouteStrings.serviceProviderSignUpScreen,
                  //       );
                  //     },
                  //     lottieAnimation: 'assets/lottie/not_found.json',
                  //   );
                  // }
                  return data.data == null
                      ? const Center(child: CircularProgressIndicator())
                      : Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Constants.hPadding, vertical: 44.h),
                          child: Column(
                            children: [
                              // UpdateAndShareButton(
                              //   workshopId: data.data?.id ?? 1,
                              //   showWorkshopDataResponse: data,
                              // ),
                              verticalSpace(20.h),
                              Flexible(
                                child: ListView(
                                  shrinkWrap: true,
                                  // Make the ListView as small as possible
                                  // physics: NeverScrollableScrollPhysics(),
                                  children: [
                                    BlocBuilder<UpdateCenterCubit,
                                        UpdateCenterState>(
                                      builder: (context, state) {
                                        return CardTemplate(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  RouteStrings
                                                      .updateWorkshopData,
                                                  arguments: data,
                                                );
                                              },
                                              child: UpdateWidget(),
                                            ),
                                            ImageAndCenterName(
                                              imageUrl: data.data!.image!,
                                              centerName: data.data!.name!,
                                            ),
                                            verticalSpace(20.h),
                                            WorkshopLocation(
                                              location:
                                                  data.data!.address ?? "",
                                              icon: "location_icon.svg",
                                            ),
                                            verticalSpace(20.h),
                                            IconWithText(
                                              text: data.data!.phone ?? "",
                                              icon: "phone_icon.svg",
                                            ),
                                            verticalSpace(20.h),
                                            Text(
                                              getLang(context, "Description")
                                                  .toString(),
                                              style: TextStyles
                                                  .gray950FS18FW500TextStyle,
                                            ),
                                            verticalSpace(5),
                                            Text(
                                              data.data!.description ?? "",
                                              style: TextStyles
                                                  .gray800FS16FW500CairoTextStyle,
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                    verticalSpace(20.h),
                                    BlocBuilder<UpdateCenterCubit,
                                        UpdateCenterState>(
                                      builder: (context, state) {
                                        return CardTemplate(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.pushNamed(context,
                                                    RouteStrings.updateSchedule,
                                                    arguments: {
                                                      "schedules":
                                                          data.data!.schedule ??
                                                              []
                                                    });
                                              },
                                              child: UpdateWidget(),
                                            ),
                                            DateForWork(
                                              schedules:
                                                  data.data!.schedule ?? [],
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                    verticalSpace(20.h),
                                    CardTemplate(
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                RouteStrings.updateSocialData,
                                              );
                                            },
                                            child: UpdateWidget()),
                                        IconForConnect(
                                          socialMediaData:
                                              data.data!.socials ?? [],
                                        ),
                                      ],
                                    ),
                                    verticalSpace(20.h),
                                    CardTemplate(
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                RouteStrings.updatePhotoAlbum,
                                              );
                                            },
                                            child: UpdateWidget()),
                                        PhotoAlbum(
                                          images: data.data!.images!
                                              .map((e) => e.image!)
                                              .toList(),
                                        ),
                                      ],
                                    ),
                                    verticalSpace(20.h),
                                    CardTemplate(
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                RouteStrings
                                                    .updateWorkshopServices,
                                              );
                                            },
                                            child: UpdateWidget()),
                                        OurService(
                                          services: data.data!.services ?? [],
                                        ),
                                      ],
                                    ),
                                    verticalSpace(20.h),
                                    CardTemplate(
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                RouteStrings
                                                    .updateWorkshopModel,
                                              );
                                            },
                                            child: UpdateWidget()),
                                        ModelCatloge(
                                            data: data.data!.brands ?? []),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                },
              ),
      ),
    );
  }
}
