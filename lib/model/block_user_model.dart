import 'package:safe_hunt/model/user_model.dart';

class BlockUserModel {
  String? id;
  UserData? blocked;

  BlockUserModel({
    this.id,
    this.blocked,
  });

  factory BlockUserModel.fromJson(Map<String, dynamic> json) => BlockUserModel(
        id: json["id"].toString(),
        blocked:
            json["blocked"] == null ? null : UserData.fromJson(json["blocked"]),
      );
}
