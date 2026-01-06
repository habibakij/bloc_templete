part of 'details_bloc.dart';

abstract class DetailsState extends Equatable {
  const DetailsState();

  @override
  List<Object?> get props => [];
}

class ProductDetailsInit extends DetailsState {}

class ProductDetailsLoadingState extends DetailsState {
  const ProductDetailsLoadingState();
}

class ProductDetailLoadedState extends DetailsState {
  final ProductDetailsModel product;
  const ProductDetailLoadedState(this.product);

  @override
  List<Object?> get props => [product];
}

class CartCounterState extends DetailsState {
  const CartCounterState();
}

class ProductDetailsErrorState extends DetailsState {
  final String message;
  const ProductDetailsErrorState(this.message);
  @override
  List<Object?> get props => [message];
}
