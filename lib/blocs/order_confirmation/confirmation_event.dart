part of 'confirmation_bloc.dart';

sealed class ConfirmationEvent extends Equatable {
  const ConfirmationEvent();
  @override
  List<Object?> get props => [];
}

class CartClearEvent extends ConfirmationEvent {
  const CartClearEvent();
}
