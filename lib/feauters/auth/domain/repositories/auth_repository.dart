import 'package:cashback/feauters/auth/data/models/client_model.dart';
import 'package:cashback/feauters/auth/data/models/login_model.dart';

abstract class AuthRepository {
  Future<dynamic> getPhone(String phone);
  Future<dynamic> getMsgCode(String smsCode, String phone);
  Future<ClientModel> getRegistration(
    String phone,
    String name,
    String password,
  );
  Future<LoginModel> getLogIn(String phone, String password);
  Future<dynamic> resetPassoword(String phone, String password);

  Future<dynamic> logout();

  Future<dynamic> getSeller(int id);
}
