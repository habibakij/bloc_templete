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
    on<CheckoutLoadingEvent>(onCheckoutDataLoading);
  }

  /// fetching checkout data
  FutureOr<void> onCheckoutDataLoading(CheckoutLoadingEvent event, Emitter<CheckoutState> emit) {
    emit(CheckoutLoadingState());
    try {
      final checkoutProductList = repository.getCartProducts();
      emit(CheckoutLoadedState(checkoutProductList: checkoutProductList));
    } catch (e) {
      emit(CheckoutErrorState(e.toString()));
    }
  }

  /// checkout single list item price calculation
  double cartItemPriceCalculation(double price, int quantity) {
    return price * quantity;
  }

  /// calculation sub total price
  double calculationSubTotal({required List<AddToCartModel> checkoutProductList}) {
    double subTotal = 0;
    for (var e in checkoutProductList) {
      double price = e.productDetailsModel?.price ?? 0;
      int quantity = e.quantity ?? 1;
      subTotal = subTotal + (price * quantity);
    }
    return subTotal;
  }
}
