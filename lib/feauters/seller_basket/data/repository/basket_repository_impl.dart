import 'dart:developer';

import 'package:cashback/feauters/seller_basket/data/models/order_model.dart';
import 'package:cashback/internal/helpers/api_requester.dart';
import 'package:cashback/internal/helpers/catch_exception_helper.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../../../internal/helpers/constants.dart';
import '../../domain/repository/basket_repository.dart';

@Injectable(as: BasketRepository)
class BasketRepositoryImpl implements BasketRepository {
  ApiRequester apiRequester = ApiRequester();

  @override
  Future<OrderModel> postOrder(String id, String cashback) async {
    var branchBox = Hive.box('branchBox');
    int branch = branchBox.get('branch', defaultValue: 0);
    List<Map> products = List.generate(Constants.totalBasket.length, (index) {
      return {
        'product': Constants.totalBasket[index].productID,
        'amount': Constants.totalBasket[index].amount,
      };
    });

    try {
      Response response = await apiRequester.toPost('sales/sale/', data: {
        'branch': branch,
        if (id != 'client') 'client': id,
        'products': products,
        'from_balance_amount': cashback,
      });

      log('response data === ${response.data}');

      if (response.statusCode == 201) {
        return OrderModel.fromJson(response.data);
      }

      throw response;
    } catch (e) {
      print('error ===== $e');
      throw CatchException.convertException(e);
    }
  }
}
