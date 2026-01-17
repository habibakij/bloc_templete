part of 'checkout_bloc.dart';

sealed class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object?> get props => [];
}

class CheckoutLoadingEvent extends CheckoutEvent {
  const CheckoutLoadingEvent();
}
