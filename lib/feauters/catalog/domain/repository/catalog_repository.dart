import '../../data/model/branch_model.dart';
import '../../data/model/catalog_model.dart';
import '../../data/model/product_model.dart';

abstract class CatalogRepository {
  Future<List<BranchModel>> getBranch();
  Future<CategoryModel> getCategory(int id);
  Future<List<ProductModel>> getProduct(int id);
}
