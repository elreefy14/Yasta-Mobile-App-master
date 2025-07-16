import 'package:flutter/material.dart';
import 'package:yasta/core/theme/colors.dart';
import 'package:yasta/core/theme/text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final Color? iconColor;
  final TextStyle? titleStyle;
  final bool centerTitle;
  final VoidCallback? onBackPressed;
  final Widget? leadingIcon;
  final List<Widget>? actions;

   const CustomAppBar({
    super.key,
    required this.title,
    this.backgroundColor = AppColors.whiteColor,
    this.titleStyle,
    this.actions,
    this.iconColor,
    this.centerTitle = true,
    this.onBackPressed,
    this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      centerTitle: centerTitle,
      actions:actions,
      title: Text(title, style: titleStyle ?? TextStyles.gray950FS14FW600CairoTextStyle),
      leading: IconButton(
        icon: leadingIcon ?? Icon(Icons.arrow_back_outlined,color: iconColor,),
        onPressed: onBackPressed ?? () => Navigator.pop(context),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
