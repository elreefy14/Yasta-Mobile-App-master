import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yasta/core/di/dependency_injection.dart';
import 'package:yasta/core/route/route_strings/route_strings.dart';
import 'package:yasta/core/theme/colors.dart';
import 'package:yasta/core/theme/text_styles.dart';
import 'package:yasta/features/bot_massage/presentation/screen/bot_chat.dart';
import 'package:yasta/features/drower/presentation/screen/drower.dart';
import 'package:yasta/features/home_layout/presentation/widget/chat_bot_widget.dart';
import 'package:yasta/features/map_screen/logic/map_cubit.dart';
import 'package:yasta/features/user_profile_screen/logic/user_profile_cubit.dart';
import '../../../../core/app_local/app_local.dart';
import '../../../../core/helper/cache_helper/cache_helper.dart';
import '../../../chat_screen/data/logic/chat_cubit.dart';
import '../../../map_screen/presentation/screen/map_screen.dart';
import '../../../my_account_screen/presentation/screen/my_account_not_registered_screen.dart';
import '../../../my_account_screen/presentation/screen/my_account_screen.dart';
import '../../../workshop_account_screen/presentation/screen/workshop_account_screen.dart';

class HomeLayoutScreen extends StatefulWidget {
  const HomeLayoutScreen(
      {super.key, required this.isGuest, required this.isUser});

  final bool isGuest;
  final bool isUser;

  @override
  State<HomeLayoutScreen> createState() => _HomeLayoutScreenState();
}

class _HomeLayoutScreenState extends State<HomeLayoutScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late List<Widget> _screens;

  @override
  // initState() {
  //   _screens = widget.isUser
  //       ? widget.isGuest
  //           ? [
  //               BlocProvider(
  //                 create: (context) => MapCubit()..getMyLocation(),
  //                 child: MapScreen(),
  //               ),
  //               // const Scaffold(),
  //               const BotChat(),
  //               const MyAccountNotRegisteredScreen(),
  //             ]
  //           : [
  //               BlocProvider(
  //                 create: (context) => MapCubit()..getMyLocation(),
  //                 child: MapScreen(),
  //               ),
  //               // const Scaffold(),
  //
  //               const BotChat(),
  //               const MyAccountScreen(),
  //
  //               // const WorkshopAccountScreen(),
  //             ]
  //       : [
  //           BlocProvider(
  //             create: (context) => MapCubit()..getMyLocation(),
  //             child: MapScreen(
  //               isVisible: ,
  //             ),
  //           ),
  //           // const Scaffold(),
  //
  //           const BotChat(),
  //           const WorkshopAccountScreen(),
  //         ];
  //   super.initState();
  // }

  int _selectedIndex = 0;

  void _onBottomNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        // Set the key here
        backgroundColor: AppColors.blackColor,
        appBar: AppBar(
          backgroundColor: AppColors.blackColor,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Row(
            children: [
              BlocBuilder<UserProfileCubit, UserProfileState>(
                builder: (context, state) {
                  return Text(
                    ' ${getLang(context, 'Hello').toString()} ${CacheHelper
                        .getdata(key: "userName").toString() == "null"
                        ? getLang(context, "Guest").toString()
                        : CacheHelper.getdata(key: "userName").toString()} ',
                    style: TextStyles.gray200FS14FW600CairoTextStyle,
                  );
                },
              ),
              Text(
                ' :)',
                style: TextStyles.gray200FS14FW600CairoTextStyle,
              ),
            ],
          ),
          actions: [
            widget.isUser
                ? widget.isGuest
                ? SizedBox.shrink() : SizedBox.shrink() :
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RouteStrings.notificationScreen);
                },
                child: SvgPicture.asset(
                  'assets/icons/bell.svg',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: InkWell(
                onTap: () {
                  _scaffoldKey.currentState
                      ?.openDrawer(); // Open Drawer using key
                },
                child: SvgPicture.asset(
                  'assets/icons/drawer.svg',
                ),
              ),
            ),
          ],
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: widget.isUser
              ? widget.isGuest
              ? [
            MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => getIt<MapCubit>()..getMyLocation(),
                ),
                BlocProvider.value(
                  value: getIt< ChatCubit>(),
                ),
              ],
              child: MapScreen(
                isVisible: _selectedIndex == 0,
              ),
            ),
            // const Scaffold(),
            BlocProvider.value(value: getIt<ChatCubit>(),
              child: const MyAccountNotRegisteredScreen(),
            ),
            const MyAccountNotRegisteredScreen(),
          ]
              : [
            MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => getIt<MapCubit>()..getMyLocation(),
                ),
                BlocProvider.value(
                  value: getIt< ChatCubit>(),
                ),
              ],
              child: MapScreen(
                isVisible: _selectedIndex == 0,
              ),
            ),
            // const Scaffold(),

            BlocProvider.value(value: getIt<ChatCubit>(),
              child: const BotChat(),
            ),
            BlocProvider.value(
              value: getIt<UserProfileCubit>(),
              child: const MyAccountScreen(),
            ),

            // const WorkshopAccountScreen(),
          ]
              : [
            MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => getIt<MapCubit>()..getMyLocation(),
                ),
                BlocProvider.value(
                  value: getIt< ChatCubit>(),
                ),
              ],
              child: MapScreen(
                isVisible: _selectedIndex == 0,
              ),
            ),
            // const Scaffold(),

            BlocProvider.value(value: getIt<ChatCubit>(),
              child: const BotChat(),
            ),
            const WorkshopAccountScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          backgroundColor: Colors.white,
          onTap: _onBottomNavTap,
          selectedItemColor:AppColors.blackColor ,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: TextStyle(
            color: AppColors.blackColor,
            fontSize: 14.sp,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w900,
          ),
          unselectedLabelStyle: TextStyle(
            color:  Colors.red,
            fontSize: 14.sp,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w600,
          ),
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: SvgPicture.asset('assets/icons/unselected_home.svg'),
              activeIcon: SvgPicture.asset('assets/icons/selected_home.svg'),
              label: getLang(context, "Home page").toString(),

              tooltip: getLang(context, "Home page").toString(),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: SvgPicture.asset('assets/icons/unselected_robot.svg'),
              activeIcon: SvgPicture.asset('assets/icons/selected_robot.svg'),
              label: getLang(context, "Your Assistant").toString(),
              tooltip: getLang(context, "Your Assistant").toString(),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: SvgPicture.asset('assets/icons/unselected_profile.svg'),
              activeIcon: SvgPicture.asset('assets/icons/selected_profile.svg'),
              label: getLang(context, "My account").toString(),
              tooltip: getLang(context, "My account").toString(),
            ),
          ],
        ),
        drawer: AppDrawer(), // Add drawer here
      ),
    );
  }
}
