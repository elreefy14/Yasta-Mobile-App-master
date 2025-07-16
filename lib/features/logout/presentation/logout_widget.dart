import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/helper/cache_helper/cache_helper.dart';
import 'package:yasta/core/theme/colors.dart';
import 'package:yasta/features/auth/logic/auth_cubit/auth_cubit.dart';
import 'package:yasta/features/auth/ui/screen/login_screen.dart';
import '../../../../../../core/di/dependency_injection.dart';

import '../../../core/componant/save_cancel_buttons.dart';
import '../../../core/helper/spacing/spacing.dart';
import '../../../core/route/route_strings/route_strings.dart';
import '../../../core/theme/text_styles.dart';

class LogoutWidget extends StatelessWidget {
  const LogoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              getLang(context, "Are you sure you want to leave?").toString(),
              textAlign: TextAlign.center,
              style: TextStyles.gray800FS14FW500CairoTextStyle,
            ),
            verticalSpace(20),
            LogOutButtons(
              cancelButtonBackgroundColor: AppColors.whiteColor,
              onCancelPressed: () {
                Navigator.pop(context);
              },
              onSavedPressed: () {
                getIt<AuthCubit>().logout();
              },
            ),
            BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is LogoutSuccessState) {
                  // Navigator.pop(context);
                  CacheHelper.clearData();
                  CacheHelper.saveData(
                    key: "onBoarding",
                    value: true,
                  );
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    RouteStrings.loginScreen,
                        (Route<dynamic> route) => false, // This clears all previous routes
                  );
                }
                if (state is LogoutErrorState) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
              },
              child: const SizedBox.shrink(),
            )
          ],
        ),
      ),
    );
  }
}
