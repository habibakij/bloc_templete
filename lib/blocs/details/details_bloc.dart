import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_template/data/model/custom/add_to_cart_model.dart';
import 'package:flutter_bloc_template/data/model/response/product_details_model.dart';
import 'package:flutter_bloc_template/data/model/response/product_model.dart';
import 'package:flutter_bloc_template/data/repositories/product_repository.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final ProductRepository repository;
  DetailsBloc(this.repository) : super(ProductDetailsInit()) {
    on<ProductDetailsInitEvent>(onFetchDetailsData);
    on<AddProductQuantityEvent>(onIncrementProductQuantity);
    on<RemoveProductQuantityEvent>(onDecrementProductQuantity);
    on<AddToCartEvent>(onAddToCart);
  }

  /// get product details
  List<ProductModel> likeProductList = [];
  FutureOr<void> onFetchDetailsData(ProductDetailsInitEvent event, Emitter<DetailsState> emit) async {
    emit(const ProductDetailsLoadingState());
    repository.resetProductQuantity();
    try {
      final productDetails = await repository.getProductById(event.productID ?? 0);
      final cartProducts = repository.getCartProducts();
      final productQuantity = repository.getQuantity;
      if (likeProductList.isEmpty) {
        likeProductList = await repository.getProducts() ?? [];
      }
      if (likeProductList.any((p) => p.id == productDetails?.id)) {
        likeProductList.removeWhere((p) => p.id == productDetails?.id);
      }
      emit(ProductDetailLoadedState(likeProductList, productDetails ?? ProductDetailsModel(), cartProducts, productQuantity));
    } catch (e) {
      emit(ProductDetailsErrorState(e.toString()));
    }
  }

  /// product quantity increment
  FutureOr<void> onIncrementProductQuantity(AddProductQuantityEvent event, Emitter<DetailsState> emit) {
    emit(const ProductDetailsLoadingState());
    repository.addProductQuantity();
    final quantity = repository.getQuantity;
    emit(ProductDetailLoadedState(event.likeProductList, event.productDetails, event.cartProductsList, quantity));
  }

  /// product quantity decrement
  FutureOr<void> onDecrementProductQuantity(RemoveProductQuantityEvent event, Emitter<DetailsState> emit) {
    emit(const ProductDetailsLoadingState());
    repository.removeProductQuantity();
    final quantity = repository.getQuantity;
    emit(ProductDetailLoadedState(event.likeProductList, event.productDetails, event.cartProductsList, quantity));
  }

  /// product add to cart
  FutureOr<void> onAddToCart(AddToCartEvent event, Emitter<DetailsState> emit) {
    emit(const ProductDetailsLoadingState());
    final quantity = repository.getQuantity;
    repository.addToCart(
      AddToCartModel(
        uID: DateTime.now().microsecondsSinceEpoch,
        quantity: quantity,
        productDetailsModel: event.productDetails,
      ),
    );
    final cartProducts = repository.getCartProducts();
    emit(ProductDetailLoadedState(event.likeProductList, event.productDetails, cartProducts, quantity));
  }
}
