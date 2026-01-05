import 'package:flutter_bloc_template/core/network/api_client.dart';
import 'package:flutter_bloc_template/data/model/response/product_details_model.dart';
import 'package:flutter_bloc_template/data/model/response/product_model.dart';

class ApiService {
  static const String baseUrl = 'https://fakestoreapi.com';
  static const Duration timeout = Duration(seconds: 10);

  Future<List<ProductModel>?> getProducts() async {
    try {
      final response = await ApiClient().get("/products");
      final List<ProductModel> data = (response.data as List).map((e) => ProductModel.fromJson(e)).toList();
      return data;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<ProductDetailsModel?> getProductById(int id) async {
    try {
      final response = await ApiClient().get("/products/$id");
      var data = response.data == null ? null : productDetailsModelFromJson(response.toString());
      return data;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
