import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_template/data/repositories/product_repository.dart';

part 'confirmation_event.dart';
part 'confirmation_state.dart';

class ConfirmationBloc extends Bloc<ConfirmationEvent, ConfirmationState> {
  ProductRepository repository;
  ConfirmationBloc(this.repository) : super(ConfirmationInitialState()) {
    on<CartClearEvent>(onCartClear);
    on<AddToOrderEvent>(onAddToOrder);
  }

  Future<void> onCartClear(CartClearEvent event, Emitter<ConfirmationState> emit) async {
    emit(CartClearingState());
    repository.cartClear();
    emit(CartClearedState());
  }

  FutureOr<void> onAddToOrder(AddToOrderEvent event, Emitter<ConfirmationState> emit) {
    emit(CartClearingState());
    repository.addToOrder();
    emit(AddToOrderState());
  }
}
