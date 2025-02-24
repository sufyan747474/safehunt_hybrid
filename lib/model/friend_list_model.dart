import 'package:safe_hunt/model/user_model.dart';

class FriendList {
  String? id;
  String? userId;
  String? friendId;
  String? status;
  String? createdAt;
  String? updatedAt;
  UserData? user;
  UserData? friend;

  FriendList({
    this.id,
    this.userId,
    this.friendId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.friend,
  });

  factory FriendList.fromJson(Map<String, dynamic> json) => FriendList(
        id: json["id"].toString(),
        userId: json["user_id"].toString(),
        friendId: json["friend_id"].toString(),
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        user: json["user"] == null ? null : UserData.fromJson(json["user"]),
        friend:
            json["friend"] == null ? null : UserData.fromJson(json["friend"]),
      );
}
