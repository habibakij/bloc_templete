import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/core/theme/app_style.dart';
import 'package:flutter_bloc_template/core/utils/helper/color_manager.dart';
import 'package:flutter_bloc_template/core/utils/widget/app_button.dart';
import 'package:flutter_bloc_template/core/utils/widget/app_widget.dart';

class PriceSummery extends StatelessWidget {
  final String? buttonTitle;
  final String subTotal;
  final String youSave;
  final VoidCallback onTab;
  const PriceSummery({super.key, this.buttonTitle, required this.subTotal, required this.youSave, required this.onTab});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 70.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Card(
            elevation: 4,
            color: AppColors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Sub total: ", style: AppTextStyles.regular()),
                          AppWidget.width(8),
                          Text("৳$subTotal", style: AppTextStyles.regular(fontWeight: FontWeight.w600)),
                        ],
                      ),
                      AppWidget.height(4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("You save: ", style: AppTextStyles.regular()),
                          AppWidget.width(8),
                          Text("৳$youSave", style: AppTextStyles.regular(fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 44,
                    width: 130,
                    child: AppButton(
                      title: buttonTitle ?? "Review",
                      isLoading: false,
                      borderRadius: 12,
                      backgroundColor: AppColors.toneColor,
                      onPressed: onTab,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
