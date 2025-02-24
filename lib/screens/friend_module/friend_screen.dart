import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe_hunt/screens/friend_module/widget/custom_tab_item_widget.dart';
import 'package:safe_hunt/screens/friend_module/widget/custom_tab_widget.dart';
import 'package:safe_hunt/screens/friend_module/widget/friend_widget.dart';
import 'package:safe_hunt/screens/friend_module/widget/request_widget.dart';
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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // _friendMethod(friendList: 1);
    });
  }

  // void _friendMethod({int friendList = 0, int friendRequest = 0}) {
  //   frientList = [];
  //   isFriend = null;
  // GetAllFriendBloc().getAllFriendBlocMethod(
  //   context: context,
  //   setProgressBar: () {
  //     AppDialogs.progressAlertDialog(context: context);
  //   },
  //   friendList: friendList,
  //   friendRequest: friendRequest,
  //   onSuccess: (res) {
  //     if (res.isEmpty) {
  //       isFriend = false;
  //     } else if (res.isNotEmpty) {
  //       isFriend = true;
  //       frientList = res;
  //     }
  //     setState(() {});
  //   },
  // );
  // }

  // void _updateRequest(
  //     {required String friendId,
  //     required String status,
  //     bool isUnFriendBlock = false}) {
  //   frientList = [];
  //   isFriend = null;
  //   UpdateFriendRequestBloc().updateFriendRequestBlocMethod(
  //     context: context,
  //     setProgressBar: () {
  //       AppDialogs.progressAlertDialog(context: context);
  //     },
  //     friendId: friendId,
  //     status: status,
  //     onSuccess: (res) {
  //       if (isUnFriendBlock) {
  //         AppNavigation.navigatorPop();
  //       }
  //       _friendMethod(friendList: 0, friendRequest: 1);
  //     },
  //   );
  // }

  int selectedTab = 1;
  // List<FriendList>

  dynamic frientList = [];
  bool? isFriend;

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
                    // _friendMethod(
                    //     friendRequest: val == 0 ? 1 : 0,
                    //     friendList: val == 1 ? 1 : 0);
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
                  : SingleChildScrollView(child: getBody(selectedTab)),
            ),
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
              // _updateRequest(
              //   friendId: frientList[i].id ?? "",
              //   status: 'block',
              //   isUnFriendBlock: true,
              // );
            },
            unFriend: () {
              // _updateRequest(
              //   isUnFriendBlock: true,
              //   friendId: frientList[i].id ?? "",
              //   status: 'decline',
              // );
            },
          )
      ],
    );
  }

  Widget requestsList() {
    return Column(
      children: [
        for (int i = 0; i < frientList.length; i++)
          RequestWidget(
            friendData: frientList[i],
            confirm: () {
              // _updateRequest(
              //     friendId: frientList[i].id ?? "", status: 'accepted');
            },
            delete: () {
              // _updateRequest(
              //     friendId: frientList[i].id ?? "", status: 'decline');
            },
          )
      ],
    );
  }
}
