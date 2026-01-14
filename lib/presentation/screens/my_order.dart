import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/core/navigation/app_routes.dart';
import 'package:flutter_bloc_template/core/theme/app_style.dart';
import 'package:flutter_bloc_template/core/utils/helper/color_manager.dart';
import 'package:flutter_bloc_template/core/utils/widget/common_app_bar.dart';
import 'package:flutter_bloc_template/presentation/widgets/my_order/active_order.dart';
import 'package:flutter_bloc_template/presentation/widgets/my_order/archive_order.dart';
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
        body: TabBarView(
          children: [
            ActiveOrder(),
            ArchiveOrder(),
          ],
        ),
      ),
    );
  }
}
