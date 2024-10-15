import 'package:cashback/internal/helpers/api_requester.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../../../internal/helpers/catch_exception_helper.dart';
import '../../domain/repository/qr_code_repository.dart';
import '../model/model_test.dart';

@Injectable(as: QrCodeRepository)
class QrCodeRepositoryImpl implements QrCodeRepository {
  ApiRequester apiRequester = ApiRequester();

  @override
  Future<ClientModelTest> getQrCode() async {
    var box = Hive.box('idBox');
    int userId = await box.get('userId', defaultValue: 0);
    

    try {
      Response response = await apiRequester.toGet('client/$userId');

      if (response.statusCode == 200) {
        return ClientModelTest.fromJson(response.data);
      }

      throw response;
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }
}
