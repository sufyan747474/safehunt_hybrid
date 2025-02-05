class PostData {
  String? id;
  String? description;
  String? image;
  dynamic tags;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? userId;
  User? user;
  List<Comment>? comments;
  int? likesCount;
  int? sharesCount;

  PostData({
    this.id,
    this.description,
    this.image,
    this.tags,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.user,
    this.comments,
    this.likesCount,
    this.sharesCount,
  });

  factory PostData.fromJson(Map<String, dynamic> json) => PostData(
        id: json["id"],
        description: json["description"],
        image: json["image"],
        tags: json["tags"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        userId: json["userId"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        comments: json["comments"] == null
            ? []
            : List<Comment>.from(
                json["comments"]!.map((x) => Comment.fromJson(x))),
        likesCount: json["likesCount"],
        sharesCount: json["sharesCount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "image": image,
        "tags": tags,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "userId": userId,
        "user": user?.toJson(),
        "comments": comments == null
            ? []
            : List<dynamic>.from(comments!.map((x) => x.toJson())),
        "likesCount": likesCount,
        "sharesCount": sharesCount,
      };
}

class Comment {
  int? id;
  String? content;
  DateTime? createdAt;
  int? likeCount;

  Comment({
    this.id,
    this.content,
    this.createdAt,
    this.likeCount,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        content: json["content"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        likeCount: json["likeCount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "createdAt": createdAt?.toIso8601String(),
        "likeCount": likeCount,
      };
}

class User {
  String? id;
  String? firstname;
  DateTime? lastname;
  String? displayname;
  String? username;
  String? email;
  String? phonenumber;
  String? status;
  String? otp;
  DateTime? otpexpiry;
  String? password;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic resetToken;
  dynamic stripeCustomerId;
  dynamic stripeCardId;
  dynamic resetTokenExpires;
  String? coverPhoto;
  String? profilePhoto;
  String? bio;
  String? huntingExperience;
  List<String>? skills;
  List<String>? equipmentImages;

  User({
    this.id,
    this.firstname,
    this.lastname,
    this.displayname,
    this.username,
    this.email,
    this.phonenumber,
    this.status,
    this.otp,
    this.otpexpiry,
    this.password,
    this.createdAt,
    this.updatedAt,
    this.resetToken,
    this.stripeCustomerId,
    this.stripeCardId,
    this.resetTokenExpires,
    this.coverPhoto,
    this.profilePhoto,
    this.bio,
    this.huntingExperience,
    this.skills,
    this.equipmentImages,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstname: json["firstname"],
        lastname:
            json["lastname"] == null ? null : DateTime.parse(json["lastname"]),
        displayname: json["displayname"],
        username: json["username"],
        email: json["email"],
        phonenumber: json["phonenumber"],
        status: json["status"],
        otp: json["otp"],
        otpexpiry: json["otpexpiry"] == null
            ? null
            : DateTime.parse(json["otpexpiry"]),
        password: json["password"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        resetToken: json["resetToken"],
        stripeCustomerId: json["stripe_customer_id"],
        stripeCardId: json["stripe_card_id"],
        resetTokenExpires: json["resetTokenExpires"],
        coverPhoto: json["coverPhoto"],
        profilePhoto: json["profilePhoto"],
        bio: json["bio"],
        huntingExperience: json["huntingExperience"],
        skills: json["skills"] == null
            ? []
            : List<String>.from(json["skills"]!.map((x) => x)),
        equipmentImages: json["equipmentImages"] == null
            ? []
            : List<String>.from(json["equipmentImages"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname?.toIso8601String(),
        "displayname": displayname,
        "username": username,
        "email": email,
        "phonenumber": phonenumber,
        "status": status,
        "otp": otp,
        "otpexpiry": otpexpiry?.toIso8601String(),
        "password": password,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "resetToken": resetToken,
        "stripe_customer_id": stripeCustomerId,
        "stripe_card_id": stripeCardId,
        "resetTokenExpires": resetTokenExpires,
        "coverPhoto": coverPhoto,
        "profilePhoto": profilePhoto,
        "bio": bio,
        "huntingExperience": huntingExperience,
        "skills":
            skills == null ? [] : List<dynamic>.from(skills!.map((x) => x)),
        "equipmentImages": equipmentImages == null
            ? []
            : List<dynamic>.from(equipmentImages!.map((x) => x)),
      };
}
