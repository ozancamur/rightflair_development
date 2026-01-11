import 'package:equatable/equatable.dart';

class FeedPostModel extends Equatable {
  final String id;
  final String userId;
  final String userName;
  final String userAvatar;
  final String imageUrl;
  final String? description;
  final int likeCount;
  final int commentCount;
  final int shareCount;
  final DateTime createdAt;
  final bool isLiked;
  final bool isSaved;

  const FeedPostModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.imageUrl,
    this.description,
    required this.likeCount,
    required this.commentCount,
    required this.shareCount,
    required this.createdAt,
    this.isLiked = false,
    this.isSaved = false,
  });

  FeedPostModel copyWith({
    String? id,
    String? userId,
    String? userName,
    String? userAvatar,
    String? imageUrl,
    String? description,
    int? likeCount,
    int? commentCount,
    int? shareCount,
    DateTime? createdAt,
    bool? isLiked,
    bool? isSaved,
  }) {
    return FeedPostModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      shareCount: shareCount ?? this.shareCount,
      createdAt: createdAt ?? this.createdAt,
      isLiked: isLiked ?? this.isLiked,
      isSaved: isSaved ?? this.isSaved,
    );
  }

  factory FeedPostModel.fromJson(Map<String, dynamic> json) {
    return FeedPostModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userAvatar: json['userAvatar'] as String,
      imageUrl: json['imageUrl'] as String,
      description: json['description'] as String?,
      likeCount: json['likeCount'] as int,
      commentCount: json['commentCount'] as int,
      shareCount: json['shareCount'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isLiked: json['isLiked'] as bool? ?? false,
      isSaved: json['isSaved'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'userAvatar': userAvatar,
      'imageUrl': imageUrl,
      'description': description,
      'likeCount': likeCount,
      'commentCount': commentCount,
      'shareCount': shareCount,
      'createdAt': createdAt.toIso8601String(),
      'isLiked': isLiked,
      'isSaved': isSaved,
    };
  }

  @override
  List<Object?> get props => [
    id,
    userId,
    userName,
    userAvatar,
    imageUrl,
    description,
    likeCount,
    commentCount,
    shareCount,
    createdAt,
    isLiked,
    isSaved,
  ];
}
