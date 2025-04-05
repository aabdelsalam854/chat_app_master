class RegisterWithFireBase {
  final String? email;

  final String? firebaseUid;

  const RegisterWithFireBase({
    this.email,
    this.firebaseUid,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'firebaseUid': firebaseUid,
      };
}
