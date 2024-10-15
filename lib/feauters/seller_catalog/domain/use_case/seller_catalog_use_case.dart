import 'package:cashback/feauters/seller_catalog/domain/repository/seller_catalog_repository.dart';
import 'package:injectable/injectable.dart';

import '../../data/model/seller_catalog_model.dart';
import '../../data/model/seller_product_model.dart';

@injectable
class SellerCatalogUseCase {
  final SellerCatalogRepository catalogRepository;

  SellerCatalogUseCase({
    required this.catalogRepository,
  });

  Future<SellerCategoryModel> getCategory() async =>
      await catalogRepository.getCategory();

  Future<List<SellerProductModel>> getProduct(int id) async =>
      await catalogRepository.getProduct(id);
}
