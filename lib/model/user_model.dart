// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

class UserData {
  String? firstname;
  String? lastname;
  String? coverPhoto;
  String? profilePhoto;
  String? bio;
  dynamic huntingExperience;
  dynamic skills;
  dynamic equipmentImages;
  String? displayname;
  String? username;
  String? email;
  String? phonenumber;
  String? id;
  String? createdAt;
  String? updatedAt;
  String? status;
  String? otp;
  String? otpexpiry;
  String? token;

  UserData({
    this.firstname,
    this.lastname,
    this.coverPhoto,
    this.profilePhoto,
    this.bio,
    this.huntingExperience,
    this.skills,
    this.equipmentImages,
    this.displayname,
    this.username,
    this.email,
    this.phonenumber,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.otp,
    this.otpexpiry,
    this.token,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        firstname: json["firstname"],
        lastname: json["lastname"],
        coverPhoto: json["coverPhoto"],
        profilePhoto: json["profilePhoto"],
        bio: json["bio"],
        huntingExperience: json["huntingExperience"],
        skills: json["skills"],
        equipmentImages: json["equipmentImages"],
        displayname: json["displayname"],
        username: json["username"],
        email: json["email"],
        phonenumber: json["phonenumber"],
        id: json["id"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        status: json["status"],
        otp: json["otp"],
        otpexpiry: json["otpexpiry"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
        "coverPhoto": coverPhoto,
        "profilePhoto": profilePhoto,
        "bio": bio,
        "huntingExperience": huntingExperience,
        "skills": skills,
        "equipmentImages": equipmentImages,
        "displayname": displayname,
        "username": username,
        "email": email,
        "phonenumber": phonenumber,
        "id": id,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "status": status,
        "otp": otp,
        "otpexpiry": otpexpiry,
        "token": token,
      };
}
