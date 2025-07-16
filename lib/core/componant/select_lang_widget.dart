import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/app_cubit/app_cubit.dart';
import 'package:yasta/core/componant/componant.dart';
import 'package:yasta/core/theme/text_styles.dart';

class SelectLangWidget extends StatefulWidget {
  SelectLangWidget({super.key, this.color});

  Color? color;

  @override
  State<SelectLangWidget> createState() => _SelectLangWidgetState();
}

class _SelectLangWidgetState extends State<SelectLangWidget> {
  List<String> langList = ["العربيه", "English"];
  String selectedValue = "العربيه";

  @override
  void initState() {
    // TODO: implement initState
    selectedValue =
        AppCubit.get(context).currentLanguage == "ar" ? "العربيه" : "English";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0.w),
      child: InkWell(
          onTap: () {
            setState(() {
              selectedValue =
                  selectedValue == "العربيه" ? "English" : "العربيه";
            });
            AppCubit.get(context)
                .changeLanguage(selectedValue == "العربيه" ? "ar" : "en");
          },
          child: Text(
            AppCubit.get(context).currentLanguage == "ar"
                ? "English"
                : "العربيه",
            style: TextStyles.gray200FS14FW600CairoTextStyle.copyWith(
              color: widget.color??Colors.white
            ),
          )),
    );
    // return buildDropdown(
    //   itemList: langList,
    //   color1: widget.color,
    //   selectedValue: selectedValue,
    //   onChanged: (String? value) {
    //     setState(() {
    //       selectedValue = value!;
    //     });
    //     AppCubit.get(context).changeLanguage(value == "العربيه" ? "ar" : "en");
    //   },
    //   context: context,
    // );
  }
}
