import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/blocs/cart/cart_bloc.dart';
import 'package:flutter_bloc_template/blocs/checkout/checkout_bloc.dart';
import 'package:flutter_bloc_template/core/navigation/app_routes.dart';
import 'package:flutter_bloc_template/core/theme/app_style.dart';
import 'package:flutter_bloc_template/core/utils/helper/asset_manager.dart';
import 'package:flutter_bloc_template/core/utils/helper/color_manager.dart';
import 'package:flutter_bloc_template/core/utils/widget/app_bottom_sheet.dart';
import 'package:flutter_bloc_template/core/utils/widget/app_button.dart';
import 'package:flutter_bloc_template/core/utils/widget/app_text_field.dart';
import 'package:flutter_bloc_template/core/utils/widget/app_widget.dart';
import 'package:flutter_bloc_template/core/utils/widget/common_app_bar.dart';
import 'package:flutter_bloc_template/core/utils/widget/snackbar.dart';
import 'package:flutter_bloc_template/presentation/widgets/cart/price_summery.dart';
import 'package:go_router/go_router.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  var couponController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isCouponProcessing = false;

  @override
  void initState() {
    context.read<CheckoutBloc>().add(CheckoutLoadingEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Checkout"),
      body: SafeArea(
        child: BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            //final bool isApplyingCoupon = state is CheckoutApplyingCouponState;
            if (state is CheckoutLoadingState) {
              return Center(child: Text("Loading..."));
            } else if (state is CheckoutLoadedState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0).copyWith(top: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Delivered to", style: AppTextStyles.subTitle()),
                            DecoratedBox(
                              decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                                child: Row(
                                  children: [
                                    Image.asset(editIcon, height: 20, width: 20),
                                    AppWidget.width(4),
                                    Text("Edit", style: AppTextStyles.regular()),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        AppWidget.height(8.0),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                            child: Text("House 24, Road 13, Nikunja 2, Khilkhet Dhaka 1205", style: AppTextStyles.regular()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppWidget.height(12.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text("My products (${state.checkoutProductList.length})", style: AppTextStyles.subTitle()),
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      itemCount: state.checkoutProductList.length,
                      separatorBuilder: (_, index) => AppWidget.height(8),
                      itemBuilder: (context, index) {
                        final item = state.checkoutProductList[index];
                        return Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 6, offset: const Offset(0, 2)),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  item.productDetailsModel?.image ?? "",
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(image: AssetImage(placeholderImage), fit: BoxFit.cover),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              AppWidget.width(12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.productDetailsModel?.title ?? "",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles.regular(fontWeight: FontWeight.w500),
                                    ),
                                    AppWidget.height(2),
                                    Text(
                                      "${item.productDetailsModel?.category}",
                                      maxLines: 1,
                                      style: AppTextStyles.hintStyle(),
                                    ),
                                    AppWidget.height(2),
                                    RichText(
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      softWrap: true,
                                      maxLines: 1,
                                      text: TextSpan(
                                        text: "seller",
                                        style: AppTextStyles.regular(),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: " Cart up",
                                            style: AppTextStyles.regular(color: AppColors.primaryDarkColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                    AppWidget.height(4),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "৳${context.read<CartBloc>().cartItemPriceCalculation(item.productDetailsModel?.price ?? 0, item.quantity ?? 1).toStringAsFixed(2)}",
                                              style: AppTextStyles.regular(fontWeight: FontWeight.w500, color: AppColors.primaryDarkColor),
                                            ),
                                            AppWidget.width(2),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 2.0),
                                              child: Text(
                                                "৳${(context.read<CheckoutBloc>().cartItemPriceCalculation(item.productDetailsModel?.price ?? 0, item.quantity ?? 1) + 20).toStringAsFixed(2)}",
                                                style: AppTextStyles.discountStrikeStyle(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        RichText(
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.start,
                                          softWrap: true,
                                          maxLines: 1,
                                          text: TextSpan(
                                            text: "QTY:",
                                            style: AppTextStyles.regular(),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: " ${item.quantity}",
                                                style: AppTextStyles.regular(fontWeight: FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Apply coupon code",
                          style: AppTextStyles.regular(),
                        ),
                        AppWidget.height(8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: state.appliedCouponCode.isNotEmpty && !isCouponProcessing
                                  ? DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: AppColors.greyLiteBorder,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                                        child: Text(
                                          state.appliedCouponCode,
                                          style: AppTextStyles.regular(fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    )
                                  : Form(
                                      key: formKey,
                                      child: CommonTextField(
                                        controller: couponController,
                                        hintText: "Enter coupon code",
                                        keyboardType: TextInputType.text,
                                        contentPadding: EdgeInsets.zero,
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(couponIcon, height: 20, width: 30, fit: BoxFit.fill),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Coupon code required";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                            ),
                            AppWidget.width(12.0),
                            SizedBox(
                              height: 48,
                              width: 90,
                              child: isCouponProcessing
                                  ? DecoratedBox(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.toneColor,
                                      ),
                                      child: Center(
                                        child: CircularProgressIndicator(color: AppColors.primaryColor),
                                      ),
                                    )
                                  : state.appliedCouponCode.isNotEmpty
                                      ? AppButton(
                                          title: "Remove",
                                          isLoading: false,
                                          borderRadius: 10,
                                          backgroundColor: AppColors.toneColor,
                                          onPressed: () async {},
                                        )
                                      : AppButton(
                                          title: "Apply",
                                          isLoading: false,
                                          borderRadius: 10,
                                          backgroundColor: AppColors.toneColor,
                                          onPressed: () async {
                                            if (formKey.currentState != null && formKey.currentState!.validate()) {
                                              setState(() => isCouponProcessing = true);
                                              context.read<CheckoutBloc>().add(CheckoutApplyCouponEvent(
                                                    couponText: couponController.value.text.toString(),
                                                    subTotal: context.read<CheckoutBloc>().calculationSubTotal(checkoutProductList: state.checkoutProductList, couponDiscountAmount: state.couponDiscountAmount),
                                                    checkoutProductList: state.checkoutProductList,
                                                  ));
                                              await Future.delayed(const Duration(milliseconds: 1000));
                                              setState(() => isCouponProcessing = false);
                                            } else {
                                              AppSnackBar.error("Please enter coupon code");
                                            }
                                          },
                                        ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (state is CheckoutErrorState) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(child: Text(state.message)),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, state) {
          if (state is CheckoutLoadedState) {
            return PriceSummery(
              subTotal: context.read<CheckoutBloc>().calculationSubTotal(checkoutProductList: state.checkoutProductList, couponDiscountAmount: state.couponDiscountAmount).toStringAsFixed(2),
              youSave: context.read<CheckoutBloc>().discountCalculation(state.checkoutProductList).toStringAsFixed(2),
              buttonTitle: "Checkout",
              buttonWidth: 120,
              buttonCallBack: () => context.pushNamed(AppRoutes.ORDER_CONFIRMATION),
              onTabCallBack: () {
                showCommonBottomSheet(
                  context: context,
                  title: "Price Summery",
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Base fare",
                            style: AppTextStyles.regular(),
                          ),
                          Text(
                            "৳${context.read<CheckoutBloc>().calculationSubTotal(checkoutProductList: state.checkoutProductList, couponDiscountAmount: 0).toStringAsFixed(2)}",
                            style: AppTextStyles.subTitle(fontSize: 16),
                          ),
                        ],
                      ),
                      if (state.appliedCouponCode.isNotEmpty) ...[
                        AppWidget.height(8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Coupon Discount", style: AppTextStyles.regular()),
                                AppWidget.width(8),
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryLiteColor.withValues(alpha: 0.6),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    child: Text(
                                      state.appliedCouponCode,
                                      style: AppTextStyles.regular(fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              state.couponDiscountAmount.toStringAsFixed(2),
                              style: AppTextStyles.subTitle(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                      AppWidget.height(8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Flat 20(BDT) save", style: AppTextStyles.regular()),
                          Text(
                            "৳${context.read<CheckoutBloc>().discountCalculation(state.checkoutProductList).toStringAsFixed(2)}",
                            style: AppTextStyles.subTitle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
