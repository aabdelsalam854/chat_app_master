import 'package:chat_master/core/services/firebase_auth_services.dart';
import 'package:chat_master/features/auth/data/models/register_model.dart';
import 'package:chat_master/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  //*-----------------login------------------*//
  Future<UserModel> login(String email, String password);
  //*-----------------register------------------*//
  Future<UserModel> register(RegisterModel userRequest);
  // Future<dynamic> logout();

//*------------------loginWithGoogle------------------*//
  Future<dynamic> loginWithGoogle(String googleToken);
//*------------------loginWithFacebook------------------*//
  Future<dynamic> loginWithFacebook(String facebookToken);

  //*------------- resetPassword------------------*//
  Future<dynamic> resetPassword(String email);

  Future<dynamic> signout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuthServices firebaseAuthServices;

  AuthRemoteDataSourceImpl(this.firebaseAuthServices);
  @override
  Future<UserModel> login(String email, String password) async {
    final user = await firebaseAuthServices.loginWithEmailAndPassword(
      email: email,
      password: password,
    );
    return UserModel.fromFirebase(user);
  }

  @override
  Future<UserModel> loginWithFirebase(String firebaseToken) {
    // TODO: implement loginWithFirebase
    throw UnimplementedError();
  }

  @override
  Future<UserModel> register(RegisterModel userRequest)  async{
    final user = await firebaseAuthServices.createUserWithEmailAndPassword(
      email: userRequest.email,
      password: userRequest.password,
    );
    return UserModel.fromFirebase(user);
  }

  @override
  Future signout() {
    // TODO: implement signout
    throw UnimplementedError();
  }

  @override
  Future loginWithFacebook(String facebookToken) {
    // TODO: implement loginWithFacebook
    throw UnimplementedError();
  }

  @override
  Future loginWithGoogle(String googleToken) {
    // TODO: implement loginWithGoogle
    throw UnimplementedError();
  }
  
  @override
  Future resetPassword(String email) async {
    await firebaseAuthServices.resetPassword(email);
 
  }
}
