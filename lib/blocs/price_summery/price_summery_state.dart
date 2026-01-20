class PriceSummaryState {
  final double subtotal;
  final double offer;
  final String couponCode;
  final double couponDiscountAmount;
  final double total;

  const PriceSummaryState({
    required this.subtotal,
    required this.offer,
    required this.couponCode,
    required this.couponDiscountAmount,
    required this.total,
  });

  factory PriceSummaryState.initial() {
    return const PriceSummaryState(subtotal: 0, offer: 0, couponCode: '', couponDiscountAmount: 0, total: 0);
  }

  PriceSummaryState copyWith({double? subtotal, double? offer, String? couponCode, double? couponDiscountAmount, double? total}) {
    return PriceSummaryState(
      subtotal: subtotal ?? this.subtotal,
      offer: offer ?? this.offer,
      couponCode: couponCode ?? this.couponCode,
      couponDiscountAmount: couponDiscountAmount ?? this.couponDiscountAmount,
      total: total ?? this.total,
    );
  }
}
