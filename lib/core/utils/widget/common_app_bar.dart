import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/core/theme/app_style.dart';
import 'package:flutter_bloc_template/core/utils/helper/color_manager.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final TextStyle? titleStyle;
  final bool centerTitle;
  final List<Widget>? actions;
  final Widget? leading;
  final bool visibilityLeading;
  final VoidCallback? onLeadingPressed;
  final Color titleTextColor;
  final Color backgroundColor;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final PreferredSizeWidget? bottom;
  final double elevation;

  const CommonAppBar({
    super.key,
    required this.title,
    this.titleStyle,
    this.centerTitle = true,
    this.actions,
    this.leading,
    this.visibilityLeading = true,
    this.onLeadingPressed,
    this.titleTextColor = AppColors.textColor,
    this.backgroundColor = AppColors.primaryColor,
    this.scaffoldKey,
    this.bottom,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasDrawer = scaffoldKey != null;
    return AppBar(
      elevation: elevation,
      backgroundColor: backgroundColor,
      centerTitle: centerTitle,
      title: Text(title, style: titleStyle ?? AppTextStyles.title()),
      actions: actions,
      leading: visibilityLeading
          ? leading ??
              IconButton(
                icon: Icon(
                  hasDrawer ? Icons.menu : Icons.arrow_back_ios_new,
                  color: titleTextColor,
                  size: 20,
                ),
                onPressed: hasDrawer ? () => scaffoldKey!.currentState?.openDrawer() : (onLeadingPressed ?? () => Navigator.maybePop(context)),
              )
          : SizedBox.shrink(),
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        bottom == null ? kToolbarHeight : kToolbarHeight + bottom!.preferredSize.height,
      );
}
