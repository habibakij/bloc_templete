import 'package:flutter_bloc_template/core/network/api_service.dart';
import 'package:flutter_bloc_template/data/model/custom/add_to_cart_model.dart';
import 'package:flutter_bloc_template/data/model/response/product_details_model.dart';
import 'package:flutter_bloc_template/data/model/response/product_model.dart';

class ProductRepository {
  final _apiService = ApiService();
  final List<AddToCartModel> _cartProducts = [];
  int quantity = 0;

  Future<List<ProductModel>?> getProducts() async {
    return await _apiService.getProducts();
  }

  Future<ProductDetailsModel?> getProductById(int id) async {
    try {
      return await _apiService.getProductById(id);
    } catch (e) {
      return null;
    }
  }

  void addToCart(AddToCartModel product) {
    if (!_cartProducts.any((p) => p.uID == product.uID)) {
      _cartProducts.add(product);
    }
  }

  List<AddToCartModel> getCartProducts() {
    return List.from(_cartProducts); // Return copy to prevent external modification
  }

  void removeFromCart(int productId) {
    _cartProducts.removeWhere((p) => p.uID == productId);
  }

  void addProductQuantity() {
    quantity++;
  }

  void removeProductQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }

  int get getQuantity => quantity;
}
