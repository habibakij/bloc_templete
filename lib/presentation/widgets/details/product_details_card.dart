import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/core/navigation/app_routes.dart';
import 'package:flutter_bloc_template/core/theme/app_style.dart';
import 'package:flutter_bloc_template/core/utils/helper/color_manager.dart';
import 'package:flutter_bloc_template/core/utils/widget/app_widget.dart';
import 'package:flutter_bloc_template/data/model/response/product_details_model.dart';
import 'package:go_router/go_router.dart';

class ProductDetailsCardWidget extends StatelessWidget {
  final ProductDetailsModel product;
  const ProductDetailsCardWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170.0,
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
                    style: AppTextStyles.regular(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  AppWidget.height(4),
                  Row(
                    children: [
                      Text("seller ", style: AppTextStyles.regular(fontSize: 12)),
                      Text("Cart up", style: AppTextStyles.regular(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.primaryColor)),
                    ],
                  ),
                  AppWidget.height(4),
                  Row(
                    children: [
                      Row(
                        children: [
                          Text(
                            "৳${product.price?.toStringAsFixed(2)}",
                            style: AppTextStyles.regular(color: AppColors.primaryColor, fontWeight: FontWeight.w500),
                          ),
                          AppWidget.width(2),
                          Text(
                            product.price != null ? "৳${(product.price! + 20).toStringAsFixed(2)}" : "",
                            style: AppTextStyles.discountStrikeStyle(fontSize: 10),
                          ),
                        ],
                      ),
                      AppWidget.width(4),
                      Expanded(
                        child: Row(
                          children: [
                            Icon(Icons.star, size: 16, color: AppColors.orangeColor),
                            AppWidget.width(2),
                            Flexible(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "${product.rating?.rate ?? ""} (${product.rating?.count ?? ""})",
                                  style: AppTextStyles.regular(),
                                ),
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
      ),
    );
  }
}
