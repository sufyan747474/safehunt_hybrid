import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/bloc/friends/get_all_friends_bloc.dart';
import 'package:safe_hunt/model/user_model.dart';
import 'package:safe_hunt/providers/post_provider.dart';
import 'package:safe_hunt/providers/user_provider.dart';
import 'package:safe_hunt/screens/create_group_chat/bloc/get_all_group_bloc.dart';
import 'package:safe_hunt/screens/create_group_chat/bloc/get_group_details_bloc.dart';
import 'package:safe_hunt/screens/create_group_chat/view/add_group_info_screen.dart';
import 'package:safe_hunt/screens/create_group_chat/view/view_group_chat_screen.dart';
import 'package:safe_hunt/screens/chats/user_chat_screen.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/app_navigation.dart';
import '../../../utils/colors.dart';
import '../../../widgets/big_text.dart';
import '../../../widgets/chats_card.dart';

class ChatsScreen extends StatefulWidget {
  final bool isLeadingIcon;

  const ChatsScreen({super.key, this.isLeadingIcon = true});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final ScrollController _scrollController = ScrollController();
  int _page = 1;
  bool _isLoadingMore = false;
  bool? isFriend;

  List<UserData> frientList = [];
  _fetchFriends(bool isLoader, bool isChangeTab) {
    if (isChangeTab) {
      isFriend = null;
      frientList = [];
    }
    GetAllFriendsBloc().getAllFriendsBlocMethod(
      context: context,
      setProgressBar: () {
        AppDialogs.progressAlertDialog(context: context);
      },
      isLoader: isLoader,
      page: _page,
      userId: context.read<UserProvider>().user?.id ?? '',
      onSuccess: (res) {
        _page++;

        frientList.addAll(res);

        if (frientList.isEmpty) {
          isFriend = false;
        } else if (frientList.isNotEmpty) {
          isFriend = true;
        }

        _isLoadingMore = false;

        setState(() {});
      },
      onFailure: () {
        _isLoadingMore = false;
        setState(() {});
      },
    );
  }

