import 'package:chat_master/core/model/user_model.dart';
import 'package:chat_master/core/services/database_services.dart';

abstract class ProfileRemoteDataSource {
  Future<dynamic> updateProfile(UserModel userModel);
  Future<dynamic> updatePassword(String password);
  Future<dynamic> getUserData(String uid);
  
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final DatabaseServices database;

  ProfileRemoteDataSourceImpl(this.database);
  @override
  Future<void> updatePassword(String password) async{
    // TODO: implement updatePassword
    throw UnimplementedError();
  }

  @override
  Future<dynamic> updateProfile(UserModel userModel) async {
    await database.updateData(path: 'users', docId: userModel.id, data: userModel.toJson());
 
  }
  
  @override
  Future getUserData(String uid) async {
    var userData = await database.getData(path: 'users', docId: uid);
    return UserModel.fromJson(userData);
  }
}
