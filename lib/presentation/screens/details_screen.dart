import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/blocs/details/details_bloc.dart';
import 'package:flutter_bloc_template/core/theme/app_style.dart';
import 'package:flutter_bloc_template/core/utils/helper/color_manager.dart';
import 'package:flutter_bloc_template/core/utils/widget/app_widget.dart';
import 'package:flutter_bloc_template/presentation/widgets/shimmer/details/product_details_loading.dart';

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
      appBar: AppBar(
        title: Text('Product Details', style: AppTextStyles.title()),
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<DetailsBloc, DetailsState>(
          builder: (context, state) {
            if (state is ProductDetailsLoadingState) {
              return const Center(child: ProductDetailsLoading());
            } else if (state is ProductDetailLoadedState) {
              final product = state.product;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 300,
                      child: Image.network(
                        product.image ?? '',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported),
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
                                '৳${product.price}',
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
                          Text('Description', style: AppTextStyles.title()),
                          AppWidget.height(8),
                          Text(product.description ?? '', style: AppTextStyles.regular()),
                          AppWidget.height(12),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Added to cart!'), duration: Duration(seconds: 1)),
                                );
                              },
                              child: const Text('Add to Cart', style: TextStyle(fontSize: 18)),
                            ),
                          ),
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
            return const Center(child: Text('Loading...'));
          },
        ),
      ),
    );
  }
}
