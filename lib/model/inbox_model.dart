// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'package:safe_hunt/model/user_model.dart';

class InboxModel {
  UserData? user;
  String? lastMessage;
  String? messageType;
  String? status;
  String? timestamp;

  InboxModel({
    this.user,
    this.lastMessage,
    this.messageType,
    this.status,
    this.timestamp,
  });

  factory InboxModel.fromJson(Map<String, dynamic> json) => InboxModel(
        user: json["user"] == null ? null : UserData.fromJson(json["user"]),
        lastMessage: json["lastMessage"],
        messageType: json["messageType"],
        status: json["status"],
        timestamp: json["timestamp"],
      );
}
