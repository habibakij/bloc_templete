part of 'order_bloc.dart';

sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object?> get props => [];
}

final class OrderInitialState extends OrderState {
  const OrderInitialState();
}

final class OrderLoadingState extends OrderState {
  const OrderLoadingState();
}

final class OrderEmptyState extends OrderState {
  const OrderEmptyState();
}

final class OrderLoadedState extends OrderState {
  final List<AddToCartModel> orderList;
  const OrderLoadedState({required this.orderList});
}
