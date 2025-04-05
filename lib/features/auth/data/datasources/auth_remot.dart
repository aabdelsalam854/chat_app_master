import 'package:chat_master/features/auth/data/models/login_response.dart';
import 'package:chat_master/features/auth/data/models/register_model.dart';
import 'package:chat_master/features/auth/data/models/register_with_fire_base.dart';


abstract class AuthRemoteDataSource {
  //*-----------------login------------------*//
  Future<dynamic> login(String email, String password);
  //*-----------------register------------------*//
  Future<dynamic> register(RegisterModel userRequest);
  // Future<dynamic> logout();


//*------------------loginWithGoogle------------------*//
  Future<dynamic> loginWithGoogle(String googleToken);
//*------------------loginWithFacebook------------------*//
  Future<dynamic> loginWithFacebook(String facebookToken);

  Future<dynamic> signout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  
  @override
  Future<LoginResponse> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<LoginResponse> loginWithFirebase(String firebaseToken) {
    // TODO: implement loginWithFirebase
    throw UnimplementedError();
  }

  @override
  Future register(RegisterModel userRequest) {
    // TODO: implement register
    throw UnimplementedError();
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
 



}
