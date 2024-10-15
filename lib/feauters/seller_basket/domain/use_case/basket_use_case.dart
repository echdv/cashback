// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cashback/feauters/seller_basket/domain/repository/basket_repository.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/order_model.dart';

@injectable
class BasketUseCase {
  final BasketRepository basketRepository;

  BasketUseCase({required this.basketRepository});

  Future<OrderModel> postOrder(String id, String cashback) async =>
      await basketRepository.postOrder(id, cashback);
}
