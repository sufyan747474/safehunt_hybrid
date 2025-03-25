class GroupModel {
  String? id;
  String? name;
  String? cover;
  String? logo;
  String? description;
  String? status;

  GroupModel({
    this.id,
    this.name,
    this.cover,
    this.logo,
    this.description,
    this.status,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
        id: json["id"].toString(),
        name: json["name"],
        cover: json["cover"],
        logo: json["logo"],
        description: json["description"],
        status: json["status"],
      );
}
