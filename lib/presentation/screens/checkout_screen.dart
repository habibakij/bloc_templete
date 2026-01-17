import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/blocs/cart/cart_bloc.dart';
import 'package:flutter_bloc_template/core/navigation/app_routes.dart';
import 'package:flutter_bloc_template/core/theme/app_style.dart';
import 'package:flutter_bloc_template/core/utils/helper/asset_manager.dart';
import 'package:flutter_bloc_template/core/utils/helper/color_manager.dart';
import 'package:flutter_bloc_template/core/utils/widget/app_widget.dart';
import 'package:flutter_bloc_template/core/utils/widget/common_app_bar.dart';
import 'package:flutter_bloc_template/presentation/widgets/cart/price_summery.dart';
import 'package:go_router/go_router.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  void initState() {
    context.read<CartBloc>().add(CartLoadingEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Checkout"),
      body: SafeArea(
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoadingState) {
              return Center(child: Text("Loading..."));
            } else if (state is CartLoadedState) {
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
                            Text("Delivered to", style: AppTextStyles.title()),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
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
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
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
                    child: Text("Your products (${state.cartProductList.length})", style: AppTextStyles.title()),
                  ),
                  AppWidget.height(4.0),
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(12),
                      itemCount: state.cartProductList.length,
                      separatorBuilder: (_, index) => AppWidget.height(8),
                      itemBuilder: (context, index) {
                        final item = state.cartProductList[index];
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
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${item.productDetailsModel?.category}",
                                            maxLines: 1,
                                            style: AppTextStyles.hintStyle(),
                                          ),
                                        ),
                                        AppWidget.width(12),
                                        Expanded(
                                          flex: 2,
                                          child: RichText(
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            softWrap: true,
                                            maxLines: 1,
                                            text: TextSpan(
                                              text: "seller",
                                              style: AppTextStyles.regular(fontSize: 12),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: " Cart up",
                                                  style: AppTextStyles.regular(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.primaryDarkColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    AppWidget.height(4),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "৳${context.read<CartBloc>().cartItemPriceCalculation(item.productDetailsModel?.price ?? 0, item.quantity ?? 1).toStringAsFixed(2)}",
                                              style: AppTextStyles.title(fontSize: 16, color: AppColors.primaryDarkColor),
                                            ),
                                            AppWidget.width(2),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 2.0),
                                              child: Text(
                                                "৳${(context.read<CartBloc>().cartItemPriceCalculation(item.productDetailsModel?.price ?? 0, item.quantity ?? 1) + 20).toStringAsFixed(2)}",
                                                style: AppTextStyles.discountStrikeStyle(fontSize: 10),
                                              ),
                                            ),
                                          ],
                                        ),
                                        AppWidget.width(12),
                                        RichText(
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.start,
                                          softWrap: true,
                                          maxLines: 1,
                                          text: TextSpan(
                                            text: "Q:",
                                            style: AppTextStyles.regular(),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: " 2",
                                                style: AppTextStyles.regular(
                                                  fontWeight: FontWeight.w500,
                                                ),
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
                ],
              );
            } else if (state is CartErrorState) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(child: Text(state.message)),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoadedState) {
            return PriceSummery(
              buttonTitle: "Checkout",
              subTotal: context.read<CartBloc>().calculationSubTotal(state.cartProductList).toStringAsFixed(2),
              youSave: context.read<CartBloc>().discountCalculation(state.cartProductList).toStringAsFixed(2),
              onTab: () {
                context.pushNamed(AppRoutes.ORDER_CONFIRMATION);
              },
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
