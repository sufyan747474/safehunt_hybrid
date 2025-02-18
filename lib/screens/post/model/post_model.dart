import 'package:safe_hunt/model/user_model.dart';

class PostData {
  String? id;
  String? description;
  String? image;
  dynamic tags;
  String? latitude;
  String? longitude;
  String? createdAt;
  String? updatedAt;
  String? userId;
  bool? postLiked;
  UserData? user;
  List<PostComment>? comments;
  String? likesCount;
  String? sharesCount;

  PostData({
    this.id,
    this.description,
    this.image,
    this.tags,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.postLiked,
    this.user,
    this.comments,
    this.likesCount,
    this.sharesCount,
  });

  factory PostData.fromJson(Map<String, dynamic> json) => PostData(
        id: json["id"].toString(),
        description: json["description"],
        image: json["image"],
        tags: json["tags"],
        latitude: json["latitude"]?.toString(),
        longitude: json["longitude"]?.toString(),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        userId: json["userId"].toString(),
        postLiked: json["postLiked"],
        user: json["user"] == null ? null : UserData.fromJson(json["user"]),
        comments: json["comments"] == null
            ? []
            : List<PostComment>.from(
                json["comments"]!.map((x) => PostComment.fromJson(x))),
        likesCount: json["likesCount"].toString(),
        sharesCount: json["sharesCount"].toString(),
      );
}

class PostComment {
  String? id;
  String? content;
  String? createdAt;
  String? likeCount;
  String? commentReplyCount;
  List<PostComment>? replies;
  UserData? user;
  bool? commentLiked;
  bool? replyLiked;

  PostComment({
    this.id,
    this.content,
    this.createdAt,
    this.likeCount,
    this.commentReplyCount,
    this.replies,
    this.user,
    this.commentLiked,
    this.replyLiked,
  });

  factory PostComment.fromJson(Map<String, dynamic> json) => PostComment(
        id: json["id"].toString(),
        content: json["content"],
        createdAt: json["createdAt"],
        likeCount: json["likeCount"].toString(),
        commentReplyCount: json["CommentreplyCount"].toString(),
        replies: json["replies"] == null
            ? []
            : List<PostComment>.from(
                json["replies"]!.map((x) => PostComment.fromJson(x))),
        user: json["user"] == null ? null : UserData.fromJson(json["user"]),
        commentLiked: json["commentLiked"],
        replyLiked: json["replyLiked"],
      );
}
