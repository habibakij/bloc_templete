import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/core/utils/helper/color_manager.dart';
import 'package:flutter_bloc_template/core/utils/widget/app_widget.dart';

import 'app_button.dart';

Future<T?> showCommonBottomSheet<T>({
  required BuildContext context,
  required String title,
  required Widget child,
  String? leftButtonTitle,
  String? rightButtonTitle,
  VoidCallback? leftCallBack,
  VoidCallback? rightCallBack,
  double heightRatio = 0.5,
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
        height: heightRatio,
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
  final double height;
  final Widget child;
  final String leftButtonTitle;
  final String rightButtonTitle;
  final VoidCallback leftCallBack;
  final VoidCallback rightCallBack;

  const CommonBottomSheet({
    super.key,
    required this.title,
    required this.height,
    required this.child,
    required this.leftButtonTitle,
    required this.rightButtonTitle,
    required this.leftCallBack,
    required this.rightCallBack,
  });

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height * height;
    return SafeArea(
      top: false,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: 4,
              width: 60,
              decoration: BoxDecoration(color: AppColors.grey, borderRadius: BorderRadius.circular(8)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            AppWidget.height(12),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: child,
                ),
              ),
            ),
            Divider(height: 1, color: AppColors.greyLiteBorder),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: AppButton(
                      height: 48,
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
                      height: 48,
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
