import 'package:cashback/feauters/seller_catalog/data/model/seller_catalog_model.dart';
import 'package:cashback/feauters/seller_catalog/data/model/seller_product_model.dart';

abstract class SellerCatalogRepository {
  Future<SellerCategoryModel> getCategory();
  Future<List<SellerProductModel>> getProduct(int id);
}
