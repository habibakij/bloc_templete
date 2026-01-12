import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_template/data/model/custom/add_to_cart_model.dart';
import 'package:flutter_bloc_template/data/repositories/product_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  ProductRepository repository;

  CartBloc(this.repository) : super(CartInitialState()) {
    on<CartLoadingEvent>(onCartProductLoading);
    on<CartProductIncrement>(onIncrementProductQuantity);
    on<CartProductDecrement>(onDecrementProductQuantity);
  }

  /// loading product cart list
  Future<void> onCartProductLoading(CartLoadingEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState());
    try {
      final cartProducts = repository.getCartProducts();
      emit(CartLoadedState(cartProducts));
    } catch (e) {
      emit(CartErrorState(e.toString()));
    }
  }

  /// product quantity increment
  FutureOr<void> onIncrementProductQuantity(CartProductIncrement event, Emitter<CartState> emit) {
    emit(CartLoadingState());
    final productIndex = event.cartProductIndex;
    final List<AddToCartModel> cartProducts = event.cartProductList;

    for (var p in cartProducts) {
      if (p.productDetailsModel?.id == cartProducts[productIndex].productDetailsModel?.id) {
        p.quantity = (p.quantity ?? 0) + 1;
        break;
      }
    }
    emit(CartLoadedState(cartProducts));
  }

  /// product quantity increment
  FutureOr<void> onDecrementProductQuantity(CartProductDecrement event, Emitter<CartState> emit) {
    emit(CartLoadingState());
    final productIndex = event.cartProductIndex;
    final List<AddToCartModel> cartProducts = event.cartProductList;

    for (var p in cartProducts) {
      if (p.productDetailsModel?.id == cartProducts[productIndex].productDetailsModel?.id) {
        p.quantity = (p.quantity ?? 0) - 1;
        break;
      }
    }
    emit(CartLoadedState(cartProducts));
  }

  double cartItemPriceCalculation(double price, int quantity) {
    return price * quantity;
  }

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
