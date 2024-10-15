import 'dart:convert';

class ProductModel {
    int? id;
    List<int>? category;
    String? typeProduct;
    String? title;
    String? image;
    String? description;
    String? price;
    int? percentCashback;
    double? cashback;

    ProductModel({
        this.id,
        this.category,
        this.typeProduct,
        this.title,
        this.image,
        this.description,
        this.price,
        this.percentCashback,
        this.cashback,
    });

    factory ProductModel.fromRawJson(String str) => ProductModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        category: json["category"] == null ? [] : List<int>.from(json["category"]!.map((x) => x)),
        typeProduct: json["type_product"],
        title: json["title"],
        image: json["image"],
        description: json["description"],
        price: json["price"],
        percentCashback: json["percent_cashback"],
        cashback: json["cashback"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "category": category == null ? [] : List<dynamic>.from(category!.map((x) => x)),
        "type_product": typeProduct,
        "title": title,
        "image": image,
        "description": description,
        "price": price,
        "percent_cashback": percentCashback,
        "cashback": cashback,
    };
}
