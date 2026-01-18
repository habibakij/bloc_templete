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
    on<CheckoutApplyCouponEvent>(onCheckoutCouponApply);
  }

  /// fetching checkout data
  FutureOr<void> onCheckoutDataLoading(CheckoutLoadingEvent event, Emitter<CheckoutState> emit) {
    emit(CheckoutLoadingState());
    try {
      final checkoutProductList = repository.getCartProducts();
      emit(CheckoutLoadedState(checkoutProductList, 0, ""));
    } catch (e) {
      emit(CheckoutErrorState(e.toString()));
    }
  }

  /// applying coupon code
  FutureOr<void> onCheckoutCouponApply(CheckoutApplyCouponEvent event, Emitter<CheckoutState> emit) {
    emit(CheckoutApplyingCouponState());
    if (couponCode == event.couponText) {
      double subTotal = event.subTotal;
      double couponDiscountAmount = ((subTotal / 100) * couponDiscountPercentage);
      double finalSubTotal = subTotal - couponDiscountAmount;
      emit(CheckoutLoadedState(event.checkoutProductList, finalSubTotal, event.couponText));
    } else {
      emit(CheckoutLoadedState(event.checkoutProductList, 0, ""));
    }
  }

  /// checkout single list item price calculation
  double cartItemPriceCalculation(double price, int quantity) {
    return price * quantity;
  }

  /// discount (save) calculation
  double discountCalculation(List<AddToCartModel> cartProductList) {
    int totalQuantity = 0;
    for (var e in cartProductList) {
      int quantity = e.quantity ?? 1;
      totalQuantity = totalQuantity + quantity;
    }
    return (totalQuantity * 20);
  }

  /// calculation sub total price
  double calculationSubTotal(List<AddToCartModel> cartProductList) {
    double subTotal = 0;
    for (var e in cartProductList) {
      double price = e.productDetailsModel?.price ?? 0;
      int quantity = e.quantity ?? 1;
      subTotal = subTotal + (price * quantity);
    }
    return subTotal;
  }
}
