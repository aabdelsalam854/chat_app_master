import 'package:chat_master/core/error/failures.dart';
import 'package:chat_master/core/model/user_model.dart';
import 'package:chat_master/features/profile/domain/repositories/profile_repo.dart';
import 'package:dartz/dartz.dart';

class ProfileUsecases {
  final ProfileRepository profileRepository;
  ProfileUsecases(this.profileRepository);

  Future<Either<Failure, UserModel>> updateProfile(UserModel userModel) async =>
      await profileRepository.updateProfile(userModel);

  Future<dynamic> updatePassword(String password) async {
    return await profileRepository.updatePassword(password);
  }

  Future<dynamic> getUserData(String uid) async {
    return await profileRepository.getUserData(uid);
  }
}
