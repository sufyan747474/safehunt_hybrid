import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/providers/post_provider.dart';
import 'package:safe_hunt/screens/create_group_chat/bloc/create_group_chat_bloc.dart';
import 'package:safe_hunt/screens/create_group_chat/model/group_model.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/app_navigation.dart';
import 'package:safe_hunt/utils/colors.dart';
import 'package:safe_hunt/utils/common/app_colors.dart';
import 'package:safe_hunt/utils/common/asset_path.dart';
import 'package:safe_hunt/utils/utils.dart';
import 'package:safe_hunt/utils/validators.dart';
import 'package:safe_hunt/widgets/Custom_image_widget.dart';
import 'package:safe_hunt/widgets/app_text_field.dart';
import 'package:safe_hunt/widgets/big_text.dart';
import 'package:safe_hunt/widgets/custom_button.dart';

class AddGroupInFoScreen extends StatefulWidget {
  final bool isEdit;
  final GroupModel? group;

  const AddGroupInFoScreen({super.key, this.isEdit = false, this.group});

  @override
  State<AddGroupInFoScreen> createState() => _AddGroupInFoScreenState();
}

class _AddGroupInFoScreenState extends State<AddGroupInFoScreen> {
  late final TextEditingController groupNameController;
  late final TextEditingController groupDescController;

  final GlobalKey<FormState> _formKey = GlobalKey();

  String? _selectedGroupImage;
  String? _selectedGroupLogo;

  PostProvider? members;
  // ChatProvider? chatProvider;

  dynamic listSelectedMember = [];

  // <---------- get all group member api method ---------------->

  Future<void> getAllGroupmemberApiMethod() async {
    // await GetAllGroupMemberBloc().getAllGroupMemberMethod(
    //   context: context,
    //   setProgressBar: () {
    //     Utils.progressLoader(context: context);
    //   },
    //   groupId: widget.groupId!,
    // );
  }

// <------- create group chat api method --------------->

  createGroupChatApiMethod() {
    CreateGroupBloc().createGroupBlocMethod(
      context: context,
      setProgressBar: () {
        AppDialogs.progressAlertDialog(context: context);
      },
      name: groupNameController.text,
      description: groupDescController.text,
      groupImage: _selectedGroupImage,
      groupLogo: _selectedGroupLogo,
      isUpdate: widget.isEdit,
      groupId: widget.group?.id,
    );
  }

