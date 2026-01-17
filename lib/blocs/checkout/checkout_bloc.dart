import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_template/data/model/custom/add_to_cart_model.dart';
import 'package:flutter_bloc_template/data/repositories/product_repository.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  ProductRepository repository;

  CheckoutBloc(this.repository) : super(CheckoutInitial()) {
    on<CheckoutLoadingEvent>(onCartDataLoading);
  }

  FutureOr<void> onCartDataLoading(CheckoutLoadingEvent event, Emitter<CheckoutState> emit) {
    emit(CheckoutLoadingState());
    try {
      final cartProducts = repository.getCartProducts();
      emit(CheckoutLoadedState(cartProducts));
    } catch (e) {
      emit(CheckoutErrorState(e.toString()));
    }
  }
}
