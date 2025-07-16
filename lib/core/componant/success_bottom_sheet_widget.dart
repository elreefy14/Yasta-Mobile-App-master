import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../helper/spacing/spacing.dart';
import '../theme/text_styles.dart';

class SuccessBottomSheetWidget extends StatefulWidget {
  const SuccessBottomSheetWidget({super.key, required this.successText});
  final String successText;

  @override
  State<SuccessBottomSheetWidget> createState() => _SuccessBottomSheetWidgetState();
}

class _SuccessBottomSheetWidgetState extends State<SuccessBottomSheetWidget> {
  @override
  void initState() {
    super.initState();

    // Safely pop the bottom sheet after a delay
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
       builder: (context, setState) {
         return SizedBox(
           width: MediaQuery.of(context).size.width,
           height: MediaQuery.of(context).size.height * 0.5,
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               SvgPicture.asset("assets/icons/success.svg",
                   width: 100.w, height: 100.h),
               verticalSpace(20),
               Text(
                 widget.successText,
                 style: TextStyles.gray900FS16FW500CairoTextStyle,
                 textAlign: TextAlign.center,
               ),
             ],
           ),
         );
       },
    );
  }
}
