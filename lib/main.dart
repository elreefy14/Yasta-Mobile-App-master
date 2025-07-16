import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yasta/features/center_profile/presentation/screen/center_profile.dart';
import 'core/app_cubit/app_cubit.dart';
import 'core/app_local/app_local.dart';
import 'core/app_local/change_language_controller.dart';
import 'core/di/dependency_injection.dart';
import 'core/helper/bloc_observer/bloc_observer.dart';
import 'core/helper/cache_helper/cache_helper.dart';
import 'core/networks/api_manager.dart';
import 'core/route/route_strings/route_strings.dart';
import 'core/route/router/app_router.dart';
import 'core/theme/colors.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/utils/deep_link_manager.dart';
import 'features/update_workshop_center_profile/presentation/screen/update_schedule.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeApp();
  runApp(MyApp(appRouter: AppRouter()));
}

Future<void> _initializeApp() async {
  await _initializeDependencies();
  await _initializeCache();
}

Future<void> _initializeDependencies() async {
  ApiManager.init();
  Bloc.observer = MyBlocObserver();
  setupGetIt();
}

Future<void> _initializeCache() async {
  try {
    await CacheHelper.init();
  } catch (error) {
    print("Error initializing cache: $error");
  }
}


class MyApp extends StatefulWidget {
  final AppRouter appRouter;

  const MyApp({super.key, required this.appRouter});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
    statusBarColor: AppColors.gray950,
    statusBarIconBrightness: Brightness.light,
  );
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    DeepLinkManager.init();
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

    Get.put(MyLocaleController());

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => AppCubit(),
          child: BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              // Get the current language from the cubit intent://page/$id#Intent;scheme=myapp;package=com.example.myapp;end
              final appCubit = AppCubit.get(context);
              final language = appCubit.currentLanguage;
              return MaterialApp(
                navigatorKey: navigatorKey,
                navigatorObservers: [routeObserver],
                debugShowCheckedModeBanner: false,
                onGenerateRoute: widget.appRouter.generateRoute,
                initialRoute: RouteStrings.splashScreen,
                // home: BlocProvider(
                //   create: (context) => AuthCubit(),
                //   child: SignUpScreen(),
                // ),
                // home: UpdateSchedule(),
                supportedLocales: const [
                  Locale('ar', ''),
                  Locale('en', ''),
                ],
                locale: Locale(language),
                // Update this with cubit state
                localizationsDelegates: const [
                  AppLocale.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                localeResolutionCallback: (locale, supportedLocales) {
                  for (var supportedLocale in supportedLocales) {
                    if (supportedLocale.languageCode == locale?.languageCode) {
                      return supportedLocale;
                    }
                  }
                  return supportedLocales.first;
                },
              );
            },
          ),
        );
      },
    );
  }
}
