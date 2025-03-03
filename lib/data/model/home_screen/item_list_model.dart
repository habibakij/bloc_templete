// To parse this JSON data, do
//
//     final itemModel = itemModelFromJson(jsonString);

import 'dart:convert';

List<ItemListModel> itemModelFromJson(String str) => List<ItemListModel>.from(
    json.decode(str).map((x) => ItemListModel.fromJson(x)));

String itemModelToJson(List<ItemListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ItemListModel {
  final int? userId;
  final int? id;
  final String? title;
  final bool? completed;

  ItemListModel({
    this.userId,
    this.id,
    this.title,
    this.completed,
  });

  factory ItemListModel.fromJson(Map<String, dynamic> json) => ItemListModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "completed": completed,
      };
}
