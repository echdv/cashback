import 'dart:developer';

import 'package:cashback/feauters/catalog/data/model/branch_model.dart';
import 'package:cashback/feauters/catalog/data/model/catalog_model.dart';
import 'package:cashback/feauters/catalog/data/model/product_model.dart';
import 'package:cashback/internal/helpers/api_requester.dart';
import 'package:cashback/internal/helpers/catch_exception_helper.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repository/catalog_repository.dart';

@Injectable(as: CatalogRepository)
class CatalogRepositoryImpl implements CatalogRepository {
  ApiRequester apiRequester = ApiRequester();

  @override
  Future<List<BranchModel>> getBranch() async {
    try {
      Response response = await apiRequester.toGet('branch/');
      // log('getBranch === ${response.data}');
      // log('getBranchStatusCode === ${response.statusCode}');

      if (response.statusCode == 200) {
        return response.data
            .map<BranchModel>((element) => BranchModel.fromJson(element))
            .toList();
      }

      throw response;
    } catch (e) {
      log('ee == $e');
      throw CatchException.convertException(e);
    }
  }

  @override
  Future<CategoryModel> getCategory(int id) async {
    try {
      Response response = await apiRequester.toGet(
        'branch/$id',
      );

      if (response.statusCode == 200) {
        return CategoryModel.fromJson(response.data);
      }
      throw response;
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }

  @override
  Future<List<ProductModel>> getProduct(int id) async {
    try {
      Response response =
          await apiRequester.toGet('products/product/?category__id=$id');

      if (response.statusCode == 200) {
        return response.data
            .map<ProductModel>((element) => ProductModel.fromJson(element))
            .toList();
      }
      throw response;
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }
}
