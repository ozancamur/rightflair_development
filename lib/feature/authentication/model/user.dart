import 'package:rightflair/core/base/base_modeld.dart';

class UserModel extends BaseModel<UserModel> {
  String? uid;
  String? token;
  String? email;
  String? fullName;
  String? username;

  UserModel({this.uid, this.token, this.email, this.fullName, this.username});

  @override
  UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String?,
      token: json['token'] as String?,
      email: json['email'] as String?,
      fullName: json['fullName'] as String?,
      username: json['username'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'token': token,
      'email': email,
      'fullName': fullName,
      'username': username,
    };
  }

  @override
  UserModel copyWith({
    String? uid,
    String? token,
    String? email,
    String? fullName,
    String? username,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      token: token ?? this.token,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      username: username ?? this.username,
    );
  }
}
