import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/providers/post_provider.dart';

import 'package:safe_hunt/screens/post/enums/enums.dart';
import 'package:safe_hunt/screens/post/model/comment_model.dart';
import 'package:safe_hunt/screens/post/model/post_model.dart';
import 'package:safe_hunt/screens/post/widget/comment_widget.dart';
import 'package:safe_hunt/utils/app_navigation.dart';
import 'package:safe_hunt/utils/colors.dart';
import 'package:safe_hunt/utils/common/app_colors.dart';
import 'package:safe_hunt/utils/utils.dart';
import 'package:safe_hunt/widgets/big_text.dart';
import 'package:safe_hunt/widgets/news_feed_card.dart';

// class CommentScreenArguments {
//   CommentScreenArguments({this.isUser, this.postData, this.postShareId});
//   final bool? isUser;
//   final PostData? postData;
//   final String? postShareId;
// }

class PostDetailScreen extends StatefulWidget {
  const PostDetailScreen({
    super.key,
    this.isUser,
    this.postShareId,
    this.postData,
    this.profileOntap = true,
  });
  final bool? isUser;
  final String? postShareId;
  final PostData? postData;
  final bool profileOntap;

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  @override
  void initState() {
    // Utils.currentRoute = 'postDetails';
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // Utils.currentRoute = '';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostProvider>(builder: (context, val, _) {
      return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          bottomOpacity: 0.0,
          scrolledUnderElevation: 0,
          elevation: 0,
          backgroundColor: appButtonColor,
          leading: Padding(
            padding: EdgeInsets.all(8.0.w),
            child: Transform.translate(
                offset: Offset(1.w, 0),
                child: GestureDetector(
                    onTap: () {
                      AppNavigation.pop();
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 23.sp,
                      color: Colors.black,
                    ))),
          ),
          titleSpacing: -10,
          title: BigText(
            text: 'Post Detail',
            size: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              NewsFeedCard(
                profileOntap: widget.profileOntap,
                isPostDetails: true,
                post: val.postDetail,
                functionOnTap: () {
                  Utils.typingModal(
                    modalType.comment,
                    postId: val.postDetail?.id ?? '',
                  );
                },
              ),
              // PostWidget(
              //   isPostDetails: true,
              //   post: val.postsDetails,
              //   postShareId: widget.postShareId,
              //   commentFunction: () {
              //     Constants.typingModal(
              //       modalType.comment,
              //       postId: val.postsDetails?.id ?? '',
              //       sharePostId: widget.postShareId,
              //       // val.postsDetails?.postShareId ?? ""
              //     );
              //   },
              // ),
              19.verticalSpace,
              commentList(
                List.generate(val.postDetail?.comments?.length ?? 0, (index) {
                  final commentData = val.postDetail?.comments?[index];
                  return CommentModel(
                    commentId: commentData?.id,
                    isLiked: commentData?.commentLiked ?? false,
                    userId: commentData?.user?.id,
                    totalLiked: commentData?.likeCount ?? '0',
                    postId: val.postDetail?.id,
                    user: commentData?.user,
                    createdAt: commentData?.createdAt,
                    comment: commentData?.content ?? "",
                    type: commentType.comment,

                    // isSharedPost:
                    //     widget.postShareId != 'null' ? true : false,
                    // postSharedId: widget.postShareId,
                    replies: List.generate(
                        commentData?.replies?.length ?? 0,
                        (index) => CommentModel(
                              isLiked:
                                  commentData?.replies?[index].replyLiked ??
                                      false,
                              totalLiked: commentData
                                      ?.replies?[index].commentReplyCount ??
                                  '0',

                              userId: commentData?.replies?[index].user?.id,
                              // isSharedPost:
                              //     widget.postShareId != 'null' ? true : false,
                              parrentId: commentData?.id,
                              isChild: true,
                              createdAt: commentData?.replies?[index].createdAt,
                              postSharedId: widget.postShareId,
                              commentId: commentData?.replies?[index].id,
                              postId: val.postDetail?.id,
                              user: commentData?.replies?[index].user,
                              comment:
                                  commentData?.replies?[index].content ?? "",
                              type: commentType.reply,
                            )),
                    // commentId: data?.id,
                    // postId: data?.postId,
                    // user: data?.user,
                  );
                }),
                // [
                // CommentModel(
                //     type: commentType.comment,
                //     comment:
                //         "Lorem ipsum dolor sit amet, coetur adipiscing elit ut aliquam, purus sit amet luctus Lorem ipsum dolor sit amet aliquam, purus sit amet luctus",
                //     createdAt: DateTime.now(),
                //     replies: [
                //       CommentModel(
                //           type: commentType.reply,
                //           comment:
                //               "Lorem ipsum dolor sit amet, coetur adipiscing elit ut.",
                //           createdAt: DateTime.now()),
                //       CommentModel(
                //           type: commentType.reply,
                //           comment:
                //               "Lorem ipsum dolor sit amet, coetur adipiscing elit ut.",
                //           createdAt: DateTime.now())
                //     ]),
                // CommentModel(
                //     type: commentType.comment,
                //     comment:
                //         "Lorem ipsum dolor sit amet, coetur adipiscing elit ut aliquam, purus sit amet luctus Lorem ipsum dolor sit amet aliquam, purus sit amet luctus",
                //     createdAt: DateTime.now()),
                // ]
              ),
              19.verticalSpace,
            ],
          ),
        ),
      );
    });
  }

  Widget commentList(List<CommentModel> list) {
    return Column(
      children: [
        for (int i = 0; i < list.length; i++) CommentWidget(model: list[i])
      ],
    );
  }
}
