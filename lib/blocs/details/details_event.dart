part of 'details_bloc.dart';

abstract class DetailsEvent {}

class ProductDetailsInitEvent extends DetailsEvent {
  final int? productID;
  final bool isAddToCart;
  ProductDetailsInitEvent({this.productID, this.isAddToCart = false});
}

class AddToCartEvent extends DetailsEvent {
  final ProductDetailsModel product;
  AddToCartEvent({required this.product});
}

class AddProductQuantityEvent extends DetailsEvent {
  final ProductDetailsModel product;
  final List<AddToCartModel> cartProductsList;
  AddProductQuantityEvent({required this.product, required this.cartProductsList});
}

class RemoveProductQuantityEvent extends DetailsEvent {
  final ProductDetailsModel product;
  final List<AddToCartModel> cartProductsList;
  RemoveProductQuantityEvent({required this.product, required this.cartProductsList});
}
