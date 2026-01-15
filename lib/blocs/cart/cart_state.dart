part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

final class CartInitialState extends CartState {
  const CartInitialState();
}

class CartLoadingState extends CartState {
  const CartLoadingState();
}

class CartLoadedState extends CartState {
  final List<AddToCartModel> cartProductList;
  const CartLoadedState(this.cartProductList);

  @override
  List<Object?> get props => [cartProductList];
}

class CartErrorState extends CartState {
  final String message;
  const CartErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
