import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/componant/default_button.dart';
import 'package:yasta/core/constants/constants.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';
import 'package:yasta/core/theme/colors.dart';
import 'package:yasta/core/theme/text_styles.dart';
import 'package:yasta/features/center_profile/presentation/screen/center_profile.dart';
import 'package:yasta/features/favourite_screen/data/models/add_favorite_workshop_request_body.dart';
import 'package:yasta/features/workshop_profile/logic/work_shop_for_reviews_cubit.dart';
import 'package:yasta/features/workshop_profile/model/show_all_reviews.dart';
import 'package:yasta/features/workshop_profile/presentation/widgets/custom_header_bar.dart';
import 'package:yasta/features/workshop_profile/presentation/widgets/update_review.dart';
import '../../../../core/componant/review_header.dart';
import '../../../../core/componant/user_review_widget.dart';
import '../../model/get_workshop_byId_response.dart' as GetWorkshopByIdResponse;
import '../widgets/brand_and_model_selector.dart';
import '../widgets/carousel_slider_for_preview_workshop_images.dart';
import '../widgets/review_modal_content.dart';
import '../widgets/workshop_description_and_services.dart';
import '../widgets/workshop_info_section.dart';

class WorkshopProfileScreen extends StatefulWidget {
  const WorkshopProfileScreen({super.key, required this.id});

  final int id;

  @override
  State<WorkshopProfileScreen> createState() => _WorkshopProfileScreenState();
}

class _WorkshopProfileScreenState extends State<WorkshopProfileScreen> with RouteAware{
  String? selectedBrand;
  double rating = 0.0;
  bool showAppBar = false;
  late ScrollController _scrollController;
  List<Data> listReviews = [];
  GetWorkshopByIdResponse.GetWorkshopByIdResponse data =
      GetWorkshopByIdResponse.GetWorkshopByIdResponse();
  List<GetWorkshopByIdResponse.Reviews> reviews = [];

