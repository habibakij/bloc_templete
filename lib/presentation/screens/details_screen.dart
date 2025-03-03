import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/core/theme/app_text_styles.dart';
import 'package:flutter_bloc_template/core/utils/widget/common_app_bar.dart';
import 'package:flutter_bloc_template/data/model/home_screen/item_list_model.dart';

class DetailsScreen extends StatelessWidget {
  final ItemListModel item;

  const DetailsScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "User ID: ${item.id}"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          item.title ?? "",
          style: AppTextStyles.bodyTextStyle(),
        ),
      ),
    );
  }
}
