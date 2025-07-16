import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/helper/cache_helper/cache_helper.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';
import 'package:yasta/core/route/route_strings/route_strings.dart';
import 'package:yasta/features/notification/presentation/widget/notification_item.dart';
import 'package:yasta/features/payment_method/presentation/widget/e_wallet_widget.dart';
import 'package:yasta/features/payment_method/presentation/widget/pay_mob_widget.dart';

import '../../../../../core/theme/text_styles.dart';
import '../widget/visa_card_widget.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: CacheHelper.getdata(key: "lang") == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              getLang(context, "Payment Methods").toString(),
              style: TextStyles.blackFS15FW500TextStyle,
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 44.h),
            child: ListView(
              children: [
                const PayMobWidget(),
                SizedBox(height: 20.h), // For spacing between items
              const  VisaCardWidget(),
                verticalSpace(40.h),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RouteStrings.eWalletScreen);
                  },
                  child: EWalletWidget(),
                ),
              ],
            ),

          ),
        ),
      ),
    );
  }
}
