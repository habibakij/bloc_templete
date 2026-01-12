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
  }

  /// loading product cart list
  Future<void> onCartProductLoading(CartLoadingEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState());
    try {
      final cartProducts = repository.getCartProducts();
      final totalPrice = cartProducts.fold<double>(0, (sum, product) => sum + (product.productDetailsModel?.price ?? 0)).toDouble();
      emit(CartLoadedState(cartProducts, totalPrice: totalPrice));
    } catch (e) {
      emit(CartErrorState(e.toString()));
    }
  }

  /* /// product quantity increment
  FutureOr<void> onIncrementProductQuantity(AddProductQuantityEvent event, Emitter<DetailsState> emit) {
    emit(const ProductDetailsLoadingState());
    repository.addProductQuantity();
    final quantity = repository.getQuantity;
    emit(ProductDetailLoadedState(event.product, event.cartProductsList, quantity));
  }

  /// product quantity decrement
  FutureOr<void> onDecrementProductQuantity(RemoveProductQuantityEvent event, Emitter<DetailsState> emit) {
    emit(const ProductDetailsLoadingState());
    repository.removeProductQuantity();
    final quantity = repository.getQuantity;
    emit(ProductDetailLoadedState(event.product, event.cartProductsList, quantity));
  }*/
}
