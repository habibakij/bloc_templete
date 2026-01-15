import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/blocs/my_order/order_bloc.dart';
import 'package:flutter_bloc_template/core/navigation/app_routes.dart';
import 'package:flutter_bloc_template/core/theme/app_style.dart';
import 'package:flutter_bloc_template/core/utils/helper/asset_manager.dart';
import 'package:flutter_bloc_template/core/utils/helper/color_manager.dart';
import 'package:flutter_bloc_template/core/utils/widget/app_widget.dart';
import 'package:flutter_bloc_template/data/model/custom/add_to_cart_model.dart';
import 'package:go_router/go_router.dart';

class ArchiveOrder extends StatelessWidget {
  final List<AddToCartModel> archiveOrderList;
  const ArchiveOrder({super.key, required this.archiveOrderList});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: archiveOrderList.length,
      separatorBuilder: (_, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final item = archiveOrderList[index];
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: AppColors.black.withValues(alpha: 0.05), blurRadius: 6, offset: const Offset(0, 2)),
            ],
          ),
          child: InkWell(
            onTap: () {
              context.pushNamed(AppRoutes.DETAILS_SCREEN, pathParameters: {'id': item.productDetailsModel?.id.toString() ?? ''});
            },
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
                        width: 80,
                        height: 80,
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
                        item.productDetailsModel?.category ?? "",
                        style: AppTextStyles.hintStyle(),
                      ),
                      AppWidget.height(2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  Text("seller ", style: AppTextStyles.regular(fontSize: 12)),
                                  Text("Cart up", style: AppTextStyles.regular(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.primaryDarkColor)),
                                ],
                              ),
                              AppWidget.width(12),
                              Text(
                                "৳${context.read<OrderBloc>().cartItemPriceCalculation(item.productDetailsModel?.price ?? 0, item.quantity ?? 1).toStringAsFixed(2)}",
                                style: AppTextStyles.title(fontSize: 14),
                              ),
                            ],
                          ),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              color: AppColors.greyLiteBorder,
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                              child: Text(
                                "complete",
                                style: AppTextStyles.regular(),
                              ),
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
      },
    );
  }
}
