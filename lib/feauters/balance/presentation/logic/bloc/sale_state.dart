// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sale_bloc.dart';

abstract class SaleState {}

class SaleInitial extends SaleState {}

class SaleLoadedState extends SaleState {
  final SaleModel saleModel;

  SaleLoadedState({required this.saleModel});
}

class SaleInfoLoadedState extends SaleState {
  final SaleInfoModel saleInfoModel;

  SaleInfoLoadedState({required this.saleInfoModel});
}

class SaleErrorSate extends SaleState {
  final CatchException error;

  SaleErrorSate({required this.error});
}

class SaleLoadingState extends SaleState {}
