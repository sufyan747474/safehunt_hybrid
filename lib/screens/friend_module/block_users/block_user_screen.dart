import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_hunt/bloc/block_user/get_block_user_bloc.dart';
import 'package:safe_hunt/bloc/block_user/unblock_bloc.dart';
import 'package:safe_hunt/model/block_user_model.dart';
import 'package:safe_hunt/model/user_model.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/app_navigation.dart';
import 'package:safe_hunt/utils/colors.dart';
import 'package:safe_hunt/utils/common/app_colors.dart';
import 'package:safe_hunt/widgets/Custom_image_widget.dart';
import 'package:safe_hunt/widgets/big_text.dart';
import 'package:safe_hunt/widgets/custom_button.dart';

class BlockUserScreen extends StatefulWidget {
  final bool isLeadingIcon;

  const BlockUserScreen({super.key, this.isLeadingIcon = true});

  @override
  State<BlockUserScreen> createState() => _BlockUserScreenState();
}

class _BlockUserScreenState extends State<BlockUserScreen> {
  final ScrollController _scrollController = ScrollController();

  bool showComments = false;
  int _page = 1;

  bool _isLoadingMore = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _fetchBlockUser(true);
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
                _scrollController.position.maxScrollExtent &&
            _isLoadingMore == false) {
          _isLoadingMore = true;
          setState(() {});
          _fetchBlockUser(false);
        }
      });
    });
  }

  _fetchBlockUser(bool isLoader) {
    isData = null;
    blockUser = [];
    GetBlockUserBloc().getBlockUserBlocMethod(
      context: context,
      setProgressBar: () {
        AppDialogs.progressAlertDialog(context: context);
      },
      isLoader: isLoader,
      page: _page,
      onSuccess: (res) {
        _page++;
        _isLoadingMore = false;

        setState(() {});
        blockUser.addAll(res);
        if (blockUser.isEmpty) {
          isData = false;
        } else if (blockUser.isNotEmpty) {
          isData = true;
        }
        setState(() {});
      },
      onFailure: () {
        _isLoadingMore = false;
        setState(() {});
      },
    );
  }

  List<BlockUserModel> blockUser = [];

  bool? isData;

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
          text: 'Block Users',
          size: 16.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: Column(
          children: [
            Expanded(
              child: isData == false
                  ? Center(
                      child: Text(
                        'Block User Not Found',
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
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          friendsList(),
                          _isLoadingMore
                              ? const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: CircularProgressIndicator(
                                    color: appLightGreenColor,
                                    backgroundColor: appRedColor,
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      )),
            ),
          ],
        ),
      ),
    );
  }

  Widget friendsList() {
    return Column(
      children: [
        for (int i = 0; i < blockUser.length; i++)
          _buildBlockCard(blockUser[i].blocked ?? UserData(), () {
            UnblockUserBloc().unblockUserBlocMethod(
              context: context,
              setProgressBar: () {
                AppDialogs.progressAlertDialog(context: context);
              },
              id: blockUser[i].blocked?.id,
              onSuccess: () {
                blockUser.removeWhere((element) =>
                    element.blocked?.id == blockUser[i].blocked?.id);
                if (blockUser.isEmpty) {
                  isData = false;
                }
                setState(() {});
              },
            );
          }),
      ],
    );
  }

  Container _buildBlockCard(UserData user, void Function()? unBlockTap) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.r),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: AppColors.whiteColor.withOpacity(.5)),
      child: Row(
        children: [
          CustomImageWidget(
            imageWidth: 50.w,
            imageHeight: 50.w,
            borderColor: appBrownColor,
            borderWidth: 1.r,
            imageUrl: user.profilePhoto,
          ),
          10.horizontalSpace,
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(user.displayname ?? "",
                      style: TextStyle(
                          color: appBrownColor,
                          fontFamily: "",
                          overflow: TextOverflow.visible,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp)),
                ),
                // const Spacer(),
                IconButton(
                    onPressed: unBlockTap,

                    // moreFunction,
                    alignment: Alignment.centerRight,
                    icon: CustomButton(
                      text: 'Unblock', height: 30.w,
                      color: AppColors.greenColor,
                      textColor: AppColors.whiteColor,
                      // width: .3.sw,
                      // fontSize: 13.sp,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
