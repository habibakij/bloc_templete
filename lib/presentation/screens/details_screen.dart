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
import 'package:flutter_bloc_template/presentation/widgets/details/product_details_card.dart';
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
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.greyLiteBorder.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    focusColor: AppColors.toneColor,
                    onTap: () {
                      context.pushNamed(AppRoutes.CART_SCREEN);
                    },
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                          child: Icon(size: 16.0, Icons.shopping_cart, color: AppColors.primaryDarkTinColor),
                        ),
                        Positioned(
                          right: 10.0,
                          top: 4.0,
                          child: Text(
                            "${state.cartProductsList.length}",
                            style: AppTextStyles.regular(color: AppColors.white, fontWeight: FontWeight.w600),
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
              final productDetails = state.productDetails;
              return productDetails.image == null || productDetails.image!.isEmpty
                  ? Center(child: ProductDetailsLoading(
                      onRefresh: () async {
                        context.read<DetailsBloc>().add(ProductDetailsInitEvent(productID: widget.productId));
                      },
                    ))
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            constraints: const BoxConstraints(maxHeight: 500),
                            child: Image.network(
                              productDetails.image ?? '',
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
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(productDetails.title ?? '', style: AppTextStyles.title()),
                                AppWidget.height(8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          productDetails.price != null ? "৳${productDetails.price?.toStringAsFixed(2)}" : "",
                                          style: AppTextStyles.title(fontWeight: FontWeight.w600, color: AppColors.primaryColor),
                                        ),
                                        AppWidget.width(4),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 2.0),
                                          child: Text(
                                            productDetails.price != null ? "৳${(productDetails.price! + 20).toStringAsFixed(2)}" : '',
                                            style: AppTextStyles.discountStrikeStyle(),
                                          ),
                                        ),
                                      ],
                                    ),
                                    AppWidget.width(30),
                                    InkWell(
                                      radius: 4,
                                      focusColor: AppColors.grey,
                                      onTap: () {
                                        context.read<DetailsBloc>().add(RemoveProductQuantityEvent(likeProductList: state.likeProductList, productDetails: productDetails, cartProductsList: state.cartProductsList));
                                      },
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: AppColors.greyLiteBorder),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
                                          child: Icon(Icons.remove, size: 18, color: AppColors.primaryDarkColor),
                                        ),
                                      ),
                                    ),
                                    AppWidget.width(8),
                                    Text(
                                      state.productQuantity.toString(),
                                      style: AppTextStyles.regular(),
                                    ),
                                    AppWidget.width(8),
                                    InkWell(
                                      radius: 4,
                                      focusColor: AppColors.red,
                                      onTap: () {
                                        context.read<DetailsBloc>().add(AddProductQuantityEvent(likeProductList: state.likeProductList, productDetails: productDetails, cartProductsList: state.cartProductsList));
                                      },
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: AppColors.greyLiteBorder),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
                                          child: Icon(Icons.add, size: 18, color: AppColors.primaryDarkColor),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.star, size: 20, color: AppColors.orangeColor),
                                    AppWidget.width(4),
                                    Text(
                                      '${productDetails.rating?.rate ?? ''} (${productDetails.rating?.count ?? ''})',
                                      style: AppTextStyles.regular(),
                                    ),
                                  ],
                                ),
                                AppWidget.height(8),
                                productDetails.description != null ? Text('Description', style: AppTextStyles.title()) : SizedBox.shrink(),
                                AppWidget.height(8),
                                Text(productDetails.description ?? '', style: AppTextStyles.regular()),
                                AppWidget.height(8),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text('You may like', style: AppTextStyles.title()),
                          ),
                          SizedBox(
                            height: 220,
                            child: ListView.separated(
                              padding: const EdgeInsets.all(12),
                              itemCount: state.likeProductList.length,
                              separatorBuilder: (_, index) => const SizedBox(width: 10),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final singleProduct = state.likeProductList[index];
                                return ProductDetailsCardWidget(product: singleProduct);
                              },
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
                      Icon(Icons.error_outline, size: 60, color: AppColors.darkRed),
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
            return state.productDetails.image != null && state.productDetails.image!.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(bottom: 16.0, top: 8.0),
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
                              context.read<DetailsBloc>().add(AddToCartEvent(likeProductList: state.likeProductList, productDetails: state.productDetails));
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
