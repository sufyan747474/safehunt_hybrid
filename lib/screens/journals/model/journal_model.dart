import 'package:safe_hunt/model/user_model.dart';
import 'package:safe_hunt/screens/journals/model/location_model.dart';

class JournalData {
  String? id;
  String? title;
  String? date;
  String? description;
  LocationModel? location;
  String? weather;
  String? createdAt;
  String? updatedAt;
  UserData? user;

  JournalData({
    this.id,
    this.title,
    this.date,
    this.description,
    this.location,
    this.weather,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory JournalData.fromJson(Map<String, dynamic> json) => JournalData(
        id: json["id"].toString(),
        title: json["title"],
        date: json["date"],
        description: json["description"],
        location: json["location"] == null
            ? null
            : LocationModel.fromJson(json["location"]),
        weather: json["weather"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        user: json["user"] == null ? null : UserData.fromJson(json["user"]),
      );
}
