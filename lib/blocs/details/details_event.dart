part of 'details_bloc.dart';

abstract class DetailsEvent {}

class ProductDetailsInitEvent extends DetailsEvent {
  final int? productID;
  ProductDetailsInitEvent({this.productID});
}

class AddToCartEvent extends DetailsEvent {
  AddToCartEvent();
}
