// To parse this JSON data, do
//
//     final sellerKassaDateModel = sellerKassaDateModelFromJson(jsonString);

import 'dart:convert';

class SellerKassaDateModel {
  int? count;
  String? next;
  dynamic previous;
  List<DateResult>? results;

  SellerKassaDateModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory SellerKassaDateModel.fromRawJson(String str) =>
      SellerKassaDateModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SellerKassaDateModel.fromJson(Map<String, dynamic> json) =>
      SellerKassaDateModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<DateResult>.from(
                json["results"]!.map((x) => DateResult.fromJson(x))),
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

class DateResult {
  DateTime? date;
  double? finalCost;
  double? finalCashback;

  DateResult({
    this.date,
    this.finalCost,
    this.finalCashback,
  });

  factory DateResult.fromRawJson(String str) =>
      DateResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DateResult.fromJson(Map<String, dynamic> json) => DateResult(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        finalCost: json["final_cost"]?.toDouble(),
        finalCashback: json["final_cashback"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "final_cost": finalCost,
        "final_cashback": finalCashback,
      };
}
