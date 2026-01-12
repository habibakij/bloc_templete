part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();
}

final class CartInitialState extends CartState {
  @override
  List<Object> get props => [];
}

class CartLoadingState extends CartState {
  const CartLoadingState();

  @override
  List<Object?> get props => [];
}

class CartLoadedState extends CartState {
  final List<AddToCartModel> cartProductList;
  final double totalPrice;
  const CartLoadedState(this.cartProductList, {this.totalPrice = 0});

  @override
  List<Object?> get props => [cartProductList];
}

class CartErrorState extends CartState {
  final String message;
  const CartErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
