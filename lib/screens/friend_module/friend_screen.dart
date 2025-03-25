import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/bloc/block_user/block_user_bloc.dart';
import 'package:safe_hunt/bloc/friends/accept_reject_friend_request_bloc.dart';
import 'package:safe_hunt/bloc/friends/get_all_friends_bloc.dart';
import 'package:safe_hunt/bloc/friends/get_friend_request_bloc.dart';
import 'package:safe_hunt/bloc/friends/unfriend_bloc.dart';
import 'package:safe_hunt/model/friend_list_model.dart';
import 'package:safe_hunt/model/user_model.dart';
import 'package:safe_hunt/providers/user_provider.dart';
import 'package:safe_hunt/screens/friend_module/widget/custom_tab_item_widget.dart';
import 'package:safe_hunt/screens/friend_module/widget/custom_tab_widget.dart';
import 'package:safe_hunt/screens/friend_module/widget/friend_widget.dart';
import 'package:safe_hunt/screens/friend_module/widget/request_widget.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/app_navigation.dart';
import 'package:safe_hunt/utils/colors.dart';
import 'package:safe_hunt/widgets/big_text.dart';

class FriendScreen extends StatefulWidget {
  final bool isLeadingIcon;

  const FriendScreen({super.key, this.isLeadingIcon = true});

  @override
  State<FriendScreen> createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  final ScrollController _scrollController = ScrollController();
  int _page = 1;
  bool _isLoadingMore = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _fetchFriends(true, false);
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
                _scrollController.position.maxScrollExtent &&
            _isLoadingMore == false) {
          _isLoadingMore = true;
          setState(() {});
          _fetchFriends(false, false);
        }
      });
    });
  }

  _fetchFriends(bool isLoader, bool isChangeTab) {
    if (isChangeTab) {
      _page = 1;
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
        addOrReplaceFriendList(res);

        // frientList.addAll(res);

        // if (frientList.isEmpty) {
        //   isFriend = false;
        // } else if (frientList.isNotEmpty) {
        //   isFriend = true;
        // }

        _isLoadingMore = false;

        setState(() {});
      },
      onFailure: () {
        _isLoadingMore = false;
        setState(() {});
      },
    );
  }

  _fetchFriendRequests(bool isLoader, isChangeTab) {
    if (isChangeTab) {
      _page = 1;

      isFriend = null;
      requestList = [];
    }
    GetFriendRequestBloc().getFriendRequestBlocMethod(
      context: context,
      setProgressBar: () {
        AppDialogs.progressAlertDialog(context: context);
      },
      page: _page,
      isLoader: isLoader,
      onSuccess: (res) {
        _page++;
        addOrReplaceRequestList(res);
        // requestList.addAll(res);

        _isLoadingMore = false;
        // if (requestList.isEmpty) {
        //   isFriend = false;
        // } else if (requestList.isNotEmpty) {
        //   isFriend = true;
        // }
        // setState(() {});
      },
      onFailure: () {
        _isLoadingMore = false;
        setState(() {});
      },
    );
  }

  void _updateRequest({
    required String requesterId,
    required String status,
  }) {
    log("status : $status");
    log("requesterId : $requesterId");

    _page--;
    FriendRequestUpdateBloc().friendRequestUpdateBlocMethod(
        context: context,
        setProgressBar: () {
          AppDialogs.progressAlertDialog(context: context);
        },
        requesterId: requesterId,
        status: status,
        onSuccess: (res) {
          requestList
              .removeWhere((element) => element.requester?.id == requesterId);
          // selectedTab == 0
          //     ?
          _fetchFriendRequests(true, false);
          // : _fetchFriends(true, false);
        });
  }

  int selectedTab = 1;
  List<FriendModel> requestList = [];
  List<UserData> frientList = [];

  bool? isFriend;