  _fetchGroup() {
    GetGroupBloc().getGroupBlocMethod(
      context: context,
      setProgressBar: () {
        AppDialogs.progressAlertDialog(context: context);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
                _scrollController.position.maxScrollExtent &&
            _isLoadingMore == false) {
          if (selectedTab == 1) {
            _isLoadingMore = true;
            setState(() {});
            _fetchFriends(false, false);
          }
        }
      });
    });
  }

  int selectedTab = 0; // 0 - Recent Chats, 1 - People, 2 - Message Requests

  @override
  Widget build(BuildContext context) {
    return Consumer2<PostProvider, UserProvider>(
        builder: (context, val, user, _) {
      return Scaffold(
        backgroundColor: Colors.transparent,
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
            text: 'Message',
            size: 16.sp,
            fontWeight: FontWeight.w700,
          ),
          actions: selectedTab != 2
              ? null
              : [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      onTap: () {
                        AppNavigation.push(const AddGroupInFoScreen());
                      },
                      child: Container(
                          width: 60.w,
                          height: 30.h,
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: subscriptionCardColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.r)),
                          ),
                          child: const Icon(Icons.group_add)),
                    ),
                  ),
                ],
        ),
        body: Column(
          children: [
            Container(
              color: subscriptionCardColor,
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTabButton(
                      0, 'Recent Chats', appBrownColor, appWhiteColor),
                  _buildTabButton(1, 'People', appBrownColor, appWhiteColor),
                  _buildTabButton(2, 'Group', appBrownColor, appWhiteColor),
                ],
              ),
            ),
            Expanded(
              child: (selectedTab == 2 && val.isGroup == false)
                  ? Center(child: BigText(text: 'Groups not found'))
                  : SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListView.separated(
                            separatorBuilder: (context, index) {
                              return const Divider(
                                color: appButtonColor,
                              );
                            },
                            padding: _isLoadingMore ? EdgeInsets.zero : null,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: selectedTab == 1
                                ? frientList.length
                                : selectedTab == 2
                                    ? val.group.length
                                    : 10,
                            itemBuilder: (context, index) {
                              final data =
                                  selectedTab == 2 ? val.group[index] : null;
                              if (selectedTab == 0) {
                                return _buildChatItem(
                                  'Henry',
                                  'Please take a look at the images.',
                                  '20.00',
                                  onTap: () {
                                    // Get.to(() => const UserChat(
                                    //     receiverName: '',
                                    //     receiverId:
                                    //         'User Chat ID')); // Replace with actual ID
                                  },
                                );
                              } else if (selectedTab == 1) {
                                final people = frientList[index];
                                return _buildChatItem(
                                    people.displayname ?? '', "", "");
                              } else {
                                return _buildChatItem(
                                  groupId: data?.id,
                                  status: data?.adminInfo?.member?.id !=
                                          user.user?.id
                                      ? data?.status
                                      : null,
                                  isGroup: true,
                                  data?.name ?? "",
                                  data?.description ?? '',
                                  '',
                                  image: data?.logo,
                                  onTap: () {
                                    if (data?.status == 'Joined') {
                                      GetGroupDetailsBloc()
                                          .getGroupDetailsBlocMethod(
                                              context: context,
                                              setProgressBar: () {
                                                AppDialogs.progressAlertDialog(
                                                    context: context);
                                              },
                                              groupId: data?.id,
                                              onSuccess: (res) {
                                                AppNavigation.push(
                                                    const ViewGroupChatScreen());
                                              });
                                    }
                                  },
                                );
                              }
                            },
                          ),
                          _isLoadingMore
                              ? Padding(
                                  padding:
                                      EdgeInsets.only(bottom: .1.sh, top: 20.h),
                                  child: const CircularProgressIndicator(
                                    color: appLightGreenColor,
                                    backgroundColor: appRedColor,
                                  ),
                                )
                              : const SizedBox.shrink(),
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
        onTap: selectedTab != index
            ? () {
                context.read<PostProvider>().emptyGroup();
                setState(() {
                  selectedTab = index;
                  if (selectedTab == 2) {
                    _fetchGroup();
                  }
                });
              }
            : null,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: selectedTab == index ? bgColor : appButtonColor,
            borderRadius: BorderRadius.circular(57.r),
          ),
          child: BigText(
            text: text,
            color: selectedTab != index ? appBrownColor : textColor,
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


// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:safe_hunt/screens/drawer/user_chat_screen.dart';
// import 'package:safe_hunt/utils/app_navigation.dart';
// import '../../../utils/colors.dart';
// import '../../../widgets/big_text.dart';
// import '../../../widgets/chats_card.dart';

// class ChatsScreen extends StatefulWidget {
//   final bool isLeadingIcon;

//   const ChatsScreen({super.key, this.isLeadingIcon = true});

//   @override
//   State<ChatsScreen> createState() => _ChatsScreenState();
// }

// class _ChatsScreenState extends State<ChatsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       appBar: AppBar(
//         bottomOpacity: 0.0,
//         scrolledUnderElevation: 0,
//         elevation: 0,
//         backgroundColor: appButtonColor,
//         leading: widget.isLeadingIcon
//             ? Padding(
//                 padding: EdgeInsets.all(8.0.w),
//                 child: Transform.translate(
//                     offset: Offset(1.w, 0),
//                     child: GestureDetector(
//                         onTap: () {
//                           AppNavigation.pop();
//                         },
//                         child: Icon(
//                           Icons.arrow_back_ios,
//                           size: 23.sp,
//                           color: Colors.black,
//                         ))),
//               )
//             : null,
//         titleSpacing: widget.isLeadingIcon ? -10 : null,
//         title: BigText(
//           text: 'Message',
//           size: 16.sp,
//           fontWeight: FontWeight.w700,
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Container(
//               width: 60.w,
//               height: 30.h,
//               padding: const EdgeInsets.all(3),
//               decoration: BoxDecoration(
//                 color: subscriptionCardColor,
//                 borderRadius: BorderRadius.all(Radius.circular(15.r)),
//               ),
//               child: SvgPicture.asset(
//                 'assets/search_icon.svg',
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               color: subscriptionCardColor,
//               padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Container(
//                       width: 117.w,
//                       alignment: Alignment.center,
//                       padding: const EdgeInsets.all(12.0),
//                       decoration: BoxDecoration(
//                           color: appButtonColor,
//                           borderRadius: BorderRadius.circular(57.r)),
//                       child: BigText(
//                         text: 'Recent Chats',
//                         color: appBrownColor,
//                         size: 10.sp,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 10.h,
//                   ),
//                   Expanded(
//                     child: Container(
//                       // width: 117.w,
//                       alignment: Alignment.center,
//                       padding: const EdgeInsets.all(10.0),
//                       decoration: BoxDecoration(
//                           color: appBrownColor,
//                           borderRadius: BorderRadius.circular(57.r)),
//                       child: BigText(
//                         text: 'People',
//                         color: appWhiteColor,
//                         size: 10.sp,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 10.h,
//                   ),
//                   Expanded(
//                     child: Container(
//                       alignment: Alignment.center,
//                       padding: const EdgeInsets.all(10.0),
//                       decoration: BoxDecoration(
//                           color: appBrownColor,
//                           borderRadius: BorderRadius.circular(57.r)),
//                       child: BigText(
//                         text: 'Message Request',
//                         color: appWhiteColor,
//                         size: 10.sp,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             ListView.builder(
//               physics: const NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: 10,
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     Get.to(() => const UserChat(
//                           id: 'WATASHIVA NAI SHINDARUUU !!!! NANIIII!!!!!',
//                         ));
//                   },
//                   child: const ChatsCard(
//                     name: 'Henry',
//                     message: 'Please take a look at the images.',
//                     time: '20.00',
//                     image: 'assets/profile_picture.png',
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
