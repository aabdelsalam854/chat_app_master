import 'package:chat_master/core/error/exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthServices {
  // FirebaseAuthServices._();

/*************  ✨ Windsurf Command ⭐  *************/
  /// Maps a [FirebaseAuthException] to a user-friendly string.
  ///
  /// This takes the [FirebaseAuthException] and returns a string that is
  /// suitable for showing to the user. This is used to handle the different
  /// types of exceptions that can occur when calling
  /// [FirebaseAuth.instance.createUserWithEmailAndPassword].
  ///
  /// The strings returned are:
  ///
  /// * 'No user found for that email.'
  /// * 'Wrong password provided for that user.'
  /// * 'The account already exists for that email.'
  /// * 'Operation not allowed.'
  /// * 'An undefined Error happened.'
  ///
  /// The string returned is based on the [code] of the exception. If the
  /// exception is not one of the above, then the default 'An undefined Error
  /// *****  7e4a8533-b777-4a13-92b7-8ac4369a6766  ******
  String _mapFirebaseAuthExceptionToString(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided for that user.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'operation-not-allowed':
        return 'Operation not allowed.';
      default:
        return 'An undefined Error happened.';
    }
  }

  // Future<User> updateUserdata() async {
  //   try {
  //     final user = FirebaseAuth.instance.currentUser;
  //     // await user!.verifyBeforeUpdateEmail();
  //     await user!.updatePassword( );
  //     return user;
  //   } on FirebaseAuthException catch (e) {
  //     throw CustomException(message: _mapFirebaseAuthExceptionToString(e));
  //   }
  // }

  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: _mapFirebaseAuthExceptionToString(e));
    }
  }

  Future<User> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: _mapFirebaseAuthExceptionToString(e));
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: _mapFirebaseAuthExceptionToString(e));
    }
  }

//*----------- Google Login -----------------*/

  Future<User> loginWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return (await FirebaseAuth.instance.signInWithCredential(credential)).user!;
  }

//*----------- Facebook Login -----------------*/
  Future<User> loginWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

    return (await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential))
        .user!;
  }

//*------------- Twitter Login -----------------*/
  Future signInWithTwitter() async {
    // final twitterLogin
    // = TwitterLogin(
    //     apiKey: '<your consumer key>',
    //     apiSecretKey: ' <your consumer secret>',
    //     redirectURI: '<your_scheme>://');

    // final authResult = await twitterLogin.login();

    // final twitterAuthCredential = TwitterAuthProvider.credential(
    //   accessToken: authResult.authToken!,
    //   secret: authResult.authTokenSecret!,
    // );

    // return (await FirebaseAuth.instance
    //         .signInWithCredential(twitterAuthCredential))
    //     .user!;
  }

  Future deleteUser() async {
    await FirebaseAuth.instance.currentUser!.delete();
  }

  Future<void> logout() async {
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
  }
}
