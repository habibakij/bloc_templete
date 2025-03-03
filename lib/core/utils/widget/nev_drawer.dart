import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/core/theme/app_text_styles.dart';

class CommonDrawer extends StatelessWidget {
  const CommonDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(
                  Icons.person,
                  size: 80,
                ),
                Text(
                  "John Doe",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "johndoe@example.com",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            icon: Icons.home,
            text: "Home",
            onTap: () {
              Navigator.pop(context);
              debugPrint("Home Clicked");
            },
          ),
          _buildDrawerItem(
            icon: Icons.settings,
            text: "Settings",
            onTap: () {
              Navigator.pop(context);
              debugPrint("Settings Clicked");
            },
          ),
          _buildDrawerItem(
            icon: Icons.info,
            text: "About",
            onTap: () {
              Navigator.pop(context);
              debugPrint("About Clicked");
            },
          ),
          const Divider(),
          _buildDrawerItem(
            icon: Icons.logout,
            text: "Logout",
            onTap: () {
              Navigator.pop(context);
              debugPrint("Logout Clicked");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
      {required IconData icon,
      required String text,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(text, style: AppTextStyles.bodyTextStyle()),
      onTap: onTap,
    );
  }
}