//! request list
  void addOrReplaceRequestList(List<FriendModel> newRequests) {
    // Create a map for quick lookup of existing items by ID
    Map<String, FriendModel> requestMap = {
      for (var item in requestList) item.id!: item
    };

    // Iterate through the new list and update or insert items
    for (var newRequest in newRequests) {
      requestMap[newRequest.id!] = newRequest; // Replace if exists, add if new
    }

    // Update requestList with the updated values
    requestList = requestMap.values.toList();
    if (requestList.isEmpty) {
      isFriend = false;
    } else if (requestList.isNotEmpty) {
      isFriend = true;
    }
    setState(() {});
  }

//! friend list

  void addOrReplaceFriendList(List<UserData> newFriends) {
    // Create a map for quick lookup of existing items by ID
    Map<String, UserData> requestMap = {
      for (var item in frientList) item.id!: item
    };

    // Iterate through the new list and update or insert items
    for (var newRequest in newFriends) {
      requestMap[newRequest.id!] = newRequest; // Replace if exists, add if new
    }

    // Update friendList with the updated values
    frientList = requestMap.values.toList();
    if (frientList.isEmpty) {
      isFriend = false;
    } else if (frientList.isNotEmpty) {
      isFriend = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appButtonColor,
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
          text: 'Friends',
          size: 16.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: Column(
          children: [
            CustomTabWidget<int>(
                selectedValue: selectedTab,
                tabs: const [
                  CustomTabItemWidget<int>(value: 0, title: "Request"),
                  CustomTabItemWidget<int>(value: 1, title: "Your Friends"),
                ],
                onChange: (val) {
                  if (val != null) {
                    selectedTab = val;
                    val == 1
                        ? _fetchFriends(true, true)
                        : _fetchFriendRequests(true, true);
                    setState(() {});
                  }
                }),
            15.verticalSpace,
            Expanded(
              child: isFriend == false
                  ? Center(
                      child: Text(
                        '${selectedTab == 0 ? 'Request' : 'Friend'} Not Found',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "",
                            height: 1.2.sp,
                            fontSize: 16.sp,
                            overflow: TextOverflow.visible),
                      ),
                    )
                  : SingleChildScrollView(
                      controller: _scrollController,
                      child: getBody(selectedTab)),
            ),
            _isLoadingMore
                ? const Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(
                        color: appLightGreenColor,
                        backgroundColor: appRedColor,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Widget getBody(int i) {
    switch (i) {
      case 0:
        return requestsList();
      case 1:
        return friendsList();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget friendsList() {
    return Column(
      children: [
        for (int i = 0; i < frientList.length; i++)
          FriendWidget(
            friendData: frientList[i],
            blockFriend: () {
              BlockUserBloc().blockUserBlocMethod(
                  context: context,
                  setProgressBar: () {
                    AppDialogs.progressAlertDialog(context: context);
                  },
                  userId: frientList[i].id,
                  onSuccess: () {
                    _page--;
                    AppNavigation.pop();
                    _fetchFriends(true, false);
                  });
            },
            unFriend: () {
              UnfriendBloc().unfriendBlocMethod(
                setProgressBar: () {
                  AppDialogs.progressAlertDialog(context: context);
                },
                context: context,
                userId: frientList[i].id ?? '',
                onSuccess: () {
                  _page--;
                  AppNavigation.pop();
                  frientList
                      .removeWhere((element) => element.id == frientList[i].id);
                  _fetchFriends(true, false);
                },
              );
            },
          )
      ],
    );
  }

  Widget requestsList() {
    return Column(
      children: [
        for (int i = 0; i < requestList.length; i++)
          RequestWidget(
            friendData: requestList[i].requester,
            confirm: () {
              _updateRequest(
                  requesterId: requestList[i].requester?.id ?? "",
                  status: 'accepted');
            },
            delete: () {
              _updateRequest(
                  requesterId: requestList[i].requester?.id ?? "",
                  status: 'declined');
            },
          )
      ],
    );
  }
}
