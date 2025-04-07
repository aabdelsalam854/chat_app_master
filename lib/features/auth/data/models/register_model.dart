class RegisterModel {
  final String email;
  final String password;
  final String covariantPassword;
  final String name;
  final String phoneNumber;

  RegisterModel(
      {required this.email,
      required this.password,
      required this.covariantPassword,
      required this.name,
      required this.phoneNumber});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'covariantPassword': covariantPassword,
    };
  }
}
