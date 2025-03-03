import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/core/theme/app_text_styles.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final List<Widget>? actions;
  final Widget? leading;
  final VoidCallback? onLeadingPressed;
  final Color titleTextColor;
  final Color backgroundColor;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final PreferredSizeWidget? bottom;

  const CommonAppBar({
    super.key,
    required this.title,
    this.centerTitle = true,
    this.actions,
    this.leading,
    this.onLeadingPressed,
    this.titleTextColor = Colors.white,
    this.backgroundColor = Colors.blue,
    this.scaffoldKey,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title,
          style: AppTextStyles.titleTextStyle(textColor: titleTextColor)),
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      actions: actions,
      leading: InkWell(
        onTap: scaffoldKey != null
            ? () => scaffoldKey!.currentState?.openDrawer()
            : (onLeadingPressed ?? () => Navigator.pop(context)),
        child: leading ??
            Icon(scaffoldKey != null ? Icons.menu : Icons.arrow_back_ios,
                color: Colors.white),
      ),
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(bottom == null
      ? kToolbarHeight
      : kToolbarHeight + bottom!.preferredSize.height);
}
