part of 'seller_kassa_bloc.dart';

abstract class SellerKassaEvent {}

class GetSellerKassaDateEvent extends SellerKassaEvent {
  final String? date;
  final int? page;
  final bool? isFirstCall;

  GetSellerKassaDateEvent({
    this.date,
    this.page = 1,
    this.isFirstCall = false,
  });
}

class GetSellerKassaInfoEvent extends SellerKassaEvent {
  final bool? isFirstCall;
  final String minDate;
  final int? page;

  GetSellerKassaInfoEvent({
    this.isFirstCall = false,
    this.page = 1,
    required this.minDate,
  });
}
