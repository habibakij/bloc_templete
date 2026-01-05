import 'package:flutter_bloc_template/core/network/api_service.dart';
import 'package:flutter_bloc_template/data/model/response/product_details_model.dart';
import 'package:flutter_bloc_template/data/model/response/product_model.dart';

class ProductRepository {
  final _apiService = ApiService();

  Future<List<ProductModel>?> getProducts() async {
    return await _apiService.getProducts();
  }

  Future<ProductDetailsModel?> getProductById(int id) async {
    return await _apiService.getProductById(id);
  }
}
