

import 'dart:convert';

class SaleInfoModel {
    int? count;
    dynamic next;
    dynamic previous;
    List<SaleInfoResult>? results;

    SaleInfoModel({
        this.count,
        this.next,
        this.previous,
        this.results,
    });

    factory SaleInfoModel.fromRawJson(String str) => SaleInfoModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SaleInfoModel.fromJson(Map<String, dynamic> json) => SaleInfoModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null ? [] : List<SaleInfoResult>.from(json["results"]!.map((x) => SaleInfoResult.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
    };
}

class SaleInfoResult {
    int? id;
    String? clientPhoneNumber;
    DateTime? datetime;
    String? finalCost;
    String? finalCashback;
    List<Product>? products;
    String? fromBalanceAmount;

    SaleInfoResult({
        this.id,
        this.clientPhoneNumber,
        this.datetime,
        this.finalCost,
        this.finalCashback,
        this.products,
        this.fromBalanceAmount,
    });

    factory SaleInfoResult.fromRawJson(String str) => SaleInfoResult.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SaleInfoResult.fromJson(Map<String, dynamic> json) => SaleInfoResult(
        id: json["id"],
        clientPhoneNumber: json["client_phone_number"],
        datetime: json["datetime"] == null ? null : DateTime.parse(json["datetime"]),
        finalCost: json["final_cost"],
        finalCashback: json["final_cashback"],
        products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
        fromBalanceAmount: json["from_balance_amount"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "client_phone_number": clientPhoneNumber,
        "datetime": datetime?.toIso8601String(),
        "final_cost": finalCost,
        "final_cashback": finalCashback,
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
        "from_balance_amount": fromBalanceAmount,
    };
}

class Product {
    String? product;
    int? amount;
    double? totalCost;
    double? totalCashback;

    Product({
        this.product,
        this.amount,
        this.totalCost,
        this.totalCashback,
    });

    factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        product: json["product"],
        amount: json["amount"],
        totalCost: json["total_cost"],
        totalCashback: json["total_cashback"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "product": product,
        "amount": amount,
        "total_cost": totalCost,
        "total_cashback": totalCashback,
    };
}
