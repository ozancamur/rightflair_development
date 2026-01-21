import '../../../core/base/model/base.dart';

class CheckUsernameModel extends BaseModel<CheckUsernameModel> {
  String? username;
  bool? isAvailable;
  String? reason;

  CheckUsernameModel({this.username, this.isAvailable, this.reason});

  @override
  CheckUsernameModel copyWith({
    String? username,
    bool? isAvailable,
    String? reason,
  }) {
    return CheckUsernameModel(
      username: username ?? this.username,
      isAvailable: isAvailable ?? this.isAvailable,
      reason: reason ?? this.reason,
    );
  }

  @override
  CheckUsernameModel fromJson(Map<String, dynamic> json) {
    return CheckUsernameModel(
      username: json['username'] as String?,
      isAvailable: json['is_available'] as bool?,
      reason: json['reason'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'is_available': isAvailable,
      'reason': reason,
    };
  }
}
