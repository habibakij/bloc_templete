import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/core/theme/app_style.dart';
import 'package:flutter_bloc_template/core/utils/helper/color_manager.dart';
import 'package:flutter_bloc_template/core/utils/widget/common_app_bar.dart';

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
          leadingVisibility: false,
          bottomWidget: PreferredSize(
            preferredSize: Size.fromHeight(56.0),
            child: DecoratedBox(
              decoration: BoxDecoration(color: AppColors.primaryColor.withValues(alpha: 0.8)),
              child: TabBar(
                indicatorColor: AppColors.primaryDarkColor,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: [
                  Tab(text: "Active"),
                  Tab(text: "Archive"),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: 5,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return OrderCard(
                  orderId: "#ORD-00$index",
                  status: "Active",
                );
              },
            ),
            ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: 15,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return OrderCard(
                  orderId: "#ORD-00$index",
                  status: "Complete",
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final String orderId;
  final String status;

  const OrderCard({super.key, required this.orderId, required this.status});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              orderId,
              style: AppTextStyles.title(fontWeight: FontWeight.normal),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: status == "Active" ? AppColors.green.withValues(alpha: 0.1) : AppColors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                status,
                style: AppTextStyles.regular(
                  color: status == "Active" ? AppColors.green : AppColors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
