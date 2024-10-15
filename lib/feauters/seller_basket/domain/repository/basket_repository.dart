import '../../data/models/order_model.dart';

abstract class BasketRepository {
  Future<OrderModel> postOrder(String id, String cashback);
}
