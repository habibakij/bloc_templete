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
  final List<ProductModel> likeProductList;
  final ProductDetailsModel productDetails;
  final List<AddToCartModel> cartProductsList;
  final int productQuantity;
  const ProductDetailLoadedState(this.likeProductList, this.productDetails, this.cartProductsList, this.productQuantity);

  @override
  List<Object?> get props => [productDetails];
}

class ProductDetailsErrorState extends DetailsState {
  final String message;
  const ProductDetailsErrorState(this.message);
  @override
  List<Object?> get props => [message];
}
