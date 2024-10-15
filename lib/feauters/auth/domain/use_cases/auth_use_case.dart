import 'package:cashback/feauters/auth/data/models/client_model.dart';
import 'package:cashback/feauters/auth/data/models/login_model.dart';
import 'package:cashback/feauters/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthUseCase {
  final AuthRepository authRepository;

  AuthUseCase({required this.authRepository});

  Future<dynamic> getPhone(String phone) async =>
      await authRepository.getPhone(phone);

  Future<dynamic> getMsgCode(String smsCode, String phone) async =>
      await authRepository.getMsgCode(smsCode, phone);

  Future<ClientModel> getRegistration(
    String phone,
    String name,
    String password,
  ) async =>
      await authRepository.getRegistration(
        phone,
        name,
        password,
      );

  Future<LoginModel> getLogIn(String phone, String password) async =>
      await authRepository.getLogIn(phone, password);

  Future<dynamic> resetPassoword(String phone, String password) async =>
      await authRepository.resetPassoword(phone, password);

  Future<dynamic> logout() async => await authRepository.logout();

  Future<dynamic> getSeller(int id) async => await authRepository.getSeller(id);
}
