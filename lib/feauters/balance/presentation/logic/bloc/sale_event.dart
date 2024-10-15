// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sale_bloc.dart';

abstract class SaleEvent {}

class GetSaleEvent extends SaleEvent {
  final bool isFirstCall;
  final int page;

  GetSaleEvent({
    this.isFirstCall = false,
    required this.page,
  });
}

class GetSaleInfoEvent extends SaleEvent {
  final String date;

  GetSaleInfoEvent({required this.date});
}
