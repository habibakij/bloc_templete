part of 'confirmation_bloc.dart';

sealed class ConfirmationState extends Equatable {
  const ConfirmationState();

  @override
  List<Object?> get props => [];
}

final class ConfirmationInitialState extends ConfirmationState {
  const ConfirmationInitialState();
}

class CartClearingState extends ConfirmationState {
  const CartClearingState();
}

class CartClearedState extends ConfirmationState {
  const CartClearedState();
}
