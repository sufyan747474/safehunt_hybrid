import 'package:safe_hunt/model/user_model.dart';

class FriendModel {
  String? id;
  String? status;
  String? requesterId;
  String? recipientId;
  UserData? requester;
  UserData? recipient;

  FriendModel({
    this.id,
    this.status,
    this.requesterId,
    this.recipientId,
    this.requester,
    this.recipient,
  });

  factory FriendModel.fromJson(Map<String, dynamic> json) => FriendModel(
        id: json["id"].toString(),
        status: json["status"],
        requesterId: json["requesterId"],
        recipientId: json["recipientId"],
        requester: json["requester"] == null
            ? null
            : UserData.fromJson(json["requester"]),
        recipient: json["recipient"] == null
            ? null
            : UserData.fromJson(json["recipient"]),
      );
}