  late WorkShopForReviewsCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = WorkShopForReviewsCubit.get(context);
    cubit.getWorkshopDataById(id: widget.id);
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      routeObserver.subscribe(this, route); // Subscribe to the route
    }
  }



  @override
  void didPopNext() {
    // Called when returning to this page
    cubit = WorkShopForReviewsCubit.get(context);
    cubit.getWorkshopDataById(id: widget.id); // Refresh data
    setState(() {}); // Trigger a rebuild if necessary
  }
  void _scrollListener() {
    // Set the threshold based on the CarouselSlider height
    final threshold = MediaQuery.of(context).size.height * 0.3;
    if (_scrollController.offset >= threshold && !showAppBar) {
      setState(() {
        showAppBar = true;
      });
    } else if (_scrollController.offset < threshold && showAppBar) {
      setState(() {
        showAppBar = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    routeObserver.unsubscribe(this);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<WorkShopForReviewsCubit, WorkShopForReviewsState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is GetWorkshopDatByIdSuccessState) {
            data = state.data!;
            reviews = data.data!.reviews ?? [];
          }
        },
        builder: (context, state) {
          return Scaffold(
            // Conditionally render the AppBar based on the `showAppBar` state
            backgroundColor: Colors.white,
            appBar: showAppBar
                ? AppBar(
                    backgroundColor: AppColors.whiteColor,
                    elevation: 5,
                    centerTitle: true,
                    title: Text(
                      getLang(context, "Ratings").toString(),
                      style: TextStyles.gray950FS18FW500TextStyle,
                    ),
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    actions: [
                      BlocBuilder<WorkShopForReviewsCubit,
                          WorkShopForReviewsState>(
                        builder: (context, state) {
                          if (state is AddFavoriteWorkshopSuccessState) {
                            if (state.data.message ==
                                "favorite has been added successfully!") {
                              return IconButton(
                                  icon: Icon(Icons.favorite, color: Colors.red),
                                  onPressed: () {
                                    cubit.addFavorite(
                                      addFavoriteWorkshopRequestBody:
                                          AddFavoriteWorkshopRequestBody(
                                        workshopId: data.data!.id.toString(),
                                      ),
                                    );
                                    data.data?.checkFavorite = true;
                                  });
                            } else {
                              return IconButton(
                                  icon: Icon(Icons.favorite_border,
                                      color: Colors.grey),
                                  onPressed: () {
                                    cubit.addFavorite(
                                      addFavoriteWorkshopRequestBody:
                                          AddFavoriteWorkshopRequestBody(
                                        workshopId: data.data!.id.toString(),
                                      ),
                                    );
                                    data.data?.checkFavorite = false;
                                  });
                            }
                          }
                          return IconButton(
                            icon: Icon(
                              data.data?.checkFavorite == true
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: data.data?.checkFavorite == true
                                  ? Colors.red
                                  : null,
                            ),
                            onPressed: () {
                              if (data.data?.checkFavorite == true) {
                                cubit.addFavorite(
                                  addFavoriteWorkshopRequestBody:
                                      AddFavoriteWorkshopRequestBody(
                                    workshopId: data.data!.id.toString(),
                                  ),
                                );
                                setState(() {
                                  data.data!.checkFavorite !=
                                      data.data!.checkFavorite!;
                                });
                              } else {
                                cubit.addFavorite(
                                  addFavoriteWorkshopRequestBody:
                                      AddFavoriteWorkshopRequestBody(
                                    workshopId: data.data!.id.toString(),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      ),
                    ],
                  )
                : null,
            body: data.data == null
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // Carousel Slider
                            CarouselSliderForPreviewWorkshopImages(
                              images: data.data!.images!
                                  .map((e) => e.image!)
                                  .toList(),
                            ),

                            // Positioned Buttons at the top of the carousel
                            CustomHeaderBar(
                              onBackPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Container(
                                padding: EdgeInsets.all(0.0.w),
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  border: Border.all(
                                    color: AppColors.gray300,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: BlocBuilder<WorkShopForReviewsCubit,
                                    WorkShopForReviewsState>(
                                  builder: (context, state) {
                                    if (state
                                        is AddFavoriteWorkshopSuccessState) {
                                      if (state.data.message ==
                                          "favorite has been added successfully!") {
                                        return IconButton(
                                            icon: Icon(Icons.favorite,
                                                color: Colors.red),
                                            onPressed: () {
                                              cubit.addFavorite(
                                                addFavoriteWorkshopRequestBody:
                                                    AddFavoriteWorkshopRequestBody(
                                                  workshopId:
                                                      data.data!.id.toString(),
                                                ),
                                              );
                                              data.data?.checkFavorite = true;
                                            });
                                      } else {
                                        return IconButton(
                                            icon: Icon(Icons.favorite_border,
                                                color: Colors.grey),
                                            onPressed: () {
                                              cubit.addFavorite(
                                                addFavoriteWorkshopRequestBody:
                                                    AddFavoriteWorkshopRequestBody(
                                                  workshopId:
                                                      data.data!.id.toString(),
                                                ),
                                              );
                                              data.data?.checkFavorite = false;
                                            });
                                      }
                                    }
                                    return IconButton(
                                      icon: Icon(
                                        data.data?.checkFavorite == true
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: data.data?.checkFavorite == true
                                            ? Colors.red
                                            : null,
                                      ),
                                      onPressed: () {
                                        if (data.data?.checkFavorite == true) {
                                          cubit.addFavorite(
                                            addFavoriteWorkshopRequestBody:
                                                AddFavoriteWorkshopRequestBody(
                                              workshopId:
                                                  data.data!.id.toString(),
                                            ),
                                          );
                                          setState(() {
                                            data.data!.checkFavorite !=
                                                data.data!.checkFavorite!;
                                          });
                                        } else {
                                          cubit.addFavorite(
                                            addFavoriteWorkshopRequestBody:
                                                AddFavoriteWorkshopRequestBody(
                                              workshopId:
                                                  data.data!.id.toString(),
                                            ),
                                          );
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                              // onFavoritePressed: () {
                              //   cubit.addFavorite(
                              //     addFavoriteWorkshopRequestBody:
                              //         AddFavoriteWorkshopRequestBody(
                              //       workshopId: data.data!.id.toString(),
                              //     ),
                              //   );
                              // },
                            ),

                            // Main Content Container
                            Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.3,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: showAppBar
                                      ? BorderRadius.circular(0)
                                      : BorderRadius.only(
                                          topLeft: Radius.circular(30.0.r),
                                          topRight: Radius.circular(30.0.r),
                                        ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Constants.hPadding,
                                    vertical: 40.h,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      WorkshopInfoSection(
                                        rating: double.parse(
                                                data.data!.rating.toString()) ??
                                            0.0,
                                        workshopName: data.data!.name ?? "",
                                        workshopId: data.data!.id ?? 0,
                                        workshopImage: data.data!.image ?? "",
                                        address: data.data!.address ?? "",
                                        phone: data.data!.phone ?? "",
                                        schedule: data.data!.schedule ?? [],
                                        socialMediaData:
                                            data.data!.socials ?? [],
                                        isOpen:data.data!.isOpen! ,
                                      ),
                                      _buildDivider(),
                                      verticalSpace(20),
                                      WorkshopDescriptionAndServices(
                                        workShopDescription:
                                            data.data!.description ?? "",
                                        services: data.data!.services ?? [],
                                      ),
                                      verticalSpace(20),
                                      _buildDivider(),
                                      verticalSpace(20),
                                      BrandAndModelSelector(
                                        brands: data.data!.brands ?? [],
                                      ),
                                      verticalSpace(20),
                                      _buildDivider(),
                                      ReviewHeader(
                                        onTap: () => _showReviewModal(context),
                                      ),
                                      verticalSpace(20),
                                      _buildReviewsList(context),
                                      verticalSpace(30),
                                      BlocListener<WorkShopForReviewsCubit,
                                          WorkShopForReviewsState>(
                                        listener: (context, state) {
                                          if (state is GetReviewsSuccessState) {
                                            setState(
                                              () {
                                                reviews = [];
                                                reviews.addAll(
                                                  state.data!.data!.reviews!
                                                      .map((e) =>
                                                          GetWorkshopByIdResponse
                                                              .Reviews(
                                                            id: e.id,
                                                            username:
                                                                e.username ??
                                                                    "",
                                                            userImage:
                                                                e.userImage ??
                                                                    "",
                                                            rate: e.rate ?? 0,
                                                            // Ensure that rate is never null
                                                            comment:
                                                                e.comment ?? '',
                                                            userId: e.userId ?? 0,
                                                              created_at: e.created_at??""
                                                          ))
                                                      .toList(),
                                                );
                                              },
                                            );
                                          }
                                        },
                                        child: SizedBox.shrink(),
                                      ),
                                      reviews.length > 2
                                          ? DefaultButton1(
                                              backgroundColor:
                                                  AppColors.whiteColor,
                                              textColor: AppColors.gray950,
                                              borderColor: Colors.grey,
                                              onPressed: () {
                                                WorkShopForReviewsCubit.get(
                                                        context)
                                                    .getAllReviews(
                                                        workshopId: widget.id);
                                              },
                                              label: getLang(context, "More")
                                                  .toString(),
                                            )
                                          : SizedBox.shrink(),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        // Rounded Container with scrollable content
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget _buildReviewsList(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: const Divider(),
          ),
          verticalSpace(10),
        ],
      ),
      itemBuilder: (context, index) {
        return UserReviewWidget(listReviews: reviews[index]);
      },
      itemCount: reviews.length,
    );
  }

  void _showReviewModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: AppColors.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0.r)),
      ),
      enableDrag: true,
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) => WorkShopForReviewsCubit(),
          child: ReviewModalContent(
            workshopId: widget.id,
            updateReview: (updateReview) {
              setState(
                () {
                  reviews.add(
                    GetWorkshopByIdResponse.Reviews(
                      id: updateReview.data!.id ?? 0,
                      userId: updateReview.data!.userId ?? 0,
                      username: updateReview.data!.username ?? '',
                      userImage: updateReview.data!.userImage ?? '',
                      rate: updateReview.data!.rate != null
                          ? double.parse(updateReview.data!.rate!).toInt()
                          : 0,
                      comment: updateReview.data!.comment ?? '',
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }



  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: const Divider(),
    );
  }
}
