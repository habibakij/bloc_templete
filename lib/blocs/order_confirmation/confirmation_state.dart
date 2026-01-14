part of 'confirmation_bloc.dart';

sealed class ConfirmationState extends Equatable {
  const ConfirmationState();
}

final class ConfirmationInitialState extends ConfirmationState {
  const ConfirmationInitialState();

  @override
  List<Object> get props => [];
}

class CartClearingState extends ConfirmationState {
  const CartClearingState();

  @override
  List<Object?> get props => [];
}

class CartClearedState extends ConfirmationState {
  const CartClearedState();

  @override
  List<Object?> get props => [];
}
