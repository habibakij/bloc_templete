import 'package:flutter_bloc_template/core/network/api_service.dart';
import 'package:flutter_bloc_template/data/model/response/product_details_model.dart';
import 'package:flutter_bloc_template/data/model/response/product_model.dart';

class ProductRepository {
  final _apiService = ApiService();
  List<ProductDetailsModel> _cartProducts = [];

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

  void addToCart(ProductDetailsModel product) {
    /*if (!_cartProducts.any((p) => p.id == product.id)) {
      _cartProducts.add(product);
    }*/
    _cartProducts.add(product);
  }

  // Get all cart products
  List<ProductDetailsModel> getCartProducts() {
    return List.from(_cartProducts); // Return copy to prevent external modification
  }

  // Remove from cart
  void removeFromCart(int productId) {
    _cartProducts.removeWhere((p) => p.id == productId);
  }

  // Clear cart
  void clearCart() {
    _cartProducts.clear();
  }

  // Get cart count
  int getCartCount() {
    return _cartProducts.length;
  }
}
