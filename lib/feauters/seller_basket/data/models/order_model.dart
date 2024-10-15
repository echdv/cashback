import 'dart:convert';

class OrderModel {
    int? id;
    int? branch;
    int? client;
    List<Product>? products;
    DateTime? datetime;
    String? fromBalanceAmount;
    String? finalCost;
    String? finalCashback;

    OrderModel({
        this.id,
        this.branch,
        this.client,
        this.products,
        this.datetime,
        this.fromBalanceAmount,
        this.finalCost,
        this.finalCashback,
    });

    factory OrderModel.fromRawJson(String str) => OrderModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        branch: json["branch"],
        client: json["client"],
        products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
        datetime: json["datetime"] == null ? null : DateTime.parse(json["datetime"]),
        fromBalanceAmount: json["from_balance_amount"],
        finalCost: json["final_cost"],
        finalCashback: json["final_cashback"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "branch": branch,
        "client": client,
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
        "datetime": datetime?.toIso8601String(),
        "from_balance_amount": fromBalanceAmount,
        "final_cost": finalCost,
        "final_cashback": finalCashback,
    };
}

class Product {
    int? id;
    int? sale;
    int? product;
    int? amount;
    double? totalCost;
    double? totalCashback;

    Product({
        this.id,
        this.sale,
        this.product,
        this.amount,
        this.totalCost,
        this.totalCashback,
    });

    factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        sale: json["sale"],
        product: json["product"],
        amount: json["amount"],
        totalCost: json["total_cost"],
        totalCashback: json["total_cashback"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "sale": sale,
        "product": product,
        "amount": amount,
        "total_cost": totalCost,
        "total_cashback": totalCashback,
    };
}
