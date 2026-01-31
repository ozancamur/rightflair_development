import '../../../core/base/model/base.dart';

class MessageSenderModel extends BaseModel<MessageSenderModel> {
  String? id;
  String? username;
  String? fullName;
  String? profilePhotoUrl;

  MessageSenderModel({
    this.id,
    this.username,
    this.fullName,
    this.profilePhotoUrl,
  });

  @override
  MessageSenderModel copyWith({
    String? id,
    String? username,
    String? fullName,
    String? profilePhotoUrl,
  }) {
    return MessageSenderModel(
      id: id ?? this.id,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
    );
  }

  @override
  MessageSenderModel fromJson(Map<String, dynamic> json) {
    return MessageSenderModel(
      id: json['id'] as String?,
      username: json['username'] as String?,
      fullName: json['full_name'] as String?,
      profilePhotoUrl: json['profile_photo_url'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'full_name': fullName,
      'profile_photo_url': profilePhotoUrl,
    };
  }
}
