import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/core/theme/app_style.dart';
import 'package:flutter_bloc_template/core/utils/helper/color_manager.dart';

import 'app_button.dart';
import 'app_widget.dart';

Future<T?> showCommonBottomSheet<T>({
  required BuildContext context,
  required String title,
  required Widget child,
  String? leftButtonTitle,
  String? rightButtonTitle,
  VoidCallback? leftCallBack,
  VoidCallback? rightCallBack,
  bool isDismissible = true,
  bool enableDrag = true,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
    builder: (_) {
      return CommonBottomSheet(
        title: title,
        leftButtonTitle: leftButtonTitle ?? "Cancel",
        rightButtonTitle: rightButtonTitle ?? "Continue",
        leftCallBack: leftCallBack ??
            () {
              Navigator.maybePop(context);
            },
        rightCallBack: rightCallBack ??
            () {
              Navigator.maybePop(context);
            },
        child: child,
      );
    },
  );
}

class CommonBottomSheet extends StatelessWidget {
  final String title;
  final Widget child;
  final String leftButtonTitle;
  final String rightButtonTitle;
  final VoidCallback leftCallBack;
  final VoidCallback rightCallBack;

  const CommonBottomSheet({
    super.key,
    required this.title,
    required this.child,
    required this.leftButtonTitle,
    required this.rightButtonTitle,
    required this.leftCallBack,
    required this.rightCallBack,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              height: 4,
              width: 60,
              decoration: BoxDecoration(color: AppColors.grey, borderRadius: BorderRadius.circular(8)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(title, textAlign: TextAlign.center, style: AppTextStyles.title()),
            ),
            AppWidget.height(12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: child,
            ),
            AppWidget.height(12),
            Divider(height: 1, color: AppColors.greyLiteBorder),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: AppButton(
                      height: 44,
                      title: leftButtonTitle,
                      isLoading: false,
                      borderRadius: 10,
                      backgroundColor: AppColors.toneColor,
                      onPressed: leftCallBack,
                    ),
                  ),
                  AppWidget.width(16),
                  Expanded(
                    child: AppButton(
                      height: 44,
                      title: rightButtonTitle,
                      isLoading: false,
                      borderRadius: 10,
                      backgroundColor: AppColors.primaryColor,
                      onPressed: rightCallBack,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
