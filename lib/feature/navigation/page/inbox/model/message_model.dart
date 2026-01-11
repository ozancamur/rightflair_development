class MessageModel {
  final String id;
  final String senderName;
  final String senderAvatarUrl;
  final String lastMessage;
  final DateTime timestamp;
  final bool isRead;
  final bool isPhoto;

  MessageModel({
    required this.id,
    required this.senderName,
    required this.senderAvatarUrl,
    required this.lastMessage,
    required this.timestamp,
    required this.isRead,
    this.isPhoto = false,
  });
}
