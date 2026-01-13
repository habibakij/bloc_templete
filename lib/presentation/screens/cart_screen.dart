import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/blocs/cart/cart_bloc.dart';
import 'package:flutter_bloc_template/core/navigation/app_routes.dart';
import 'package:flutter_bloc_template/core/theme/app_style.dart';
import 'package:flutter_bloc_template/core/utils/helper/asset_manager.dart';
import 'package:flutter_bloc_template/core/utils/helper/color_manager.dart';
import 'package:flutter_bloc_template/core/utils/widget/app_button.dart';
import 'package:flutter_bloc_template/core/utils/widget/app_widget.dart';
import 'package:flutter_bloc_template/core/utils/widget/common_app_bar.dart';
import 'package:flutter_bloc_template/data/model/custom/add_to_cart_model.dart';
import 'package:flutter_bloc_template/presentation/widgets/cart/cart_quantity_action.dart';
import 'package:go_router/go_router.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    context.read<CartBloc>().add(CartLoadingEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Cart Items"),
      body: SafeArea(
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoadingState) {
              return Center(child: Text("Loading..."));
            } else if (state is CartLoadedState) {
              return ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: state.cartProductList.length,
                separatorBuilder: (_, index) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final item = state.cartProductList[index];
                  return Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                                style: AppTextStyles.regular(fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              AppWidget.height(2),
                              Text(
                                "${item.productDetailsModel?.category}",
                                style: AppTextStyles.hintStyle(),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "by Cart up",
                                    style: AppTextStyles.hintStyle(color: AppColors.green),
                                  ),
                                  Text(
                                    "৳${context.read<CartBloc>().cartItemPriceCalculation(item.productDetailsModel?.price ?? 0, item.quantity ?? 1).toStringAsFixed(2)}",
                                    style: AppTextStyles.title(fontSize: 14),
                                  ),
                                  CartQuantityAction(
                                    quantity: item.quantity ?? 1,
                                    onAdd: () {
                                      context.read<CartBloc>().add(CartProductIncrementEvent(cartProductList: state.cartProductList, cartProductIndex: state.cartProductList.indexOf(item)));
                                    },
                                    onRemove: () {
                                      if (item.quantity! < 2) {
                                        _cartItemDeleteConfirmationDialog(context, state.cartProductList, state.cartProductList.indexOf(item));
                                      } else {
                                        context.read<CartBloc>().add(CartProductDecrementEvent(cartProductList: state.cartProductList, cartProductIndex: state.cartProductList.indexOf(item)));
                                      }
                                    },
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
              );
            } else if (state is CartErrorState) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(child: Text(state.message)),
              );
            }
            return Center(child: Text("Please wait loading..."));
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoadedState) {
            return SafeArea(
              child: Container(
                height: 70,
                color: AppColors.greyLiteBorder,
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
                              Text("৳${context.read<CartBloc>().calculationSubTotal(state.cartProductList).toStringAsFixed(2)}", style: AppTextStyles.regular(fontWeight: FontWeight.w500)),
                            ],
                          ),
                          AppWidget.height(4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("You save: ", style: AppTextStyles.regular()),
                              AppWidget.width(8),
                              Text("৳${(context.read<CartBloc>().discountCalculation(state.cartProductList)).toDouble()}", style: AppTextStyles.regular(fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 44,
                        width: 130,
                        child: AppButton(
                          title: "Order Place",
                          isLoading: false,
                          borderRadius: 12,
                          backgroundColor: AppColors.toneColor,
                          onPressed: () {
                            context.pushNamed(AppRoutes.ORDER_CONFIRMATION);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  void _cartItemDeleteConfirmationDialog(BuildContext context, List<AddToCartModel> cartProductList, int index) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text('Alert !', style: AppTextStyles.title()),
        content: Text('Are you sure to delete this item ?', style: AppTextStyles.regular()),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            isDestructiveAction: true,
            onPressed: () {
              context.read<CartBloc>().add(CartItemRemoveEvent(cartProductList: cartProductList, cartProductIndex: index));
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
