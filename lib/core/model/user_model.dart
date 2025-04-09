import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  final String? photoUrl;
  final DateTime? lastSeen;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.photoUrl,
    this.lastSeen,
  });

  // تحويل البيانات من JSON
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] ?? "",
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        phoneNumber: json['phoneNumber'] ?? '',
        photoUrl: json['photoUrl'],
        lastSeen: json['lastSeen'] != null
            ? (json['lastSeen'] as Timestamp).toDate()
            : null,
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
      'lastSeen': lastSeen?.toIso8601String(),
    };
  }

  Map<String, dynamic> toJsonWithNow() {
    return {
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'lastSeen': FieldValue.serverTimestamp(),
    };
  }

  @override
  List<Object?> get props => [id, name, email, phoneNumber, photoUrl, lastSeen];
}
