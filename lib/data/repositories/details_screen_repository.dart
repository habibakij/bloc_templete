import 'package:flutter_bloc_template/core/network/api_client.dart';
import 'package:flutter_bloc_template/data/model/home_screen/item_list_model.dart';

class DetailsScreenRepository {
  Future<List<ItemListModel>> fetchItems() async {
    final response = await ApiClient.get("todos/");
    final List data = response.data;
    return data.map((e) => ItemListModel.fromJson(e)).toList();
  }
}
