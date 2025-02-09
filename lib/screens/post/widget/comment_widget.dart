import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/bloc/comment/childComment/delete_child_comment_bloc.dart';
import 'package:safe_hunt/bloc/comment/delete_comment_bloc.dart';
import 'package:safe_hunt/providers/user_provider.dart';
import 'package:safe_hunt/screens/post/enums/enums.dart';
import 'package:safe_hunt/screens/post/model/comment_model.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/colors.dart';
import 'package:safe_hunt/utils/utils.dart';
import 'package:safe_hunt/widgets/Custom_image_widget.dart';

class CommentWidget extends StatefulWidget {
  const CommentWidget({super.key, this.model, this.isReply = true});

  final CommentModel? model;
  final bool isReply;
  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  bool expand = false;
  bool like = false;
  double? height;
  final key = GlobalKey();

  String? currentUserId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentUserId = context.read<UserProvider>().user?.id;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.model?.type == commentType.comment) {
        final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
        height = renderBox?.size.height;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: key,
      width: widget.model?.type == commentType.comment ? .9.sw : .75.sw,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomImageWidget(
                borderWidth: 2,
                borderColor: appButtonColor,
                imageWidth: 40.w,
                imageHeight: 40.w,
                imageUrl: widget.model?.user?.profilePhoto,
              ),
              if (height != null) 10.verticalSpace,
              // if (widget.model?.type == commentType.comment)
              //   SizedBox(
              //       height: height != null ? .72 * (height ?? 0.0) : height,
              //       child: const VerticalDivider(
              //           color: AppColors.redColor, thickness: 1))
            ],
          ),
          // if (widget.model?.type == commentType.comment)
          //   10.horizontalSpace
          // else
          10.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width:
                    widget.model?.type == commentType.comment ? .69.sw : .6.sw,
                padding: EdgeInsets.only(bottom: 10.r, right: 0.r, left: 10.r),
                decoration: BoxDecoration(
                    color: appButtonColor,
                    borderRadius: BorderRadius.circular(12.r)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.model?.userId != currentUserId) 10.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            (widget.model?.user?.displayname) ?? '',
                            // "2 mins",
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: appBrownColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: ""),
                          ),
                        ),
                        if (widget.model?.userId == currentUserId)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.zero,
                                  visualDensity: VisualDensity.compact,
                                  onPressed: () {
                                    if (widget.model?.isChild == true) {
                                      DeleteChildCommentBloc()
                                          .deleteChildCommentBlocMethod(
                                        context: context,
                                        setProgressBar: () {
                                          AppDialogs.progressAlertDialog(
                                              context: context);
                                        },
                                        commentId: widget.model?.commentId,
                                        parrentId: widget.model?.parrentId,
                                      );
                                    } else if (widget.model?.isChild == false) {
                                      DeleteCommentBloc()
                                          .deleteCommentBlocMethod(
                                        context: context,
                                        setProgressBar: () {
                                          AppDialogs.progressAlertDialog(
                                              context: context);
                                        },
                                        commentId: widget.model?.commentId,
                                        postId: widget.model?.postId,
                                      );
                                    }
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    size: 18.r,
                                    color: appBrownColor,
                                  ),

                                  // size: 30.r,
                                  color: appBrownColor),
                              // if (widget.model?.userId ==
                              //     context.read<UserProvider>().user?.id)
                              IconButton(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.zero,
                                  visualDensity: VisualDensity.compact,
                                  onPressed: () {
                                    Utils.typingModal(
                                      modalType.comment,
                                      commentId: widget.model?.commentId,
                                      comment: widget.model?.comment,
                                      isChild: widget.model?.isChild ?? false,
                                      parrentId: widget.model?.parrentId,
                                      isEdit: true,
                                      isSharedPost:
                                          widget.model?.isSharedPost ?? false,
                                      sharePostId: widget.model?.postSharedId,
                                    );
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    size: 18.r,
                                    color: appBrownColor,
                                  ),

                                  // size: 30.r,
                                  color: appBrownColor),
                            ],
                          )
                      ],
                    ),
                    if (widget.model?.userId != currentUserId) 10.verticalSpace,
                    Padding(
                      padding: EdgeInsets.only(right: 10.r),
                      child: Text(
                        widget.model?.comment ?? "",
                        style: TextStyle(
                            overflow: TextOverflow.visible,
                            fontSize: 12.sp,
                            height: 1.2.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    8.verticalSpace,
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // LikeUnlikeCommentBloc().likeUnlikeCommentBlocMethod(
                            //   context: context,
                            //   like: widget.model?.isLiked == true ? '0' : '1',
                            //   commentId: widget.model?.commentId,
                            //   postId: widget.model?.postId,
                            //   postSharedId: widget.model?.postSharedId,
                            //   setProgressBar: () {
                            //     AppDialogs.progressAlertDialog(
                            //         context: context);
                            //   },
                            // );
                            // like = !like;
                            // setState(() {});
                          },
                          child: textIcon(
                              text: "${widget.model?.totalLiked ?? '0'} Like",
                              icon: like
                                  ? "assets/like_color_icon.svg"
                                  : "assets/icons_like.svg"),
                        ),
                        25.horizontalSpace,
                        // if ((widget.model?.replies ?? []).isNotEmpty)
                        if (widget.isReply)
                          GestureDetector(
                            onTap: () {
                              Utils.typingModal(
                                modalType.reply,
                                commentId: widget.model?.commentId,
                                sharePostId: widget.model?.postSharedId,
                                postId: widget.model?.postId,
                              );
                            },
                            child: textIcon(
                                text:
                                    "${widget.model?.replies?.length ?? ""} Replies",
                                icon: "assets/icon_comment.svg"),
                          )
                      ],
                    ),
                  ],
                ),
              ),
              5.verticalSpace,
              Text(
                Utils.getDayFromDateTime(
                    widget.model?.createdAt ?? DateTime.now().toString()),
                style: TextStyle(
                    fontSize: 12.sp,
                    color: appBrownColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: ""),
              ),
              if ((widget.model?.replies ?? []).isNotEmpty)
                AnimatedSize(
                  reverseDuration: const Duration(milliseconds: 200),
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.linear,
                  alignment: Alignment.bottomLeft,
                  clipBehavior: Clip.hardEdge,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        10.verticalSpace,
                        replyExpandButton(),
                        10.verticalSpace,
                        replies()
                      ]),
                ),
              // 10.verticalSpace,
            ],
          )
        ],
      ),
    );
  }

  GestureDetector replyExpandButton() {
    return GestureDetector(
      onTap: () {
        expand = !expand;
        setState(() {});
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          10.horizontalSpace,
          Text(
            "View all ${widget.model?.replies?.length} comments",
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
          ),
          Icon(
              expand
                  ? Icons.keyboard_arrow_up_outlined
                  : Icons.keyboard_arrow_down_outlined,
              color: appBrownColor)
        ],
      ),
    );
  }

  SizedBox replies() {
    return SizedBox(
      height: expand ? null : 0,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        for (int i = 0; i < (widget.model?.replies ?? []).length; i++)
          Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: CommentWidget(
              isReply: false,
              model: widget.model?.replies?[i],
            ),
          ),
        10.verticalSpace,
      ]),
    );
  }

  Widget textIcon({String? text, String? icon}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text ?? "",
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
        ),
        5.horizontalSpace,
        SvgPicture.asset(
          icon ?? "", width: 14.r,
          // color: AppColors.PRIMARY_COLOR
        ),
      ],
    );
  }
}
