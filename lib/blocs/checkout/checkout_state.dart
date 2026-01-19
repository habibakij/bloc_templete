part of 'checkout_bloc.dart';

sealed class CheckoutState extends Equatable {
  const CheckoutState();
}

final class CheckoutInitial extends CheckoutState {
  const CheckoutInitial();

  @override
  List<Object> get props => [];
}

class CheckoutLoadingState extends CheckoutState {
  const CheckoutLoadingState();

  @override
  List<Object?> get props => [];
}

class CheckoutLoadedState extends CheckoutState {
  final List<AddToCartModel> checkoutProductList;
  final double couponDiscountAmount;
  final String appliedCouponCode;
  const CheckoutLoadedState({required this.checkoutProductList, required this.couponDiscountAmount, required this.appliedCouponCode});

  @override
  List<Object?> get props => [checkoutProductList, couponDiscountAmount, appliedCouponCode];
}

class CheckoutApplyingCouponState extends CheckoutState {
  const CheckoutApplyingCouponState();

  @override
  List<Object?> get props => [];
}

class CheckoutRemoveCouponState extends CheckoutState {
  const CheckoutRemoveCouponState();

  @override
  List<Object?> get props => [];
}

class CheckoutErrorState extends CheckoutState {
  final String message;
  const CheckoutErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
