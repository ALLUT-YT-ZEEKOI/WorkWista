// To parse this JSON data, do
//
//     final allCategoryListingModel = allCategoryListingModelFromJson(jsonString);

import 'dart:convert';

AllCategoryListingModel allCategoryListingModelFromJson(String str) => AllCategoryListingModel.fromJson(json.decode(str));



class AllCategoryListingModel {
    String? status;
    List<AllCategories>? data;

    AllCategoryListingModel({
        this.status,
        this.data,
    });

    factory AllCategoryListingModel.fromJson(Map<String, dynamic> json) => AllCategoryListingModel(
        status: json["status"],
        data: json["data"] == null ? [] : List<AllCategories>.from(json["data"]!.map((x) => AllCategories.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class AllCategories {
    String? id;
    String? title;

    AllCategories({
        this.id,
        this.title,
    });

    factory AllCategories.fromJson(Map<String, dynamic> json) => AllCategories(
        id: json["id"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
    };
}