  @override
  void initState() {
    groupNameController = TextEditingController();
    groupDescController = TextEditingController();

    members = Provider.of<PostProvider>(context, listen: false);
    // chatProvider = Provider.of<ChatProvider>(context, listen: false);

    if (widget.isEdit) {
      members?.emptySelectedTagPeople(isNotifyListner: false);
      // chatProvider?.emptyGroupMemberList(notifyListner: false);
      groupNameController.text = widget.group?.name ?? "";
      groupDescController.text = widget.group?.description ?? "";

      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) async {
          //   await getAllGroupmemberApiMethod().then(
          //     (value) async {
          //       for (int i = 0; i < chatProvider!.groupMemberList.length; i++) {
          //         listSelectedMember.add(chatProvider!.groupMemberList[i]);
          //         members?.setTagPeopleId(
          //             id: chatProvider!.groupMemberList[i].id!);
          //         log(listSelectedMember.length.toString());
          //       }
          //     },
          //   );
        },
      );
    } else {
      for (int i = 0; i < members!.getTagPeople.length; i++) {
        if (members!.selectedTagPeople.contains(members!.getTagPeople[i].id)) {
          listSelectedMember.add(members!.getTagPeople[i]);
          print(listSelectedMember.length);
        }
      }
    }

    super.initState();
  }

  @override
  void dispose() {
    groupNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostProvider>(builder: (context, tagPeople, _) {
      return Scaffold(
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
            text: widget.isEdit ? 'Update Group' : 'Create Group',
            size: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
            child: CustomButton(
              textColor: AppColors.whiteColor,
              color: appBrownColor,
              text: widget.isEdit ? 'Update' : 'Create Group',
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState?.save();
                  if (_selectedGroupImage == null && widget.isEdit == false) {
                    AppDialogs.showToast(
                      message: 'Group Image is Required',
                    );
                  } else if (_selectedGroupLogo == null &&
                      widget.isEdit == false) {
                    AppDialogs.showToast(
                      message: 'Group Logo is Required',
                    );
                  } else {
                    Utils.unFocusKeyboard(context).then(
                      (value) {
                        createGroupChatApiMethod();
                      },
                    );
                  }
                }
              },
            )),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: BigText(
                      textAlign: TextAlign.start,
                      text: 'Enter Group Name',
                      size: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  15.verticalSpace,
                  AppTextField(
                    hintText: 'Group Name',
                    textController: groupNameController,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(35),
                      FilteringTextInputFormatter.deny(RegExp(r'^\s')),
                    ],
                    validator: (value) {
                      return CommonFieldValidators.validateEmptyOrNull(
                          label: 'Group Name', value: value);
                    },
                  ),
                  15.verticalSpace,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: BigText(
                      textAlign: TextAlign.start,
                      text: 'Enter Group Description',
                      size: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  15.verticalSpace,
                  AppTextField(
                    hintText: 'Description',
                    textController: groupDescController,
                    maxLines: 5,
                    minLines: 5,
                    inputFormatters: [LengthLimitingTextInputFormatter(375)],
                    validator: (value) {
                      return CommonFieldValidators.validateEmptyOrNull(
                        label: 'Description',
                        value: value,
                      );
                    },
                    verticalPadding: 10.w,
                    borderRdius: 8.r,
                  ),
                  40.verticalSpace,
                  (_selectedGroupImage == null && !widget.isEdit)
                      ? InkWell(
                          onTap: () {
                            Utils.unFocusKeyboard(context);
                            Utils.showImageSourceSheet(
                              context: context,
                              setFile: (image) async {
                                log('Image.path: ${image.path}');

                                _selectedGroupImage = image.path;
                                setState(() {});
                              },
                            );
                          },
                          child: _buildDotedBorderContainer(
                              text: 'Upload Group Image'),
                        )
                      : _buildGroupImageConatiner(
                          context,
                          (image) async {
                            _selectedGroupImage = image.path;
                            setState(() {});
                          },
                          _selectedGroupImage != null
                              ? File(_selectedGroupImage!)
                              : null,
                          widget.group?.cover,
                          'Change Group Image',
                        ),
                  40.verticalSpace,
                  (_selectedGroupLogo == null && !widget.isEdit)
                      ? InkWell(
                          onTap: () {
                            Utils.unFocusKeyboard(context);
                            Utils.showImageSourceSheet(
                              context: context,
                              setFile: (image) async {
                                _selectedGroupLogo = image.path;
                                setState(() {});
                              },
                            );
                          },
                          child: _buildDotedBorderContainer(
                              text: 'Upload Group logo'),
                        )
                      : _buildGroupImageConatiner(
                          context,
                          (image) async {
                            _selectedGroupLogo = image.path;
                            setState(() {});
                          },
                          _selectedGroupLogo != null
                              ? File(_selectedGroupLogo!)
                              : null,
                          widget.group?.logo,
                          'Change Group Logo',
                        )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  DottedBorder _buildDotedBorderContainer({required String text}) {
    return DottedBorder(
      color: appBrownColor,
      radius: const Radius.circular(10),
      borderType: BorderType.RRect,
      strokeWidth: 2.w,
      dashPattern: const [10, 10],
      child: SizedBox(
        width: 1.sw,
        height: 200.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.file_upload_outlined, color: appBrownColor),
            10.verticalSpace,
            BigText(
              text: text,
              // color: AppColors.themeColor[currentColorType]!,
              size: 14.sp,
              fontWeight: FontWeight.w500,
            )
          ],
        ),
      ),
    );
  }

  Stack _buildGroupImageConatiner(BuildContext context, Function(File)? setFile,
      File? pickedImage, String? imageUrl, String text) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        CustomImageWidget(
          imageUrl: imageUrl,
          pickedImage: pickedImage,
          imageAssets: AppAssets.postImagePlaceHolder,
          imageWidth: 1.sw,
          imageHeight: 200.h,
          borderRadius: BorderRadius.circular(10.r),
          borderWidth: 0,
        ),
        Positioned(
          bottom: -20,
          child: CustomButton(
            height: 40.h,
            color: AppColors.greenColor,
            textColor: AppColors.whiteColor,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            // : 200,
            // fontSize: 14.sp,
            // iconHeight: 18.h,
            // iconWidth: 18.h,
            fontWeight: FontWeight.w600,
            text: text,
            // icon: AppAssets.uploadIcon,
            // textColor: AppColors.themeColor[currentColorType]!,
            // iconColor: AppColors.themeColor[currentColorType]!,
            // buttonSimpleColor: AppColors.whiteColor,
            onTap: () {
              Utils.unFocusKeyboard(context);

              Utils.showImageSourceSheet(
                context: context,
                setFile: setFile,
              );
            },
          ),
        )
      ],
    );
  }

  Column _buildMemberCard(
      {bool isEdit = false,
      String? image,
      String? title,
      void Function()? onTap}) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            Visibility(
              visible: isEdit,
              child: Image.asset(
                AppAssets.user3,
                width: 60.w,
                height: 60.w,
              ),
            ),
            Visibility(
              visible: !isEdit,
              child: CustomImageWidget(
                imageUrl: image,
                imageWidth: 60.w,
                imageHeight: 60.w,
                borderWidth: 3.w,
              ),
            ),
            Visibility(
              visible: !isEdit,
              child: InkWell(
                onTap: onTap,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(5),
                  width: 21.w,
                  height: 21.w,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.w, color: AppColors.whiteColor),
                    color: AppColors.lightRedColor,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    AppAssets.closeIcon,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            )
          ],
        ),
        5.verticalSpace,
        BigText(
          text: title ?? "",
          size: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}
