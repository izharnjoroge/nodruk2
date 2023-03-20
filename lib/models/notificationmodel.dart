import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String id;
  String title;
  String content;
  Timestamp time;
  String from;
  String to;
  String status;

  NotificationModel({
    this.id,
    this.title,
    this.content,
    this.time,
    this.from,
    this.to,
    this.status,
  });
  factory NotificationModel.fromDoc(DocumentSnapshot json) {
    return NotificationModel(
      id: json.id,
      content: json['content'],
      title: json['title'],
      time: json['time'],
      from: json['from'],
      to: json['to'],
      status: json['status'],
    );
  }
}
