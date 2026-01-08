import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_template/data/model/response/product_details_model.dart';
import 'package:flutter_bloc_template/data/repositories/product_repository.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final ProductRepository repository;
  DetailsBloc(this.repository) : super(ProductDetailsInit()) {
    on<ProductDetailsInitEvent>(onFetchDetailsData);
    on<AddToCartEvent>(onAddToCart);
  }

  /// get product details
  FutureOr<void> onFetchDetailsData(ProductDetailsInitEvent event, Emitter<DetailsState> emit) async {
    emit(const ProductDetailsLoadingState());
    try {
      final product = await repository.getProductById(event.productID ?? 0);
      final cartProducts = repository.getCartProducts();
      emit(ProductDetailLoadedState(product ?? ProductDetailsModel(), cartProducts));
    } catch (e) {
      emit(ProductDetailsErrorState(e.toString()));
    }
  }

  /// product add to cart
  FutureOr<void> onAddToCart(AddToCartEvent event, Emitter<DetailsState> emit) {
    emit(const ProductDetailsLoadingState());
    repository.addToCart(event.product);
    final cartProducts = repository.getCartProducts();
    emit(ProductDetailLoadedState(event.product, cartProducts));
  }
}
