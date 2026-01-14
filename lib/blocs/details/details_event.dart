part of 'details_bloc.dart';

abstract class DetailsEvent {}

class ProductDetailsInitEvent extends DetailsEvent {
  final int? productID;
  ProductDetailsInitEvent({this.productID});
}

class AddToCartEvent extends DetailsEvent {
  final List<ProductModel> likeProductList;
  final ProductDetailsModel productDetails;
  AddToCartEvent({required this.likeProductList, required this.productDetails});
}

class AddProductQuantityEvent extends DetailsEvent {
  final List<ProductModel> likeProductList;
  final ProductDetailsModel productDetails;
  final List<AddToCartModel> cartProductsList;
  AddProductQuantityEvent({required this.likeProductList, required this.productDetails, required this.cartProductsList});
}

class RemoveProductQuantityEvent extends DetailsEvent {
  final List<ProductModel> likeProductList;
  final ProductDetailsModel productDetails;
  final List<AddToCartModel> cartProductsList;
  RemoveProductQuantityEvent({required this.likeProductList, required this.productDetails, required this.cartProductsList});
}
