import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/blocs/cart/cart_bloc.dart';
import 'package:flutter_bloc_template/core/theme/app_style.dart';
import 'package:flutter_bloc_template/core/utils/helper/asset_manager.dart';
import 'package:flutter_bloc_template/core/utils/helper/color_manager.dart';
import 'package:flutter_bloc_template/core/utils/widget/app_button.dart';
import 'package:flutter_bloc_template/core/utils/widget/app_widget.dart';
import 'package:flutter_bloc_template/core/utils/widget/common_app_bar.dart';
import 'package:flutter_bloc_template/core/utils/widget/snackbar.dart';

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
                                "${item.productDetailsModel?.category} ${state.totalPrice}" ?? "",
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
                                    "৳${item.productDetailsModel?.price?.toStringAsFixed(2)}",
                                    style: AppTextStyles.title(fontSize: 14),
                                  ),
                                  _QuantitySelector(
                                    quantity: item.quantity ?? 1,
                                    onAdd: () {},
                                    onRemove: () {},
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
            return SizedBox(
              height: 70,
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
                            Text("৳${state.totalPrice}", style: AppTextStyles.regular(fontWeight: FontWeight.w500)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("You save: ", style: AppTextStyles.regular()),
                            AppWidget.width(8),
                            Text("৳${(state.cartProductList.length * 20).toDouble()}", style: AppTextStyles.regular(fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                      width: 120,
                      child: AppButton(
                        title: "Order Place",
                        isLoading: false,
                        borderRadius: 16,
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
          return SizedBox.shrink();
        },
      ),
    );
  }
}

class _QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const _QuantitySelector({required this.quantity, required this.onAdd, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: Row(
        children: [
          InkWell(
            radius: 4,
            focusColor: AppColors.grey,
            onTap: () {},
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.greyLiteBorder),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6),
                child: quantity < 2 ? Icon(Icons.delete, size: 12) : Icon(Icons.remove, size: 12, color: AppColors.dartRed),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              quantity.toString(),
              style: AppTextStyles.title(fontSize: 16),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6),
              child: Icon(Icons.add, size: 12),
            ),
          ),
        ],
      ),
    );
  }
}
