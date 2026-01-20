part of 'checkout_bloc.dart';

sealed class CheckoutState extends Equatable {
  const CheckoutState();
}

final class CheckoutInitial extends CheckoutState {
  const CheckoutInitial();

  @override
  List<Object> get props => [];
}

class CheckoutLoadingState extends CheckoutState {
  const CheckoutLoadingState();

  @override
  List<Object?> get props => [];
}

class CheckoutLoadedState extends CheckoutState {
  final List<AddToCartModel> checkoutProductList;
  const CheckoutLoadedState({required this.checkoutProductList});

  @override
  List<Object?> get props => [checkoutProductList];
}

class CheckoutErrorState extends CheckoutState {
  final String message;
  const CheckoutErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
