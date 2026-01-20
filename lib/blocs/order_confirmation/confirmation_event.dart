part of 'confirmation_bloc.dart';

sealed class ConfirmationEvent extends Equatable {
  const ConfirmationEvent();
  @override
  List<Object?> get props => [];
}

class ConfirmationInitEvent extends ConfirmationEvent {
  const ConfirmationInitEvent();
}

class CartClearEvent extends ConfirmationEvent {
  const CartClearEvent();
}

class AddToOrderEvent extends ConfirmationEvent {
  const AddToOrderEvent();
}
