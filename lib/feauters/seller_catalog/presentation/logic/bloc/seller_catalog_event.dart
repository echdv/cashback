// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'seller_catalog_bloc.dart';

abstract class SellerCatalogEvent {}

class SellerGetCategoryEvent extends SellerCatalogEvent {}

class GetSellerProductEvent extends SellerCatalogEvent {
  int id;

  GetSellerProductEvent({required this.id});
}
