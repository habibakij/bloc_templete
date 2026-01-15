part of 'details_bloc.dart';

sealed class DetailsEvent extends Equatable {
  const DetailsEvent();
  @override
  List<Object?> get props => [];
}

class ProductDetailsRegisterEvent extends DetailsEvent {
  const ProductDetailsRegisterEvent();
}

class ProductDetailsInitEvent extends DetailsEvent {
  final int? productID;
  const ProductDetailsInitEvent({this.productID});
}

class AddToCartEvent extends DetailsEvent {
  final List<ProductModel> likeProductList;
  final ProductDetailsModel productDetails;
  const AddToCartEvent({required this.likeProductList, required this.productDetails});
}

class AddProductQuantityEvent extends DetailsEvent {
  final List<ProductModel> likeProductList;
  final ProductDetailsModel productDetails;
  final List<AddToCartModel> cartProductsList;
  const AddProductQuantityEvent({required this.likeProductList, required this.productDetails, required this.cartProductsList});
}

class RemoveProductQuantityEvent extends DetailsEvent {
  final List<ProductModel> likeProductList;
  final ProductDetailsModel productDetails;
  final List<AddToCartModel> cartProductsList;
  const RemoveProductQuantityEvent({required this.likeProductList, required this.productDetails, required this.cartProductsList});
}
