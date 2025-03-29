import 'package:safe_hunt/model/user_model.dart';

class GroupModel {
  String? id;
  String? name;
  String? cover;
  String? logo;
  String? description;
  String? status;
  AdminInfo? adminInfo;

  GroupModel({
    this.id,
    this.name,
    this.cover,
    this.logo,
    this.description,
    this.status,
    this.adminInfo,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
        id: json["id"].toString(),
        name: json["name"],
        cover: json["cover"],
        logo: json["logo"],
        description: json["description"],
        status: json["status"],
        adminInfo: json["AdminInfo"] == null
            ? null
            : AdminInfo.fromJson(json["AdminInfo"]),
      );
}

class AdminInfo {
  String? id;
  String? type;
  String? status;
  UserData? member;

  AdminInfo({
    this.id,
    this.type,
    this.status,
    this.member,
  });

  factory AdminInfo.fromJson(Map<String, dynamic> json) => AdminInfo(
        id: json["id"].toString(),
        type: json["type"],
        status: json["status"],
        member:
            json["member"] == null ? null : UserData.fromJson(json["member"]),
      );
}
