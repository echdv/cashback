// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'catalog_bloc.dart';

abstract class CatalogEvent {}

class GetBranchEvent extends CatalogEvent {}

class GetCategoryEvent extends CatalogEvent {
  final int id;

  GetCategoryEvent({required this.id});
}

class GetProductEvent extends CatalogEvent {
  int id;

  GetProductEvent({required this.id});
}
