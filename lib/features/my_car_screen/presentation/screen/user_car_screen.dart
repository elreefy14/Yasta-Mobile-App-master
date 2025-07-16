import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/componant/empty_state_screen.dart';
import 'package:yasta/features/center_profile/presentation/screen/center_profile.dart';
import 'package:yasta/features/my_car_screen/logic/cubit/car_cubit.dart';
import 'package:yasta/features/my_car_screen/logic/model/show_car_model.dart';
import 'package:yasta/features/my_car_screen/presentation/screen/user_not_registered_car_data.dart';
import '../../../../core/componant/user_image_widget.dart';
import '../../../../core/helper/spacing/spacing.dart';
import '../../../../core/route/route_strings/route_strings.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../preview_data_layout/presentation/screen/preview_data_layout.dart';
import '../../../preview_data_layout/presentation/widgets/preview_data_item.dart';
import '../widgets/labeled_info_row.dart';

class UserCarScreen extends StatefulWidget {
  const UserCarScreen({super.key});

  @override
  State<UserCarScreen> createState() => _UserCarScreenState();
}

class _UserCarScreenState extends State<UserCarScreen>with RouteAware {
  @override
  void initState() {
    // TODO: implement initState
    CarCubit.get(context).showAllCar();
    super.initState();
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
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    // Called when returning to this page
    // Refresh data
    CarCubit.get(context).showAllCar();
    setState(() {

    }); // Trigger a rebuild if necessary
  }
  List<Data> carResponse = [];

  @override
  Widget build(BuildContext context) {
    return PreviewDataLayout(
      appBarTitle: getLang(context, "car data").toString(),
      children: [
        BlocConsumer<CarCubit, CarState>(
          listener: (context, state) {
            if (state is CarSuccessState) {
              carResponse = state.data!.data!;
            }
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is CarLoadingState) {
              return const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return carResponse.isEmpty
                ? EmptyStateScreen(
                    backgroundColor: AppColors.gray100,
                    buttonText: getLang(context, "Add your car").toString(),
                    message: getLang(context,
                            "Your car details have not been entered yet.")
                        .toString(),
                    onButtonPressed: () {
                      Navigator.pushNamed(
                          context, RouteStrings.addCarDataScreen);
                    },
                    lottieAnimation: 'assets/lottie/not_found.json',
                  )
                : SizedBox(
                    height: 700.h,
                    child: ListView.builder(
                      itemCount: carResponse.length,
                      // Total number of items in the list
                      itemBuilder: (context, index) {
                        return PreviewDataItem(
                          updateTap: () async {
                            final result = await Navigator.pushNamed(
                              context,
                              RouteStrings.updateCarDataScreen,
                              arguments: {
                                "showCarResponse" : carResponse[index],
                              }
                            );

                            if (result == true) {
                              // Reload the car data if the update was successful
                              CarCubit.get(context).showAllCar();
                            }
                          },
                          title: getLang(context, "My car data").toString(),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LabeledInfoRow(
                                  label: getLang(context, "Brand:"),
                                  value:
                                      carResponse[index].brand!.name.toString(),
                                ),
                                LabeledInfoRow(
                                  label: getLang(context, "Model:"),
                                  value:
                                      carResponse[index].model!.name.toString(),
                                ),
                                LabeledInfoRow(
                                  label:
                                      getLang(context, "Year of manufacture:"),
                                  value:
                                      carResponse[index].year!.year.toString(),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
          },
        ),
      ],
    );
  }
}
