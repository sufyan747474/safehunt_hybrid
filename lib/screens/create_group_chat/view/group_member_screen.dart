import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/model/user_model.dart';
import 'package:safe_hunt/providers/post_provider.dart';
import 'package:safe_hunt/providers/user_provider.dart';
import 'package:safe_hunt/screens/create_group_chat/bloc/add_remove_group_member_bloc.dart';
import 'package:safe_hunt/screens/create_group_chat/bloc/get_group_member_bloc.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/app_navigation.dart';
import 'package:safe_hunt/utils/common/app_colors.dart';
import 'package:safe_hunt/widgets/Custom_image_widget.dart';
import '../../../utils/colors.dart';
import '../../../widgets/big_text.dart';
import '../../../widgets/chats_card.dart';

class GroupMemberScreen extends StatefulWidget {
  final bool isLeadingIcon;
  final String groupId;

  const GroupMemberScreen(
      {super.key, this.isLeadingIcon = true, required this.groupId});

  @override
  State<GroupMemberScreen> createState() => _GroupMemberScreenState();
}

class _GroupMemberScreenState extends State<GroupMemberScreen> {
  final ScrollController _scrollController = ScrollController();
  int _page = 1;
  bool _isLoadingMore = false;

  List<UserData> frientList = [];
  _fetchGroupMember(bool isLoader) {
    GetGroupMemberBloc().getGroupMemberBlocMethod(
        context: context,
        setProgressBar: () {
          AppDialogs.progressAlertDialog(context: context);
        },
        groupId: widget.groupId
        // isLoader: isLoader,
        // page: _page,
        // userId: context.read<UserProvider>().user?.id ?? '',
        // onSuccess: (res) {
        //   _page++;

        //   setState(() {});
        // },
        // onFailure: () {
        //   _isLoadingMore = false;
        //   setState(() {});
        // },
        );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _fetchGroupMember(true);

      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
                _scrollController.position.maxScrollExtent &&
            _isLoadingMore == false) {
          _isLoadingMore = true;
          setState(() {});
          _fetchGroupMember(false);
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
            text: 'Group Members',
            size: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: (val.isGroupMember == false)
                  ? Center(child: BigText(text: 'Members not found'))
                  : SingleChildScrollView(
                      // controller: _scrollController,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListView.separated(
                              separatorBuilder: (context, index) {
                                return const Divider(
                                  color: appBrownColor,
                                );
                              },
                              padding: _isLoadingMore ? EdgeInsets.zero : null,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: val.groupMember.length,
                              itemBuilder: (context, index) {
                                final member = val.groupMember[index];
                                {
                                  return Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: const BoxDecoration(
                                        color: subscriptionCardColor,
                                        // borderRadius: BorderRadius.circular(20.r)
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                              crossAxisAlignment: member.type ==
                                                      'Admin'
                                                  ? CrossAxisAlignment.center
                                                  : CrossAxisAlignment.start,
                                              children: [
                                                CustomImageWidget(
                                                  imageUrl: member
                                                      .member?.profilePhoto,
                                                  imageHeight: 50.w,
                                                  imageWidth: 50.w,
                                                  borderColor:
                                                      AppColors.greenColor,
                                                  borderWidth: 2.r,
                                                ),
                                                Flexible(
                                                    child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      BigText(
                                                        text: member.member
                                                                ?.displayname ??
                                                            "",
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: appBlackColor,
                                                        size: 16.sp,
                                                        maxLine: 1,
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      if (member.type !=
                                                          'Admin')
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                AddRemoveGroupMemberBloc()
                                                                    .addRemoveGroupMemberBlocMethod(
                                                                        context:
                                                                            context,
                                                                        setProgressBar:
                                                                            () {
                                                                          AppDialogs.progressAlertDialog(
                                                                              context: context);
                                                                        },
                                                                        groupId:
                                                                            widget
                                                                                .groupId,
                                                                        memmberId: member
                                                                            .member
                                                                            ?.id,
                                                                        type: member.status ==
                                                                                'pending'
                                                                            ? 'add_member'
                                                                            : 'delete_member');
                                                              },
                                                              child: Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        14,
                                                                    vertical:
                                                                        8),
                                                                margin: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        4),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      appBrownColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              57.r),
                                                                ),
                                                                child: BigText(
                                                                  text: member.status ==
                                                                          'pending'
                                                                      ? 'Accept Request'
                                                                      : 'Remove Member',
                                                                  color:
                                                                      appWhiteColor,
                                                                  size: 10.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                    ],
                                                  ),
                                                ))
                                              ])));
                                }
                              }

                              // _isLoadingMore
                              //     ? Padding(
                              //         padding:
                              //             EdgeInsets.only(bottom: .1.sh, top: 20.h),
                              //         child: const CircularProgressIndicator(
                              //           color: appLightGreenColor,
                              //           backgroundColor: appRedColor,
                              //         ),
                              //       )
                              //     : const SizedBox.shrink(),
                              )
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
