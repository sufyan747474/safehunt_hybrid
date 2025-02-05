import 'package:safe_hunt/model/user_model.dart';
import 'package:safe_hunt/screens/post/enums/enums.dart';

class CommentModel {
  CommentModel(
      {this.commentId,
      this.postId,
      this.postSharedId,
      this.type,
      this.comment,
      this.replies,
      this.createdAt,
      this.parrentId,
      this.isSharedPost = false,
      this.isChild = false,
      this.userId,
      this.isLiked = false,
      this.totalLiked,
      this.user});
  String? commentId;
  String? parrentId;
  String? postId;
  String? userId;
  String? postSharedId;
  commentType? type;
  String? createdAt;
  String? comment;
  List<CommentModel?>? replies;
  UserData? user;
  bool isChild;
  bool isSharedPost;
  bool isLiked;
  String? totalLiked;
}
