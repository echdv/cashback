

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../../../internal/helpers/api_requester.dart';
import '../../../../internal/helpers/catch_exception_helper.dart';
import '../../domain/repository/seller_catalog_repository.dart';
import '../model/seller_catalog_model.dart';
import '../model/seller_product_model.dart';

@Injectable(as: SellerCatalogRepository)
class SellerCatalogRepositoryImpl implements SellerCatalogRepository {
  ApiRequester apiRequester = ApiRequester();

  @override
  Future<SellerCategoryModel> getCategory() async {
    var branchBox = Hive.box('branchBox');
    int branch = branchBox.get('branch', defaultValue: 0);
    try {
      Response response = await apiRequester.toGet(
        'branch/$branch/',
      );

      if (response.statusCode == 200) {
        return SellerCategoryModel.fromJson(response.data);
      }

      throw response;
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }

  @override
  Future<List<SellerProductModel>> getProduct(int id) async {
    try {
      Response response =
          await apiRequester.toGet('products/product/?category__id=$id');

      if (response.statusCode == 200) {
        return response.data
            .map<SellerProductModel>(
                (element) => SellerProductModel.fromJson(element))
            .toList();
      }
      throw response;
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }
}
