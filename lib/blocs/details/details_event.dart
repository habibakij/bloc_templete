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
