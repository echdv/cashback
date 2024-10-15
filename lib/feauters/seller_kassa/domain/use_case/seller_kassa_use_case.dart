import 'package:cashback/feauters/seller_kassa/data/model/seller_kassa_date_model.dart';
import 'package:cashback/feauters/seller_kassa/data/model/seller_kassa_model.dart';
import 'package:cashback/feauters/seller_kassa/domain/repository/seller_kassa_repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class SellerUseCase {
  final SellerKassaRepository sellerKassaRepository;

  SellerUseCase({required this.sellerKassaRepository});

  Future<SellerKassaModel> getSellerKassaInfo(String minDate, int page) async =>
      await sellerKassaRepository.getSellerKassaInfo(minDate, page);

  Future<SellerKassaDateModel> getSellerKassaDate(
          String date, int page) async =>
      await sellerKassaRepository.getSellerKassaDate(date, page);
}
