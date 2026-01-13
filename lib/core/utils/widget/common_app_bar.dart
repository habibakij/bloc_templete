import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/core/theme/app_style.dart';
import 'package:flutter_bloc_template/core/utils/helper/color_manager.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final String title;
  final TextStyle? titleStyle;
  final bool centerTitle;
  final bool leadingVisibility;
  final Widget? leadingWidget;
  final VoidCallback? onLeadingTab;
  final List<Widget>? actions;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final PreferredSizeWidget? bottomWidget;
  final double elevation;

  const CommonAppBar({
    super.key,
    this.backgroundColor = AppColors.primaryColor,
    required this.title,
    this.titleStyle,
    this.centerTitle = true,
    this.leadingVisibility = true,
    this.leadingWidget,
    this.onLeadingTab,
    this.actions,
    this.scaffoldKey,
    this.bottomWidget,
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
      leading: leadingVisibility
          ? leadingWidget ??
              IconButton(
                icon: Icon(
                  hasDrawer ? Icons.menu : Icons.arrow_back_ios_new,
                  color: AppColors.black,
                  size: 20,
                ),
                onPressed: hasDrawer ? () => scaffoldKey!.currentState?.openDrawer() : (onLeadingTab ?? () => Navigator.maybePop(context)),
              )
          : SizedBox.shrink(),
      bottom: bottomWidget,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        bottomWidget == null ? kToolbarHeight : kToolbarHeight + bottomWidget!.preferredSize.height,
      );
}
