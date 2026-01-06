import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/core/utils/helper/asset_manager.dart';
import 'package:flutter_bloc_template/core/utils/widget/app_widget.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailsLoading extends StatelessWidget {
  final Future<void> Function()? onRefresh;
  const ProductDetailsLoading({super.key, this.onRefresh});
  static final _baseColor = Colors.grey.shade300;
  static final _highlightColor = Colors.grey.shade100;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh ?? () async {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8).copyWith(top: 8),
        child: ListView(
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(placeholderImage), fit: BoxFit.fill),
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
            ),
            AppWidget.height(16),
            _shimmerBox(height: 40, radius: 2),
            AppWidget.height(4),
            ...List.generate(
              15,
              (_) => Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: _shimmerBox(height: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _shimmerBox({required double height, double? width, double radius = 4}) {
    return SizedBox(
      height: height,
      width: width ?? double.infinity,
      child: Shimmer.fromColors(
        baseColor: _baseColor,
        highlightColor: _highlightColor,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
    );
  }
}
