import 'package:chat_master/core/model/user_model.dart';
import 'package:chat_master/core/services/database_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ProfileRemoteDataSource {
  Future<dynamic> updateProfile(UserModel userModel);
  Future<dynamic> updatePassword(String password);
  Future<dynamic> getUserData(String uid);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final DatabaseServices database;

  ProfileRemoteDataSourceImpl(this.database);
  @override
  Future<void> updatePassword(String password) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }

    await user.updatePassword(password);
  }

  @override
  Future<dynamic> updateProfile(UserModel userModel) async {
    await database.updateData(
        path: 'users', docId: userModel.id, data: userModel.toJson());
    return userModel;
  }

  @override
  Future getUserData(String uid) async {
    var userData = await database.getData(path: 'users', docId: uid);
    return UserModel.fromJson(userData);
  }
}
