part of 'checkout_bloc.dart';

sealed class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object?> get props => [];
}

class CheckoutLoadingEvent extends CheckoutEvent {
  const CheckoutLoadingEvent();
}

class CheckoutApplyCouponEvent extends CheckoutEvent {
  final String couponText;
  final double subTotal;
  final List<AddToCartModel> checkoutProductList;
  const CheckoutApplyCouponEvent({
    required this.couponText,
    required this.subTotal,
    required this.checkoutProductList,
  });
}
