
import 'package:equatable/equatable.dart';

class LoginResponseEntity  extends Equatable{
  
  final String token;

  const LoginResponseEntity({required this.token});

  @override

  List<Object?> get props => [token];
}