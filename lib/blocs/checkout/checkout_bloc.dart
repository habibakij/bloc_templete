import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_template/data/model/custom/add_to_cart_model.dart';
import 'package:flutter_bloc_template/data/repositories/product_repository.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  ProductRepository repository;
  String couponCode = "habib";
  double couponDiscountPercentage = 4.8;
  CheckoutBloc(this.repository) : super(CheckoutInitial()) {
    on<CheckoutLoadingEvent>(onCheckoutDataLoading);
    on<CheckoutApplyCouponEvent>(onCheckoutApplyCoupon);
  }

  /// fetching checkout data
  FutureOr<void> onCheckoutDataLoading(CheckoutLoadingEvent event, Emitter<CheckoutState> emit) {
    emit(CheckoutLoadingState());
    try {
      final checkoutProductList = repository.getCartProducts();
      emit(CheckoutLoadedState(checkoutProductList: checkoutProductList, couponDiscountAmount: 0, appliedCouponCode: ""));
    } catch (e) {
      emit(CheckoutErrorState(e.toString()));
    }
  }

  /// applying coupon code
  FutureOr<void> onCheckoutApplyCoupon(CheckoutApplyCouponEvent event, Emitter<CheckoutState> emit) async {
    emit(CheckoutApplyingCouponState());
    if (couponCode == event.couponText) {
      double subTotal = event.subTotal;
      double couponDiscountAmount = ((subTotal / 100) * couponDiscountPercentage);
      double finalSubTotal = subTotal - couponDiscountAmount;
      emit(CheckoutLoadedState(checkoutProductList: event.checkoutProductList, couponDiscountAmount: couponDiscountAmount, appliedCouponCode: event.couponText));
    } else {
      emit(CheckoutLoadedState(checkoutProductList: event.checkoutProductList, couponDiscountAmount: 0, appliedCouponCode: ""));
    }
  }

  /// remove coupon code
  FutureOr<void> onCheckoutRemoveCoupon(CheckoutRemoveCouponEvent event, Emitter<CheckoutState> emit) async {
    emit(CheckoutRemoveCouponState());
    double couponDiscountAmount = event.couponDiscountAmount;
    emit(CheckoutLoadedState(checkoutProductList: event.checkoutProductList, couponDiscountAmount: 0, appliedCouponCode: ""));
  }

  /// checkout single list item price calculation
  double cartItemPriceCalculation(double price, int quantity) {
    return price * quantity;
  }

  /// discount (save) calculation flat 20tk save
  double discountCalculation(List<AddToCartModel> cartProductList) {
    int totalQuantity = 0;
    for (var e in cartProductList) {
      int quantity = e.quantity ?? 1;
      totalQuantity = totalQuantity + quantity;
    }
    return (totalQuantity * 20);
  }

  /// calculation sub total price
  double calculationSubTotal({required List<AddToCartModel> checkoutProductList, required double couponDiscountAmount}) {
    double subTotal = 0;
    for (var e in checkoutProductList) {
      double price = e.productDetailsModel?.price ?? 0;
      int quantity = e.quantity ?? 1;
      subTotal = subTotal + (price * quantity);
    }
    return (subTotal - couponDiscountAmount);
  }
}
