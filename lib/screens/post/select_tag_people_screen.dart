import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/bloc/friends/get_all_friends_bloc.dart';
import 'package:safe_hunt/model/user_model.dart';
import 'package:safe_hunt/providers/post_provider.dart';
import 'package:safe_hunt/providers/user_provider.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/app_navigation.dart';
import 'package:safe_hunt/utils/colors.dart';
import 'package:safe_hunt/utils/common/app_colors.dart';
import 'package:safe_hunt/widgets/Custom_image_widget.dart';
import 'package:safe_hunt/widgets/big_text.dart';
import 'package:safe_hunt/widgets/custom_button.dart';

class SelectTagPeople extends StatefulWidget {
  const SelectTagPeople({super.key, this.isEditPost = false, this.usertaglist});
  final bool isEditPost;
  final List<String>? usertaglist;

  @override
  State<SelectTagPeople> createState() => _AddPostState();
}

class _AddPostState extends State<SelectTagPeople> {
  PostProvider? tagPeople;
  late List<bool> selectedItems;

  @override
  void initState() {
    tagPeople = Provider.of<PostProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        GetAllFriendsBloc().getAllFriendsBlocMethod(
            context: context,
            setProgressBar: () {
              AppDialogs.progressAlertDialog(context: context);
            },
            userId: context.read<UserProvider>().user?.id ?? '0',
            onFailure: () {},
            onSuccess: (friends) {
              tagPeople?.setTagPeople(friends);
              selectedItems =
                  List.filled(tagPeople!.getTagPeople.length, false);
              // yaha par my tag user ko provider my set kr rha hu, jo pale sy tag hy

              if (widget.isEditPost && widget.usertaglist != null) {
                log('ye chlaa 1');
                for (var tagPeopleId in widget.usertaglist!) {
                  tagPeople?.setTagPeopleId(id: tagPeopleId);
                }

                for (int i = 0; i < tagPeople!.getTagPeople.length; i++) {
                  log('ye chlaa 2');

                  if (tagPeople!.selectedTagPeople
                      .contains(tagPeople!.getTagPeople[i].id)) {
                    selectedItems[i] = true;
                    tagPeople?.addTagPeopleList(tagPeople!.getTagPeople[i]);
                  }
                }
              } else {
                for (int i = 0; i < tagPeople!.getTagPeople.length; i++) {
                  log('ye chlaa 2');

                  if (tagPeople!.selectedTagPeople
                      .contains(tagPeople!.getTagPeople[i].id)) {
                    selectedItems[i] = true;
                    tagPeople?.addTagPeopleList(tagPeople!.getTagPeople[i]);
                  }
                }
              }
            });
      },
    );

    // Initialize selectedItems based on the provider's selectedTagPeople list
    selectedItems = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostProvider>(builder: (context, val, _) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: appButtonColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.close)),
          title: BigText(
            text: 'Select Tag People',
            size: 16.sp,
            fontWeight: FontWeight.w700,
          ),
          centerTitle: true,
          elevation: 0,
          // actions: [
          //   IconButton(
          //     padding: const EdgeInsets.all(14.0),
          //     onPressed: () {},
          //     icon: BigText(
          //       text: 'Done',
          //       size: 16.sp,
          //       fontWeight: FontWeight.w500,
          //     ),
          //   ),
          // ],
        ),
        body: Column(
          children: [
            15.verticalSpace,
            val.hasTagPeople == false
                ? Expanded(
                    child: Center(
                      child: BigText(
                        text: 'Tag User Not Found',
                        textAlign: TextAlign.center,
                        size: 18.sp,
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: val.getTagPeople.length,
                        separatorBuilder: (context, index) {
                          return Divider(
                            thickness: 1.w,
                            color: AppColors.dividerColor,
                            height: 20.h,
                          );
                        },
                        itemBuilder: (context, index) {
                          final tagPeoples = val.getTagPeople;
                          // val.getTagPeople[index];
                          return selectedItems.isEmpty
                              ? const SizedBox.shrink()
                              : _buildTagPeopleRow(index, tagPeoples[index]);
                        }),
                  ),
            15.verticalSpace,
            InkWell(
              onTap: () {
                if (selectedItems.contains(true)) {
                  AppNavigation.pop();
                } else {
                  AppDialogs.showToast(message: 'Please select member.');
                }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: CustomButton(
                  text: 'Done',
                  fontWeight: FontWeight.w600,
                  color: AppColors.greenColor,
                  textColor: AppColors.whiteColor,
                ),
              ),
            ),
            20.verticalSpace,
          ],
        ),
      );
    });
  }

  _buildTagPeopleRow(int index, UserData val) {
    return Consumer<PostProvider>(builder: (context, tag, _) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: BuildRowWidget(
          image: val.profilePhoto,
          name: val.displayname,
          onTap: () {
            if (selectedItems[index] == true) {
              selectedItems[index] = false;
              tag.removeTagPeopleId(val.id!);
              // tag.removeTagPeopleList(val);
            } else {
              selectedItems[index] = true;
              tag.setTagPeopleId(id: val.id!);
              tag.addTagPeopleList(val);
            }
            setState(() {});
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            width: 30.w,
            height: 30.w,
            decoration: BoxDecoration(
              border: Border.all(width: 1.w, color: AppColors.greenColor),
              color: selectedItems[index]
                  ? AppColors.greenColor
                  : AppColors.transparentColor,
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              'assets/check_icon.png',
              width: 24.w,
              height: 24.h,
              color: selectedItems[index]
                  ? AppColors.whiteColor
                  : AppColors.transparentColor,
            ),
          ),
        ),
      );
    });
  }
}

class BuildRowWidget extends StatelessWidget {
  const BuildRowWidget(
      {super.key, this.child, this.onTap, this.image, this.name});
  final void Function()? onTap;
  final Widget? child;
  final String? image;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 0,
          child: CustomImageWidget(
            canSelectImage: false,
            imageUrl: image,
            isBorder: true,
            imageWidth: 40.w,
            imageHeight: 40.w,
            borderWidth: 3.w,
          ),
        ),
        10.horizontalSpace,
        Expanded(
          child: BigText(
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            text: name ?? "",
            size: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.blackColor,
          ),
        ),
        15.horizontalSpace,
        Expanded(
          flex: 0,
          child: InkWell(onTap: onTap, child: child),
        ),
      ],
    );
  }
}
