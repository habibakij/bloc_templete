import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/blocs/home/home_bloc.dart';
import 'package:flutter_bloc_template/core/theme/app_style.dart';
import 'package:flutter_bloc_template/core/utils/helper/color_manager.dart';
import 'package:flutter_bloc_template/core/utils/widget/app_widget.dart';
import 'package:flutter_bloc_template/presentation/widgets/home/category_widget.dart';
import 'package:flutter_bloc_template/presentation/widgets/home/product_card.dart';
import 'package:flutter_bloc_template/presentation/widgets/shimmer/home/category_loading.dart';
import 'package:flutter_bloc_template/presentation/widgets/shimmer/home/products_loading.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Flutter BLoC", style: AppTextStyles.title()),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is ProductLoadingState) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<HomeBloc>().add(DataFetchingEvent());
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppWidget.height(12),
                    CategoryLoading(),
                    AppWidget.height(12),
                    Expanded(child: ProductsLoading()),
                  ],
                ),
              );
            } else if (state is ProductLoadedState) {
              context.read<HomeBloc>().productList = state.products;
              context.read<HomeBloc>().categoryList = state.categoryList;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppWidget.height(12),
                  CategoryWidget(categoryList: state.categoryList, selectedCategory: ''),
                  AppWidget.height(12),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.products.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.85,
                      ),
                      itemBuilder: (_, i) => ProductCardWidget(product: state.products[i]),
                    ),
                  ),
                ],
              );
            } else if (state is ProductFilterState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppWidget.height(12),
                  CategoryWidget(categoryList: context.read<HomeBloc>().categoryList, selectedCategory: state.selectedCategory ?? ''),
                  AppWidget.height(12),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.filteringList.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.85,
                      ),
                      itemBuilder: (_, i) => ProductCardWidget(product: state.filteringList[i]),
                    ),
                  ),
                ],
              );
            } else if (state is ProductErrorState) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(child: Text(state.message, textAlign: TextAlign.center)),
              );
            }
            return Center(child: Text("Loading..."));
          },
        ),
      ),
    );
  }
}
