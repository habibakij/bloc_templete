import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_template/data/model/custom/add_to_cart_model.dart';
import 'package:flutter_bloc_template/data/repositories/product_repository.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  ProductRepository repository;

  CheckoutBloc(this.repository) : super(CheckoutInitial()) {
    on<CheckoutLoadingEvent>(onCartDataLoading);
  }

  FutureOr<void> onCartDataLoading(CheckoutLoadingEvent event, Emitter<CheckoutState> emit) {
    emit(CheckoutLoadingState());
    try {
      final cartProducts = repository.getCartProducts();
      emit(CheckoutLoadedState(cartProducts));
    } catch (e) {
      emit(CheckoutErrorState(e.toString()));
    }
  }

  /// cart single item price calculation
  double cartItemPriceCalculation(double price, int quantity) {
    return price * quantity;
  }

  /// discount calculation
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
