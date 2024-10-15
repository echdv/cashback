import 'package:cashback/feauters/seller_kassa/data/model/seller_kassa_model.dart';

import '../../data/model/seller_kassa_date_model.dart';

abstract class SellerKassaRepository {
  Future<SellerKassaDateModel> getSellerKassaDate(String date, int page);
  Future<SellerKassaModel> getSellerKassaInfo(String minDate, int page);
}
