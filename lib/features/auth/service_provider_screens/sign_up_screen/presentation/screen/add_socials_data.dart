import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yasta/core/app_cubit/app_cubit.dart';
import 'package:yasta/core/helper/app_color/app_color.dart';
import 'package:yasta/core/helper/cache_helper/cache_helper.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';
import 'package:yasta/features/auth/auth_layput_screen.dart';

import 'package:yasta/features/auth/logic/auth_cubit/auth_cubit.dart';
import 'package:yasta/features/service_provider/ui/widget/or_widget.dart';
import '../../../../../../core/app_local/app_local.dart';
import '../../../../../../core/componant/default_button.dart';
import '../../../../../../core/route/route_strings/route_strings.dart';

import '../widgets/header_widget.dart';
import '../widgets/social_media_widget.dart';
import '../../../../../../core/di/dependency_injection.dart';

class AddSocialsData extends StatefulWidget {
  const AddSocialsData({super.key});

  @override
  State<AddSocialsData> createState() => _AddSocialsDataState();
}

class _AddSocialsDataState extends State<AddSocialsData> {
  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      children: [
        HeaderWidget1(
          headerTitle:
          getLang(context, "Your Social Media")
              .toString(),
          title:"",
          greenIndicators: 3, // Number of green indicators
          totalIndicators: 4, // Optional, defaults to 5
        ),
        verticalSpace(40),

        const Divider(),

        const SocialMediaWidget(),
        verticalSpace(40),
        DefaultButton(
          label: getLang(context, "Save data").toString(),
          onPressed: () {
            getIt<AuthCubit>().sendSocialsData(context);
          },
        ),
        OrWidget(),
        verticalSpace(24),
        DefaultButton(
backgroundColor: Colors.grey,

          onPressed: () {
            CacheHelper.removeData(
              key: "stage",
            )
                .then((_) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                RouteStrings.accountCreatedSuccessfullyScreen,
                    (Route<dynamic> route) => false,
                arguments: {
                  "isGuest": false,
                  "isUser": false,
                },
              );
            });

          },
          label: getLang(context, "I will do that later").toString(),
        ),
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {

            if(state is AddSocialsErrorState){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
            if (state is AddSocialsSuccessState) {
              CacheHelper.removeData(
                  key: "stage",
                  )
                  .then((_) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteStrings.accountCreatedSuccessfullyScreen,
                      (Route<dynamic> route) => false,
                  arguments: {
                    "isGuest": false,
                    "isUser": false,
                  },
                );
              });
            }

          },
          child: const SizedBox.shrink(),
        ),

      ],
    );
  }
}

String getPlatformFromLink(String link) {
  try {
    Uri uri = Uri.parse(link);

    // Extract the host from the URL
    String host = uri.host;

    // Determine the platform based on the host
    if (host.contains("facebook.com")) {
      return "Facebook";
    } else if (host.contains("instagram.com")) {
      return "Instagram";
    } else if (host.contains("twitter.com")) {
      return "Twitter";
    } else if (host.contains("linkedin.com")) {
      return "LinkedIn";
    } else if (host.contains("youtube.com")) {
      return "YouTube";
    } else if (host.contains("web.whatsapp.com")) {
      return "WhatsApp Web";
    } else {
      return "Web";
    }
  } catch (e) {
    return "Invalid URL";
  }
}
