import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/blocs/details/details_bloc.dart';
import 'package:flutter_bloc_template/core/navigation/app_routes.dart';
import 'package:flutter_bloc_template/core/theme/app_style.dart';
import 'package:flutter_bloc_template/core/utils/helper/asset_manager.dart';
import 'package:flutter_bloc_template/core/utils/helper/color_manager.dart';
import 'package:flutter_bloc_template/core/utils/widget/app_button.dart';
import 'package:flutter_bloc_template/core/utils/widget/app_widget.dart';
import 'package:flutter_bloc_template/core/utils/widget/common_app_bar.dart';
import 'package:flutter_bloc_template/presentation/widgets/shimmer/details/product_details_loading.dart';
import 'package:go_router/go_router.dart';

class DetailsScreen extends StatefulWidget {
  final int productId;
  const DetailsScreen({super.key, required this.productId});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DetailsBloc>().add(ProductDetailsInitEvent(productID: widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: "Product Details",
        actions: [
          BlocBuilder<DetailsBloc, DetailsState>(
            builder: (context, state) {
              if (state is ProductDetailLoadedState) {
                return InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  focusColor: AppColors.toneColor,
                  onTap: () {
                    context.pushNamed(AppRoutes.CART_SCREEN);
                  },
                  child: Stack(
                    children: [
                      Positioned(
                        right: 4.0,
                        top: 0.0,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                          decoration: BoxDecoration(
                            color: AppColors.toneColor,
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          ),
                          child: Text(
                            "${state.cartProductsList.length}",
                            style: AppTextStyles.regular(color: AppColors.red, fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(size: 28.0, Icons.shopping_cart, color: AppColors.black),
                      ),
                    ],
                  ),
                );
              }
              return SizedBox.shrink();
            },
          ),
          AppWidget.width(4.0),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<DetailsBloc, DetailsState>(
          builder: (context, state) {
            if (state is ProductDetailsLoadingState) {
              return Center(child: ProductDetailsLoading(
                onRefresh: () async {
                  context.read<DetailsBloc>().add(ProductDetailsInitEvent(productID: widget.productId));
                },
              ));
            } else if (state is ProductDetailLoadedState) {
              final product = state.product;
              return product.image == null || product.image!.isEmpty
                  ? Center(child: ProductDetailsLoading(
                      onRefresh: () async {
                        context.read<DetailsBloc>().add(ProductDetailsInitEvent(productID: widget.productId));
                      },
                    ))
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 300,
                            child: Image.network(
                              product.image ?? '',
                              fit: BoxFit.fill,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(image: AssetImage(placeholderImage), fit: BoxFit.fill),
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product.title ?? '', style: AppTextStyles.title()),
                                AppWidget.height(8),
                                Row(
                                  children: [
                                    Text(
                                      product.price != null ? '৳${product.price}' : '',
                                      style: AppTextStyles.regular(fontWeight: FontWeight.w600, color: AppColors.green),
                                    ),
                                    AppWidget.width(4),
                                    Text(
                                      product.price != null ? "৳${(product.price! + 20).toStringAsFixed(2)}" : '',
                                      style: AppTextStyles.discountStrikeStyle(),
                                    ),
                                  ],
                                ),
                                AppWidget.height(8),
                                product.description != null ? Text('Description', style: AppTextStyles.title()) : SizedBox.shrink(),
                                AppWidget.height(8),
                                Text(product.description ?? '', style: AppTextStyles.regular()),
                                AppWidget.height(12),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
            } else if (state is ProductDetailsErrorState) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 60, color: AppColors.dartRed),
                      AppWidget.height(12),
                      Text('Error: ${state.message}', style: AppTextStyles.errorStyle()),
                      AppWidget.height(12),
                      ElevatedButton(
                        onPressed: () {
                          context.read<DetailsBloc>().add(ProductDetailsInitEvent(productID: widget.productId));
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<DetailsBloc, DetailsState>(
        builder: (context, state) {
          if (state is ProductDetailLoadedState) {
            return state.product.image != null && state.product.image!.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(bottom: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            height: 40,
                            title: "Buy now",
                            isLoading: false,
                            borderRadius: 20,
                            backgroundColor: AppColors.toneColor,
                            onPressed: () {},
                          ),
                        ),
                        AppWidget.width(16),
                        Expanded(
                          child: AppButton(
                            height: 40,
                            title: "Add to cart",
                            isLoading: false,
                            borderRadius: 20,
                            backgroundColor: AppColors.primaryColor,
                            onPressed: () {
                              context.read<DetailsBloc>().add(AddToCartEvent(product: state.product));
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox.shrink();
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
