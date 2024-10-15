import 'dart:developer';

import 'package:cashback/feauters/seller_kassa/data/model/seller_kassa_model.dart';
import 'package:cashback/feauters/seller_kassa/domain/repository/seller_kassa_repository.dart';
import 'package:cashback/internal/helpers/api_requester.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../../../internal/helpers/catch_exception_helper.dart';
import '../model/seller_kassa_date_model.dart';

@Singleton(as: SellerKassaRepository)
class SellerKassaRepositoryImpl implements SellerKassaRepository {
  ApiRequester apiRequester = ApiRequester();

  @override
  Future<SellerKassaDateModel> getSellerKassaDate(String date, int page) async {
    var branchBox = Hive.box('branchBox');
    int branch = branchBox.get('branch', defaultValue: 0);
    if (date.isNotEmpty == false) {
      date = '';
    }
    try {
      if (date.isNotEmpty) {
        print('date == $date');

        Response response = await apiRequester.toGet(
          "/sales/list_sale_dates?branch=$branch&date=${date.substring(0, 10)}",
        );

        if (response.statusCode == 200) {
          return SellerKassaDateModel.fromJson(response.data);
        }
        throw response;
      } else if (date.isEmpty) {
        Response response = await apiRequester.toGet(
          "/sales/list_sale_dates?branch=$branch&page=$page",
        );
        log('${response.realUri}');

        if (response.statusCode == 200) {
          return SellerKassaDateModel.fromJson(response.data);
        }
        throw response;
      } else {
        throw '';
      }
    } catch (e) {
      log('e = $e');
      throw CatchException.convertException(e);
    }
  }

  @override
  Future<SellerKassaModel> getSellerKassaInfo(
    String minDate,
    int page,
  ) async {
    try {
      Response response =
          await apiRequester.toGet("sales/sale/?date=$minDate&page=$page");

      log('getKassa11 === ${page}');
      log('getBranchStatusCode11 === ${response.realUri}');

      if (response.statusCode == 200) {
        return SellerKassaModel.fromJson(response.data);
      }

      throw response;
    } catch (e) {
      log('e = $e');
      throw CatchException.convertException(e);
    }
  }
}
