import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_template/data/model/custom/add_to_cart_model.dart';
import 'package:flutter_bloc_template/data/repositories/product_repository.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  ProductRepository repository;
  OrderBloc(this.repository) : super(OrderInitialState()) {
    on<OrderLoadingEvent>(onLoadingOrderData);
  }

  /// fetching order list
  FutureOr<void> onLoadingOrderData(OrderLoadingEvent event, Emitter<OrderState> emit) {
    emit(OrderLoadingState());
    final orderList = repository.getCartProducts();
    emit(OrderLoadedState(orderList: orderList));
  }

  /// cart single item price calculation
  double cartItemPriceCalculation(double price, int quantity) {
    return price * quantity;
  }
}
