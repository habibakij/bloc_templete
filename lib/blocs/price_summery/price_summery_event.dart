abstract class PriceSummaryEvent {}

class PriceSummeryInitEvent extends PriceSummaryEvent {
  final double subtotal;
  PriceSummeryInitEvent(this.subtotal);
}

class ApplyCouponEvent extends PriceSummaryEvent {
  final String couponCode;
  ApplyCouponEvent(this.couponCode);
}

class RemoveCouponEvent extends PriceSummaryEvent {}
