import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/bloc/post/get_all_post_bloc.dart';
import 'package:safe_hunt/bloc/post/get_post_details_bloc.dart';
import 'package:safe_hunt/model/user_model.dart';
import 'package:safe_hunt/providers/post_provider.dart';
import 'package:safe_hunt/providers/user_provider.dart';
import 'package:safe_hunt/screens/create_group_chat/bloc/add_remove_group_member_bloc.dart';
import 'package:safe_hunt/screens/create_group_chat/bloc/get_group_member_bloc.dart';
import 'package:safe_hunt/screens/post/post_detail_screen.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/app_navigation.dart';
import 'package:safe_hunt/utils/common/app_colors.dart';
import 'package:safe_hunt/widgets/Custom_image_widget.dart';
import 'package:safe_hunt/widgets/news_feed_card.dart';
import '../../../utils/colors.dart';
import '../../../widgets/big_text.dart';
import '../../../widgets/chats_card.dart';

class PendingPostScreen extends StatefulWidget {
  final bool isLeadingIcon;
  final String groupId;

  const PendingPostScreen(
      {super.key, this.isLeadingIcon = true, required this.groupId});

  @override
  State<PendingPostScreen> createState() => _PendingPostScreenState();
}

class _PendingPostScreenState extends State<PendingPostScreen> {
  final ScrollController _scrollController = ScrollController();
  int _page = 1;
  bool _isLoadingMore = false;

  List<UserData> frientList = [];
  _fetchPendingPost(bool isLoader) {
    GetAllPostBloc().getAllPostBlocMethod(
        context: context,
        onFailure: () {},
        onSuccess: () {},
        setProgressBar: () {
          AppDialogs.progressAlertDialog(context: context);
        },
        isPendingPost: true,
        groupId: widget.groupId);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _fetchPendingPost(true);

      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
                _scrollController.position.maxScrollExtent &&
            _isLoadingMore == false) {
          _isLoadingMore = true;
          setState(() {});
          _fetchPendingPost(false);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<PostProvider, UserProvider>(
        builder: (context, val, user, _) {
      return Scaffold(
        // backgroundColor: Colors.transparent,
        appBar: AppBar(
          bottomOpacity: 0.0,
          scrolledUnderElevation: 0,
          elevation: 0,
          backgroundColor: appButtonColor,
          leading: widget.isLeadingIcon
              ? Padding(
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
                )
              : null,
          titleSpacing: widget.isLeadingIcon ? -10 : null,
          title: BigText(
            text: 'Pending Post',
            size: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: (val.isPendingPost == false)
                  ? Center(child: BigText(text: 'Pending post not found'))
                  : SingleChildScrollView(
                      // controller: _scrollController,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListView.builder(
                              physics: const ScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: val.pendingPost.length,
                              itemBuilder: (BuildContext context, index) {
                                return NewsFeedCard(
                                  profileOntap: true,
                                  post: val.pendingPost[index],
                                  groupId: widget.groupId,
                                  functionOnTap: () {
                                    PostDetailBloc().postDetailBlocMethod(
                                      context: context,
                                      setProgressBar: () {
                                        AppDialogs.progressAlertDialog(
                                            context: context);
                                      },
                                      groupId: widget.groupId,
                                      postId: val.pendingPost[index].id ?? '0',
                                      onSuccess: () {
                                        AppNavigation.push(
                                            const PostDetailScreen());
                                      },
                                    );
                                  },
                                );
                              }),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildTabButton(
      int index, String text, Color bgColor, Color textColor) {
    return Expanded(
      child: GestureDetector(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: appButtonColor,
            borderRadius: BorderRadius.circular(57.r),
          ),
          child: BigText(
            text: text,
            color: textColor,
            size: 10.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildChatItem(String name, String message, String time,
      {String? image,
      String? groupId,
      void Function()? onTap,
      bool isGroup = false,
      String? status}) {
    return InkWell(
      onTap: onTap,
      child: ChatsCard(
        groupId: groupId,
        name: name,
        message: message,
        time: time,
        image: image,
        isGroup: isGroup,
        status: status,
      ),
    );
  }
}
