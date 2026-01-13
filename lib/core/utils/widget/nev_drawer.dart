import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/core/navigation/app_routes.dart';
import 'package:flutter_bloc_template/core/theme/app_style.dart';
import 'package:flutter_bloc_template/core/utils/helper/color_manager.dart';
import 'package:go_router/go_router.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppColors.primaryColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.person, size: 80),
                Text("Akij Khan", style: AppTextStyles.regular()),
                Text("ak.khan@example.com", style: AppTextStyles.regular()),
              ],
            ),
          ),
          _buildDrawerItem(
            icon: Icons.shopping_cart,
            text: "My Order",
            onTap: () {
              context.pushNamed(AppRoutes.MY_ORDER);
              Navigator.pop(context);
              debugPrint("my_order");
            },
          ),
          _buildDrawerItem(
            icon: Icons.person,
            text: "Profile",
            onTap: () {
              Navigator.pop(context);
              debugPrint("profile");
            },
          ),
          const Divider(),
          _buildDrawerItem(
            icon: Icons.logout,
            text: "Logout",
            onTap: () {
              Navigator.pop(context);
              debugPrint("logout");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({required IconData icon, required String text, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryColor),
      title: Text(text, style: AppTextStyles.regular(fontWeight: FontWeight.w500)),
      onTap: onTap,
    );
  }
}
