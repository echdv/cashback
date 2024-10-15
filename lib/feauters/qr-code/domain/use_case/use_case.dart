import 'package:injectable/injectable.dart';

import '../../data/model/model_test.dart';
import '../repository/qr_code_repository.dart';

@injectable
class QrCodeUseCase {
  final QrCodeRepository qrRepository;

  QrCodeUseCase({required this.qrRepository});

  Future<ClientModelTest> getQrCode() async => await qrRepository.getQrCode();
}
