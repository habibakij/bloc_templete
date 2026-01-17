import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/blocs/my_order/order_bloc.dart';
import 'package:flutter_bloc_template/core/navigation/app_routes.dart';
import 'package:flutter_bloc_template/core/theme/app_style.dart';
import 'package:flutter_bloc_template/core/utils/helper/asset_manager.dart';
import 'package:flutter_bloc_template/core/utils/helper/color_manager.dart';
import 'package:flutter_bloc_template/core/utils/widget/app_button.dart';
import 'package:flutter_bloc_template/core/utils/widget/common_app_bar.dart';
import 'package:flutter_bloc_template/presentation/widgets/my_order/active_order.dart';
import 'package:flutter_bloc_template/presentation/widgets/my_order/archive_order.dart';
import 'package:flutter_bloc_template/presentation/widgets/shimmer/cart/cart_loading.dart';
import 'package:go_router/go_router.dart';

class MyOrder extends StatelessWidget {
  const MyOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      animationDuration: Duration(milliseconds: 500),
      child: Scaffold(
        appBar: CommonAppBar(
          title: "My Orders",
          leadingVisibility: true,
          onLeadingTab: () {
            context.goNamed(AppRoutes.HOME_SCREEN);
          },
          bottomWidget: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Stack(
              alignment: Alignment.center,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(color: AppColors.primaryLiteColor),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: AppColors.primaryDarkColor,
                    labelStyle: AppTextStyles.title(fontSize: 16.0),
                    unselectedLabelStyle: AppTextStyles.regular(),
                    tabs: [
                      Tab(text: "Active"),
                      Tab(text: "Archive"),
                    ],
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width / 2,
                  child: Container(height: 40, width: 1, color: AppColors.greyLiteBorder),
                ),
              ],
            ),
          ),
        ),
        body: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is OrderLoadingState) {
              return TabBarView(
                children: [
                  CartLoading(),
                  CartLoading(),
                ],
              );
            } else if (state is OrderLoadedState) {
              return TabBarView(
                children: [
                  ActiveOrder(activeOrderList: state.orderList),
                  ArchiveOrder(archiveOrderList: state.orderList),
                ],
              );
            } else if (state is OrderEmptyState) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 12.0,
                    children: [
                      Image.asset(emptyIcon, fit: BoxFit.cover),
                      RichText(
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        maxLines: 2,
                        text: TextSpan(
                          text: "There are no orders to your box.",
                          style: AppTextStyles.regular(),
                          children: <TextSpan>[
                            TextSpan(text: "Explore products and place an order to see it here.", style: AppTextStyles.regular(fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                      AppButton(
                        height: 40,
                        title: "Order now",
                        isLoading: false,
                        borderRadius: 20,
                        backgroundColor: AppColors.toneColor,
                        onPressed: () {
                          context.goNamed(AppRoutes.HOME_SCREEN);
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
            return Center(child: Text("Loading data..."));
          },
        ),
      ),
    );
  }
}
