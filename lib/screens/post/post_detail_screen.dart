import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

class CommentScreenArguments {
  CommentScreenArguments({this.isUser, this.postData, this.postShareId});
  final bool? isUser;
  final PostData? postData;
  final String? postShareId;
}

class PostDetailScreen extends StatefulWidget {
  const PostDetailScreen({
    super.key,
    this.isUser,
    this.postShareId,
  });
  final bool? isUser;
  final String? postShareId;

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  @override
  void initState() {
    log('post share id in comment : ${widget.postShareId}');
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
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            NewsFeedCard(
              functionOnTap: () {
                Utils.typingModal(
                  modalType.comment,
                  // postId: val.postsDetails?.id ?? '',
                  sharePostId: widget.postShareId,
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
              List.generate(5, (index) {
                return CommentModel(
                    isLiked: false,
                    // userId: data?.userId,
                    totalLiked: '10',
                    // parrentId: data?.parentId,
                    // isSharedPost:
                    //     widget.postShareId != 'null' ? true : false,
                    postSharedId: widget.postShareId,
                    replies:
                        // (data?.childComment == null)
                        //     ? null
                        //     :
                        List.generate(
                            5,
                            (index) => CommentModel(
                                  isLiked: true,
                                  totalLiked: '65',
                                  // userId: data?.childComment?[index].userId,
                                  isSharedPost: widget.postShareId != 'null'
                                      ? true
                                      : false,
                                  // parrentId:
                                  //     data?.childComment?[index].parentId,
                                  isChild: true,
                                  createdAt: DateTime.now().toString(),
                                  postSharedId: widget.postShareId,
                                  commentId: '1',
                                  // postId: data?.postId,
                                  // user: data?.childComment?[index].user,
                                  comment: 'hello mangog',
                                  type: commentType.reply,
                                )),
                    // commentId: data?.id,
                    // postId: data?.postId,
                    // user: data?.user,
                    comment: 'yangoo',
                    type: commentType.comment,
                    createdAt: DateTime.now().toString());
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
  }

  Widget commentList(List<CommentModel> list) {
    return Column(
      children: [
        for (int i = 0; i < list.length; i++) CommentWidget(model: list[i])
      ],
    );
  }
}
