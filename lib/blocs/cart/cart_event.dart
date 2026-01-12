part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();
  @override
  List<Object?> get props => [];
}

class CartLoadingEvent extends CartEvent {
  const CartLoadingEvent();
}

class CartProductIncrement extends CartEvent {
  final List<AddToCartModel> cartProductList;
  final int cartProductIndex;
  const CartProductIncrement({required this.cartProductList, required this.cartProductIndex});
}

class CartProductDecrement extends CartEvent {
  final List<AddToCartModel> cartProductList;
  final int cartProductIndex;
  const CartProductDecrement({required this.cartProductList, required this.cartProductIndex});
}
