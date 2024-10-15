class BasketModel {
  int productID;
  int amount;
  String productName;
  double cashback;
  String price;

  BasketModel({
    required this.productID,
    required this.amount,
    required this.productName,
    required this.cashback,
    required this.price,
  });

  @override
  String toString() {
    return 'productID: $productID, amount: $amount, productName: $productName, cashback: $cashback, price: $price,';
  }
}

/*
class BasketModelUI {
  String productName;
  double cashback;
  String price;

  BasketModelUI({
    required this.productName,
    required this.cashback,
    required this.price,
  });

  @override
  String toString() {
    return 'productName: $productName, cashback: $cashback, price: $price';
  }
}

class BasketModel {
  int productID;
  int amount;

  BasketModel({
    required this.productID,
    required this.amount,
  });

  @override
  String toString() {
    return 'productID: $productID, amount: $amount';
  }
}

*/
