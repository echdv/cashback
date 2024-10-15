// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cashback/feauters/balance/data/models/sale_info_model.dart';
import 'package:cashback/feauters/balance/data/models/sale_model.dart';
import 'package:cashback/feauters/balance/domain/repository/sale_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SaleUseCase {
  final SaleRepository saleRepository;

  SaleUseCase({required this.saleRepository});

  Future<SaleModel> getSale(int page) async =>
      await saleRepository.getSale(page);

  Future<SaleInfoModel> getSaleInfo(String date) async =>
      await saleRepository.getSaleInfo(date);
}
