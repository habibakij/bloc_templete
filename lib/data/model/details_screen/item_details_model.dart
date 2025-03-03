// To parse this JSON data, do
//
//     final itemDetailsModel = itemDetailsModelFromJson(jsonString);

import 'dart:convert';

ItemDetailsModel itemDetailsModelFromJson(String str) =>
    ItemDetailsModel.fromJson(json.decode(str));

String itemDetailsModelToJson(ItemDetailsModel data) =>
    json.encode(data.toJson());

class ItemDetailsModel {
  final int? userId;
  final int? id;
  final String? title;
  final bool? completed;

  ItemDetailsModel({
    this.userId,
    this.id,
    this.title,
    this.completed,
  });

  factory ItemDetailsModel.fromJson(Map<String, dynamic> json) =>
      ItemDetailsModel(
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
