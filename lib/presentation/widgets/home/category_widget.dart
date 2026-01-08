import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/blocs/home/home_bloc.dart';
import 'package:flutter_bloc_template/core/theme/app_style.dart';
import 'package:flutter_bloc_template/core/utils/helper/color_manager.dart';
import 'package:flutter_bloc_template/data/model/response/product_model.dart';

class CategoryWidget extends StatelessWidget {
  final List<ProductModel> categoryList;
  final String selectedCategory;
  const CategoryWidget({super.key, required this.categoryList, required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.0,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: categoryList.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) {
          final category = categoryList[i].category ?? '';
          bool isSelected = category == selectedCategory;
          return GestureDetector(
            onTap: () {
              if (isSelected) {
                isSelected = false;
                context.read<HomeBloc>().add(FilterRemoveEvent());
              } else {
                context.read<HomeBloc>().add(FilterEvent(category));
              }
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryColor : AppColors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.greyLiteBorder),
              ),
              alignment: Alignment.center,
              child: Text(
                categoryList[i].category ?? '',
                style: isSelected ? AppTextStyles.regular(fontWeight: FontWeight.w600) : AppTextStyles.regular(),
              ),
            ),
          );
        },
      ),
    );
  }
}
