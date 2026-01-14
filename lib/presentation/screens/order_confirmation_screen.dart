import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/blocs/order_confirmation/confirmation_bloc.dart';
import 'package:flutter_bloc_template/core/navigation/app_routes.dart';
import 'package:flutter_bloc_template/core/theme/app_style.dart';
import 'package:flutter_bloc_template/core/utils/helper/asset_manager.dart';
import 'package:flutter_bloc_template/core/utils/helper/color_manager.dart';
import 'package:flutter_bloc_template/core/utils/widget/app_button.dart';
import 'package:flutter_bloc_template/core/utils/widget/app_widget.dart';
import 'package:flutter_bloc_template/core/utils/widget/common_app_bar.dart';
import 'package:go_router/go_router.dart';

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Order Confirmed", leadingVisibility: false),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(correctIcon, height: 120, width: 120, fit: BoxFit.cover),
            Text("Recorded !", style: AppTextStyles.title()),
            AppWidget.height(8.0),
            Text(
              "Your order has been recorded, you will get confirmation very soon thank you.",
              textAlign: TextAlign.center,
              style: AppTextStyles.regular(),
            ),
            AppWidget.height(24.0),
            AppButton(
              height: 40,
              title: "Home",
              isLoading: false,
              borderRadius: 20,
              backgroundColor: AppColors.toneColor,
              onPressed: () {
                context.read<ConfirmationBloc>().add(CartClearEvent());
                context.pushNamed(AppRoutes.HOME_SCREEN);
              },
            ),
            AppWidget.height(8.0),
            AppButton(
              height: 40,
              title: "My Order",
              isLoading: false,
              borderRadius: 20,
              backgroundColor: AppColors.primaryColor,
              onPressed: () {
                //context.read<ConfirmationBloc>().add(CartClearEvent());
                context.pushNamed(AppRoutes.MY_ORDER);
              },
            ),
          ],
        ),
      ),
    );
  }
}
