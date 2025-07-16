import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/helper/cache_helper/cache_helper.dart';

import '../../../core/route/route_strings/route_strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Define the duration for which the splash screen should be displayed
    print(CacheHelper.getdata(key: "token") );
    print(CacheHelper.getdata(key: "stage") == "2") ;
    print(CacheHelper.getdata(key: "stage") ) ;
    print(CacheHelper.getdata(key: "stage") == "complete"|| CacheHelper.getdata(key: "stage") == null) ;
    Future.delayed(const Duration(seconds: 3), () {
      if (CacheHelper.getdata(key: "onBoarding") == true) {
        if (CacheHelper.getdata(key: "token") != null) {
          if (CacheHelper.getdata(key: "userType") == "user") {



              Navigator.pushReplacementNamed(
                context,
                RouteStrings.homeLayoutScreen,
                arguments: {
                  "isGuest": false,
                  "isUser": true,
                },
              );

          } else {
            String? stage = CacheHelper.getdata(key: "stage");
            if (stage == "2") {
              Navigator.pushReplacementNamed(
                context,
                RouteStrings.addServiceAndModel,
              );
            } else if (stage == "3") {
              Navigator.pushReplacementNamed(
                context,
                RouteStrings.addScheduleData,
              );
            }else if (stage == "4") {
              Navigator.pushReplacementNamed(
                context,
                RouteStrings.addSocialsData,
              );
            }
            else{
            Navigator.pushReplacementNamed(
              context,
              RouteStrings.homeLayoutScreen,
              arguments: {
                "isGuest": false,
                "isUser": false,
              },
            );
          }}
        } else {
          Navigator.pushReplacementNamed(
            context,
            RouteStrings.serviceType,
          );
        }
      } else {
        Navigator.pushReplacementNamed(context, RouteStrings.onboardingScreen);
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.grey[200],
      // Customize the appearance of your splash screen
      body: Center(
        child: Image.asset("assets/image/test.png"),
        // child: Text(getLang(context, "CAR SERVICES").toString(),
        //     style: TextStyle(
        //         fontSize: 40.sp,
        //         fontWeight: FontWeight.w400,
        //         fontFamily: 'Darumadrop One',
        //         color: const Color(0xFF6BB56B))),
      ),
    );
  }
}
