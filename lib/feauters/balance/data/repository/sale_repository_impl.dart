import 'dart:developer';

import 'package:cashback/feauters/balance/data/models/sale_info_model.dart';
import 'package:cashback/feauters/balance/data/models/sale_model.dart';
import 'package:cashback/internal/helpers/api_requester.dart';
import 'package:cashback/internal/helpers/catch_exception_helper.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repository/sale_repository.dart';

@Injectable(as: SaleRepository)
class SaleRepositoryImpl implements SaleRepository {
  ApiRequester apiRequester = ApiRequester();

  @override
  Future<SaleModel> getSale(int page) async {
    var box = Hive.box('idBox');

    int id = await box.get('userId', defaultValue: 0);
    try {
      Response response = await apiRequester.toGet(
        'sales/list_sale_dates?client=$id&page=$page',
      );
      if (response.statusCode == 200) {
        return SaleModel.fromJson(response.data);
      }

      throw response;
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }

  @override
  Future<SaleInfoModel> getSaleInfo(String date) async {
    var box = Hive.box('idBox');
    int id = await box.get('userId', defaultValue: 0);
    try {
      Response response = await apiRequester
          .toGet('sales/sale/?client=$id&date=${date.substring(0, 10)}');
          log('respones data === ${response.data}');

      if (response.statusCode == 200) {
        return SaleInfoModel.fromJson(response.data);
      }
      throw response;
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }
}
