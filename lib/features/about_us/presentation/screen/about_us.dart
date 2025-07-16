import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/helper/cache_helper/cache_helper.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';
import 'package:yasta/core/theme/text_styles.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: CacheHelper.getdata(key: "lang") == "ar"
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.grey[100],
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 1,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title:   Text(
              getLang(context, "About Us").toString(),
              style: TextStyles.blackFS15FW500TextStyle,
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 24.w,vertical: 44.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Row to display two images side-by-side
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 155.w,
                            height: 117.h,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r)),
                            child: Image.asset(
                              'assets/image/Rectangle 207 (1).png', // Replace with your image path
                              // fit: BoxFit.cover,
                              //height: 120,
                            ),
                          ),
                          Container(
                            width: 155.w,
                            height: 117.h,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r)),
                            child: Image.asset(
                              'assets/image/Rectangle 207 (2).png', // Replace with your image path
              
                              // height: 120,
                            ),
                          ),
                        ],
                      ),
                      horizontalSpace( 10.w),
                      Container(
                        width: 155.w,
                        height: 250.h,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r)),
                        child: Image.asset(
                          'assets/image/Rectangle 207.png', // Replace with your image path
                         // fit: BoxFit.cover,
                         // height: 120,
                        ),
                      ),
              
                    ],
                  ),
                   verticalSpace( 20.h),
                  // Main text section
                  Text(
                    getLang(context, "All your car maintenance services in one place: from regular maintenance to major repairs, we cover everything.").toString(),
                    textAlign: TextAlign.center,
                    style: TextStyles.blackFS15FW500TextStyle
                  ),
                  const SizedBox(height: 15),
                  // Description text section
                  Text(
                    'نحن نؤمن بأن صيانة سيارتك يجب أن تكون تجربة سلسة ومريحة. من صيانة الزيت إلى فحص الفرامل، نوفر لك صيانة موثوقة في أي مكان وكل زمان. فريقنا من الفنيين المحترفين مدربون على أحدث الأساليب والمعدات لضمان حصولك على أفضل خدمة باستخدام أحدث التقنيات. مع خدمتنا المتنقلة، يمكننا أن نأتي إلى موقعك، سواء كنت تحتاج صيانة دورية أم إصلاحًا شاملاً. لا داعي للانتظار في ورشة الإصلاح. نحن نأتي إليك ونجعل صيانة سيارتك مريحة وفعالة.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )));
  }
}
