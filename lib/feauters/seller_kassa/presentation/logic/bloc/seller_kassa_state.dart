// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'seller_kassa_bloc.dart';

abstract class SellerKassaState extends Equatable {
  @override
  List<Object> get props => [];
}

class SellerKassaInitial extends SellerKassaState {}

class SellerKassaLoadingState extends SellerKassaState {}

class SellerKassaAllLoadingState extends SellerKassaState {}

class SellerKassaInfoLoadedState extends SellerKassaState {
  final SellerKassaModel sellerKassaModel;

  SellerKassaInfoLoadedState({required this.sellerKassaModel});

  @override
  List<Object> get props => [sellerKassaModel];
}

class SellerKassaDateLoadedState extends SellerKassaState {
  final SellerKassaDateModel sellerKassaDateModel;

  SellerKassaDateLoadedState({required this.sellerKassaDateModel});

  @override
  List<Object> get props => [sellerKassaDateModel];
}

class SellerKassaErrorState extends SellerKassaState {
  final CatchException error;

  SellerKassaErrorState({required this.error});
}
