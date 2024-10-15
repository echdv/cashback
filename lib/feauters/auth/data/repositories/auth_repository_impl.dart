import 'dart:developer';

import 'package:cashback/feauters/auth/data/models/client_model.dart';
import 'package:cashback/feauters/auth/data/models/login_model.dart';
import 'package:cashback/feauters/seller_catalog/data/model/seller_model.dart';
import 'package:cashback/internal/helpers/api_requester.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../../../internal/helpers/catch_exception_helper.dart';
import '../../domain/repositories/auth_repository.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImlp implements AuthRepository {
  ApiRequester apiRequester = ApiRequester();

  @override
  Future<dynamic> getPhone(String phone) async {
    try {
      Response response = await apiRequester.toPost(
        'verification_phone/send_sms',
        data: {
          'phone_number': phone,
        },
      );

      log('phone123 == $phone');

      if (response.statusCode == 200) {
        return true;
      }

      throw response;
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }

  @override
  Future getMsgCode(String smsCode, String phone) async {
    try {
      Response response = await apiRequester.toPost(
        'verification_phone/verify_sms',
        data: {
          'phone_number': phone,
          'verification_code': smsCode,
        },
      );

      // log('getMsgCode response == ${response.data}');
      // log('getMsgCode statusCode == ${response.statusCode}');

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }

  @override
  Future<ClientModel> getRegistration(
      String phone, String name, String password) async {
    try {
      Response response = await apiRequester.toPost(
        'client/',
        data: {
          'username': name,
          'phone_number': phone,
          'password': password,
        },
      );

      // log('getReg response === ${response.data}');

      if (response.statusCode == 200) {
        log('getReg statusCode === ${response.statusCode}');
        ClientModel model = ClientModel.fromJson(response.data);

        var box = Hive.box('tokenBox');
        box.put('token', 'Token ${response.data['token']}');

        var idBox = Hive.box('idBox');
        idBox.put('userId', response.data['id']);

        log('token from cache === ${box.get('token')}');
        log('userId from cache === ${idBox.get('userId')}');

        return model;
      }

      throw response;
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }

  @override
  Future<LoginModel> getLogIn(String phone, String password) async {
    try {
      // print('посмотрите этот момент =)');
      // print('мок данные =>');

      // phone = '+996505451040';
      // password =
      //     '123'; // тестовые данные для проверки токена, убрать если хотите ввести свои данные

      Response response = await apiRequester.toPost(
        'auth/login',
        data: {
          'phone_number': phone,
          'password': password,
        },
      );

      // log('getLogIn response == ${response.data}');
      // log('getLogIn statusCode == ${response.statusCode}');

      if (response.statusCode == 200) {
        LoginModel model = LoginModel.fromJson(response.data);

        var box = Hive.box('tokenBox');
        box.put('token', 'Token ${response.data['token']}');

        var idBox = Hive.box('idBox');
        idBox.put('userId', response.data['id']);

        log('token from cache === ${box.get('token')}');
        log('userId from cache === ${idBox.get('userId')}');

        var isStaffBox = Hive.box('isStaffBox');
        isStaffBox.put('isStaff', response.data['is_staff']);
        log('isStaff === ${isStaffBox.get('isStaff')}');

        return model;
      }

      throw response;
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }

  @override
  Future resetPassoword(String phone, String password) async {
    try {
      Response response = await apiRequester.toPost(
        'client/reset_password',
        data: {
          'phone_number': phone,
          'password': password,
        },
      );

      // log('getMsgCode response == ${response.data}');
      // log('getMsgCode statusCode == ${response.statusCode}');

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }

  @override
  Future logout() async {
    try {
      Response response = await apiRequester.toGet('auth/logout');

      log('logout response == ${response.data}');
      log('logout statusCode == ${response.statusCode}');

      if (response.statusCode == 200) {
        log("token before clear ${Hive.box('tokenBox').values}");
        log("userId before clear ${Hive.box('idBox').values}");

        await Hive.box('tokenBox').clear();
        await Hive.box('idBox').clear();
        await Hive.box('isStaffBox').clear();
        await Hive.box('branchBox').clear();

        log("token after clear${Hive.box('tokenBox').values}");
        log("userId after clear${Hive.box('idBox').values}");
        log("isStaff ==== ${Hive.box('isStaffBox').values}");

        return true;
      }
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }

  @override
  Future getSeller(int id) async {
    var box = Hive.box('idBox');
    int id = await box.get('userId', defaultValue: 0);

    try {
      Response response = await apiRequester.toGet("seller/$id");
      if (response.statusCode == 200) {
        SellerModel model = SellerModel.fromJson(response.data);

        // log('logout response == ${response.data}');
        // log('logout statusCode == ${response.statusCode}');

        var branchBox = Hive.box('branchBox');
        branchBox.put('branch', response.data['branch']);

        log('branch === ${branchBox.get('branch')}');

        return model;
      }
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }
}
