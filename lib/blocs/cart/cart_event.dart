part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();
  @override
  List<Object?> get props => [];
}

class CartLoadingEvent extends CartEvent {
  const CartLoadingEvent();
}

class CartProductIncrementEvent extends CartEvent {
  final List<AddToCartModel> cartProductList;
  final int cartProductIndex;
  const CartProductIncrementEvent({required this.cartProductList, required this.cartProductIndex});
}

class CartProductDecrementEvent extends CartEvent {
  final List<AddToCartModel> cartProductList;
  final int cartProductIndex;
  const CartProductDecrementEvent({required this.cartProductList, required this.cartProductIndex});
}

class CartItemRemoveEvent extends CartEvent {
  final List<AddToCartModel> cartProductList;
  final int cartProductIndex;
  const CartItemRemoveEvent({required this.cartProductList, required this.cartProductIndex});
}
