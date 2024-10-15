import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../../../internal/helpers/api_requester.dart';
import '../../../../internal/helpers/catch_exception_helper.dart';
import '../../domain/repository/profile_repository.dart';
import '../model/profile_model.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  ApiRequester apiRequester = ApiRequester();

  @override
  Future<ProfileModel> getProfile() async {
    var box = Hive.box('idBox');
    int userId = await box.get('userId', defaultValue: 0);
    print(userId);

    try {
      Response response = await apiRequester.toGet('client/$userId');
      log('adsasd === ${response.data}');
      if (response.statusCode == 200) {
        return ProfileModel.fromJson(response.data);
      }

      throw response;
    } catch (e) {
      log('$e');
      throw CatchException.convertException(e);
    }
  }

  @override
  Future<ProfileModel> getProfileForSeller(String userId) async {
    try {
      Response response = await apiRequester.toGet('client/$userId');

      if (response.statusCode == 200) {
        return ProfileModel.fromJson(response.data);
      }

      throw response;
    } catch (e) {
      log('$e');
      throw CatchException.convertException(e);
    }
  }

  @override
  Future<ProfileModel> patchProfile(String username) async {
    var box = Hive.box('idBox');
    int userId = await box.get('userId', defaultValue: 0);

    try {
      Response response = await apiRequester.toPatch('client/$userId/', data: {
        'username': username,
      });

      if (response.statusCode == 200) {
        return ProfileModel.fromJson(response.data);
      }

      throw response;
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }

  @override
  Future deleteProfile() async {
    var box = Hive.box('idBox');
    int userId = await box.get('userId', defaultValue: 0);

    try {
      Response response = await apiRequester.toDelete(
        'client/$userId/',
      );

      log('response sc == ${response.statusCode}');

      if (response.statusCode == 204) {
        await Hive.box('tokenBox').clear();
        await Hive.box('idBox').clear();
        await Hive.box('isStaffBox').clear();
        await Hive.box('branchBox').clear();

        return true;
      }
    } catch (e) {
      log('e == $e');
      throw CatchException.convertException(e);
    }
  }
}
