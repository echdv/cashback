// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cashback/feauters/catalog/domain/repository/catalog_repository.dart';
import 'package:injectable/injectable.dart';

import '../../data/model/branch_model.dart';
import '../../data/model/catalog_model.dart';
import '../../data/model/product_model.dart';

@injectable
class CatalogUseCase {
  final CatalogRepository catalogRepository;

  CatalogUseCase({required this.catalogRepository,});

  Future<List<BranchModel>> getBranch() async =>
      await catalogRepository.getBranch();

  Future<CategoryModel> getCategory(int id) async =>
      await catalogRepository.getCategory(id);

  Future<List<ProductModel>> getProduct(int id) async =>
      await catalogRepository.getProduct(id);
}
