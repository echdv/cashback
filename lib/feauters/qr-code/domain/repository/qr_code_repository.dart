import '../../data/model/model_test.dart';

abstract class QrCodeRepository {
  Future<ClientModelTest> getQrCode();
}
