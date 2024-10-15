import 'package:cashback/feauters/profile/data/model/profile_model.dart';
import 'package:injectable/injectable.dart';

import '../repository/profile_repository.dart';

@injectable
class ProfileUseCase {
  final ProfileRepository profileRepository;

  ProfileUseCase({required this.profileRepository});

  Future<ProfileModel> getProfile() async =>
      await profileRepository.getProfile();

  Future<ProfileModel> getProfileForSeller(String userId) async =>
      await profileRepository.getProfileForSeller(userId);

  Future<ProfileModel> patchProfile(String username) async =>
      await profileRepository.patchProfile(username);

  Future<dynamic> deleteProfile() async =>
      await profileRepository.deleteProfile();
}
