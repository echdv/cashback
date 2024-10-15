import 'package:cashback/feauters/profile/data/model/profile_model.dart';

abstract class ProfileRepository {
  Future<ProfileModel> getProfile();
  Future<ProfileModel> getProfileForSeller(String userId);
  Future<ProfileModel> patchProfile(String username);
  Future<dynamic> deleteProfile();
}
