
import 'notification_type.dart';

class NotificationModel {
  final String id;
  final String title;
  final String? subtitle;
  final String timeAgo;
  final NotificationType type;
  final bool isRead;

  const NotificationModel({
    required this.id,
    required this.title,
    this.subtitle,
    required this.timeAgo,
    required this.type,
    this.isRead = false,
  });
}
