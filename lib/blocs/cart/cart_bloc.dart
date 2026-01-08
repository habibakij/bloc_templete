import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_template/data/model/response/product_details_model.dart';
import 'package:flutter_bloc_template/data/repositories/product_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  ProductRepository repository;

  CartBloc(this.repository) : super(CartInitialState()) {
    on<CartLoadingEvent>(onCartProductLoading);
  }

  Future<void> onCartProductLoading(CartLoadingEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState());
    try {
      final cartProducts = repository.getCartProducts();
      final totalPrice = cartProducts.fold<double>(0, (sum, product) => sum + (product.price ?? 0)).toInt();
      emit(CartLoadedState(cartProducts, totalPrice: totalPrice));
    } catch (e) {
      emit(CartErrorState(e.toString()));
    }
  }
}
