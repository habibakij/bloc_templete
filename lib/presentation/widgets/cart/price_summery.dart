import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/core/theme/app_style.dart';
import 'package:flutter_bloc_template/core/utils/helper/color_manager.dart';
import 'package:flutter_bloc_template/core/utils/widget/app_button.dart';
import 'package:flutter_bloc_template/core/utils/widget/app_widget.dart';
import 'package:flutter_bloc_template/core/utils/widget/snackbar.dart';

class PriceSummery extends StatelessWidget {
  final String subTotal;
  final String youSave;
  final String? buttonTitle;
  final double? buttonWidth;
  final VoidCallback? buttonCallBack;
  final VoidCallback? onTabCallBack;

  const PriceSummery({
    super.key,
    required this.subTotal,
    required this.youSave,
    this.buttonTitle,
    this.buttonWidth,
    this.buttonCallBack,
    this.onTabCallBack,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: SizedBox(
          height: 70.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Card(
              elevation: 4,
              color: AppColors.white,
              child: InkWell(
                onTap: onTabCallBack ?? () {},
                borderRadius: BorderRadius.circular(12.0),
                splashColor: AppColors.primaryColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                              Text("Sub Total: ", style: AppTextStyles.regular()),
                              AppWidget.width(4),
                              Text("৳$subTotal", style: AppTextStyles.regular(color: AppColors.primaryDarkColor, fontWeight: FontWeight.w500)),
                            ],
                          ),
                          AppWidget.height(4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Saved: ", style: AppTextStyles.regular()),
                              AppWidget.width(4),
                              Text("৳$youSave", style: AppTextStyles.regular(color: AppColors.primaryDarkColor, fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 44,
                        width: buttonWidth ?? 100,
                        child: AppButton(
                          title: buttonTitle ?? "Review",
                          isLoading: false,
                          borderRadius: 12,
                          backgroundColor: AppColors.toneColor,
                          onPressed: buttonCallBack ??
                              () {
                                AppSnackBar.error("Invalid Request");
                              },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
