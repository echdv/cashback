import 'dart:convert';

class SellerKassaModel {
  int? count;
  String? next;
  dynamic previous;
  List<SaleResultSeller>? results;

  SellerKassaModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory SellerKassaModel.fromRawJson(String str) =>
      SellerKassaModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SellerKassaModel.fromJson(Map<String, dynamic> json) =>
      SellerKassaModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<SaleResultSeller>.from(
                json["results"]!.map((x) => SaleResultSeller.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class SaleResultSeller {
  int? id;
  String? clientPhoneNumber;
  DateTime? datetime;
  String? finalCost;
  String? finalCashback;
  List<ProductElement> products;
  String? fromBalanceAmount;

  SaleResultSeller({
    this.id,
    this.clientPhoneNumber,
    this.datetime,
    this.finalCost,
    this.finalCashback,
    required this.products,
    this.fromBalanceAmount,
  });

  factory SaleResultSeller.fromRawJson(String str) => SaleResultSeller.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SaleResultSeller.fromJson(Map<String, dynamic> json) => SaleResultSeller(
        id: json["id"],
        clientPhoneNumber: json["client_phone_number"],
        datetime:
            json["datetime"] == null ? null : DateTime.parse(json["datetime"]),
        finalCost: json["final_cost"],
        finalCashback: json["final_cashback"],
        products: json["products"] == null
            ? []
            : List<ProductElement>.from(
                json["products"]!.map((x) => ProductElement.fromJson(x))),
        fromBalanceAmount: json["from_balance_amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "client_phone_number": clientPhoneNumber,
        "datetime": datetime?.toIso8601String(),
        "final_cost": finalCost,
        "final_cashback": finalCashback,
        // ignore: unnecessary_null_comparison
        "products": products == null
            ? []
            : List<dynamic>.from(products.map((x) => x.toJson())),
        "from_balance_amount": fromBalanceAmount,
      };
}

class ProductElement {
  String? product;
  int? amount;
  double? totalCost;
  double? totalCashback;

  ProductElement({
    this.product,
    this.amount,
    this.totalCost,
    this.totalCashback,
  });

  factory ProductElement.fromRawJson(String str) =>
      ProductElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
        product: json["product"],
        amount: json["amount"],
        totalCost: json["total_cost"].toDouble(),
        totalCashback: json["total_cashback"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "product": product,
        "amount": amount,
        "total_cost": totalCost,
        "total_cashback": totalCashback,
      };
}