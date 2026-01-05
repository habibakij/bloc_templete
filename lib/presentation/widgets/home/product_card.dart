import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/core/navigation/app_routes.dart';
import 'package:flutter_bloc_template/core/theme/app_style.dart';
import 'package:flutter_bloc_template/core/utils/helper/color_manager.dart';
import 'package:flutter_bloc_template/core/utils/widget/app_widget.dart';
import 'package:flutter_bloc_template/data/model/response/product_model.dart';
import 'package:go_router/go_router.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductModel product;
  const ProductCardWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.red.withValues(alpha: 0.1), blurRadius: 8, offset: const Offset(0, 4))],
      ),
      child: InkWell(
        onTap: () {
          context.pushNamed(AppRoutes.DETAILS_SCREEN, pathParameters: {'id': product.id.toString()});
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(product.image ?? '', width: double.infinity, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.regular(fontWeight: FontWeight.w600),
                  ),
                  AppWidget.height(4),
                  Row(
                    children: [
                      Text(
                        "৳${product.price}",
                        style: AppTextStyles.regular(color: AppColors.red, fontWeight: FontWeight.w600),
                      ),
                      AppWidget.width(4),
                      Text(
                        product.price != null ? "৳${(product.price! + 20).toStringAsFixed(2)}" : '',
                        style: AppTextStyles.discountStrikeStyle(),
                      ),
                    ],
                  ),
                  AppWidget.height(4),
                  Row(
                    children: [
                      Icon(Icons.star, size: 18, color: AppColors.orangeColor),
                      AppWidget.width(4),
                      Text(
                        '${product.rating?.rate ?? ''} (${product.rating?.count ?? ''})',
                        style: AppTextStyles.regular(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
