class RegisterModel {
  final String email;
  final String password;
  final String covariantPassword;

  RegisterModel({
    required this.email,
    required this.password,
    required this.covariantPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'covariantPassword': covariantPassword,
    };
  }
}
