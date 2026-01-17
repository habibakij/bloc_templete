import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/core/theme/app_style.dart';
import 'package:flutter_bloc_template/core/utils/helper/color_manager.dart';
import 'package:flutter_bloc_template/core/utils/widget/app_widget.dart';

class CartQuantityAction extends StatelessWidget {
  final String price;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const CartQuantityAction({super.key, required this.price, required this.quantity, required this.onAdd, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: Row(
        children: [
          Text(
            "৳$price",
            style: AppTextStyles.title(fontSize: 14),
          ),
          AppWidget.width(12),
          InkWell(
            radius: 4,
            focusColor: AppColors.grey,
            onTap: onRemove,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.greyLiteBorder),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6),
                child: quantity < 2 ? Icon(Icons.delete, size: 12, color: AppColors.darkRed) : Icon(Icons.remove, size: 12, color: AppColors.darkRed),
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
          InkWell(
            radius: 4,
            focusColor: AppColors.grey,
            onTap: onAdd,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6),
                child: Icon(Icons.add, size: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
