import 'package:cashback/feauters/balance/data/models/sale_info_model.dart';

import '../../data/models/sale_model.dart';

abstract class SaleRepository {
  Future<SaleModel> getSale(int page);
  Future<SaleInfoModel> getSaleInfo(String date);
}
