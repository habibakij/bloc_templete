import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/core/utils/helper/color_manager.dart';
import 'package:flutter_bloc_template/core/utils/widget/app_button.dart';
import 'package:flutter_bloc_template/core/utils/widget/common_app_bar.dart';
import 'package:flutter_bloc_template/core/utils/widget/snackbar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Cart Items"),
      body: SafeArea(
        child: Center(
          child: Text("Cart view"),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(bottom: 16.0),
        child: Row(
          children: [
            Expanded(
              child: AppButton(
                title: "Buy now",
                isLoading: false,
                borderRadius: 20,
                backgroundColor: AppColors.toneColor,
                onPressed: () {
                  AppSnackBar.info("Product buying");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
