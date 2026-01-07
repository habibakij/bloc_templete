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
  final int cartCounter;
  const ProductDetailLoadedState(this.product, this.cartCounter);

  @override
  List<Object?> get props => [product];
}

class AddedToCartState1 extends DetailsState {
  final ProductDetailsModel product;
  final int cartCounter;
  const AddedToCartState1(this.product, this.cartCounter);
}

class ProductDetailsErrorState extends DetailsState {
  final String message;
  const ProductDetailsErrorState(this.message);
  @override
  List<Object?> get props => [message];
}
