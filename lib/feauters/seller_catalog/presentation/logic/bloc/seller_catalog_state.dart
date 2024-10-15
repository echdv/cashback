part of 'seller_catalog_bloc.dart';

abstract class SellerCatalogState {}

class SellerCatalogInitial extends SellerCatalogState {}

class SellerCatalogLoadedState extends SellerCatalogState {
  final SellerCategoryModel categoryModel;

  SellerCatalogLoadedState({required this.categoryModel});
}

class SellerCatalogLoadingState extends SellerCatalogState {}

class SellerProductLoadingState extends SellerCatalogState {}

class SellerCatalogErrorState extends SellerCatalogState {
  final CatchException error;

  SellerCatalogErrorState({required this.error});
}

class SellerProductLoadedState extends SellerCatalogState {
  final List<SellerCatalogState> sellerProductModel;

  SellerProductLoadedState({required this.sellerProductModel});
}


class ProductSellerLoadedState extends SellerCatalogState {
  final List<SellerProductModel> productModel;

  ProductSellerLoadedState({required this.productModel});
}
