part of 'catalog_bloc.dart';

abstract class CatalogState {}

class CatalogInitial extends CatalogState {}

class BranchLoadedState extends CatalogState {
  final List<BranchModel> branchModel;

  BranchLoadedState({required this.branchModel});
}

class CatalogLoadedState extends CatalogState {
  final CategoryModel categoryModel;

  CatalogLoadedState({required this.categoryModel});
}

class CatalogLoadingState extends CatalogState {}

class CatalogErroeState extends CatalogState {
  final CatchException error;

  CatalogErroeState({required this.error});
}



class ProductLoadedState extends CatalogState {
  final List<ProductModel> productModel;

  ProductLoadedState({required this.productModel});
}
