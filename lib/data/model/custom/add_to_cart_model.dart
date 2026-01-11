// add to cart custom data model with uid
//
//

import 'package:flutter_bloc_template/data/model/response/product_details_model.dart';

class AddToCartModel {
  final int? uID;
  final int? quantity;
  final ProductDetailsModel? productDetailsModel;
  AddToCartModel({this.uID, this.quantity, this.productDetailsModel});
}
