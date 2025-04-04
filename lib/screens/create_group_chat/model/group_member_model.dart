import 'package:safe_hunt/model/user_model.dart';

class GroupMemberModel {
  String? id;
  String? type;
  String? status;
  UserData? member;

  GroupMemberModel({
    this.id,
    this.type,
    this.status,
    this.member,
  });

  factory GroupMemberModel.fromJson(Map<String, dynamic> json) =>
      GroupMemberModel(
        id: json["id"].toString(),
        type: json["type"],
        status: json["status"],
        member:
            json["member"] == null ? null : UserData.fromJson(json["member"]),
      );
}
