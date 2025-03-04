import 'package:flutter_bloc_template/core/network/api_client.dart';
import 'package:flutter_bloc_template/data/model/details_screen/item_details_model.dart';

class DetailsScreenRepository {
  Future<ItemDetailsModel> fetchItemDetailsData({itemID}) async {
    final response = await ApiClient.get("todos/$itemID");
    return itemDetailsModelFromJson(response.toString());
  }
}
