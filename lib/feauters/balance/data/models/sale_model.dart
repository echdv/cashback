// To parse this JSON data, do
//
//     final saleModel = saleModelFromJson(jsonString);

import 'dart:convert';

class SaleModel {
    int? count;
    String? next;
    dynamic previous;
    List<SaleResult>? results;

    SaleModel({
        this.count,
        this.next,
        this.previous,
        this.results,
    });

    factory SaleModel.fromRawJson(String str) => SaleModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SaleModel.fromJson(Map<String, dynamic> json) => SaleModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null ? [] : List<SaleResult>.from(json["results"]!.map((x) => SaleResult.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
    };
}

class SaleResult {
    DateTime? date;
    double? finalCost;
    double? finalCashback;

    SaleResult({
        this.date,
        this.finalCost,
        this.finalCashback,
    });

    factory SaleResult.fromRawJson(String str) => SaleResult.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SaleResult.fromJson(Map<String, dynamic> json) => SaleResult(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        finalCost: json["final_cost"]?.toDouble(),
        finalCashback: json["final_cashback"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "final_cost": finalCost,
        "final_cashback": finalCashback,
    };
}
