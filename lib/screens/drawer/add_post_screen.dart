import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/bloc/post/add_post_bloc.dart';
import 'package:safe_hunt/providers/post_provider.dart';
import 'package:safe_hunt/providers/user_provider.dart';
import 'package:safe_hunt/screens/journals/model/location_model.dart';
import 'package:safe_hunt/screens/post/select_tag_people_screen.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/app_navigation.dart';
import 'package:safe_hunt/utils/colors.dart';
import 'package:safe_hunt/utils/common/app_colors.dart';
import 'package:safe_hunt/utils/utils.dart';
import 'package:safe_hunt/widgets/big_text.dart';
import 'package:safe_hunt/widgets/custom_container.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final TextEditingController _messageTextController = TextEditingController();

  String? postImage;
  LocationModel? location;

  @override
  void initState() {
    // Call getLatLong and update state
    Utils.getLatLong().then((result) {
      if (!mounted) return; // ✅ Prevent setState if widget is disposed
      setState(() {
        location = result.$1;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProvider, PostProvider>(
        builder: (context, val, postData, _) {
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
            text: 'Create a Post',
            size: 16.sp,
            fontWeight: FontWeight.w700,
          ),
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
              padding: const EdgeInsets.all(14.0),
              onPressed: () {
                Utils.unFocusKeyboard(context);

                if (_messageTextController.text.isEmpty) {
                  AppDialogs.showToast(message: 'Description is required');
                } else {
                  AddPostBloc().addPostBlocMethod(
                    context: context,
                    setProgressBar: () {
                      AppDialogs.progressAlertDialog(context: context);
                    },
                    description: _messageTextController.text,
                    location: location,
                    media: postImage,
                    tagList: ["awdaw", "awdwad"],
                  );
                }
              },
              icon: BigText(
                text: 'Post',
                size: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
          color: subscriptionCardColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 50.w,
                    width: 50.w,
                    padding: EdgeInsets.all(10.r),
                    decoration: const BoxDecoration(
                        color: appBrownColor, shape: BoxShape.circle),
                    child: BigText(
                      text: val.user?.username?.isNotEmpty ?? false
                          ? val.user!.username![0].toUpperCase()
                          : '',
                      size: 22.sp,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  BigText(
                    text: val.user?.username ?? '',
                    size: 16.sp,
                    color: appBlackColor,
                    fontWeight: FontWeight.w700,
                  )
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              SingleChildScrollView(
                child: SizedBox(
                  height: 340,
                  child: TextField(
                    textInputAction: TextInputAction.done,
                    maxLines: 20,
                    minLines: 20,
                    style: GoogleFonts.montserrat(),
                    controller: _messageTextController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      labelStyle: GoogleFonts.montserrat(
                          color: appBrownColor,
                          fontSize: MediaQuery.of(context).size.height / 42.2),
                      hintText: 'What are you thinking about?',
                      contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
                      hintStyle: TextStyle(
                        color: appBrownColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),

                      // filled: true,
                      // fillColor: Colors.red,
                    ),
                  ),
                ),
              )
              // AppTextFieldTwo(
              //
              //   minLines: 10,
              //   maxLines: 20,
              //   height: 200,
              //   textController: _messageTextController,
              //   hintText: 'What are you thinking about?',
              // )
              // BigText(
              //   text: 'What are you thinking about?',
              //   size: 14.sp,
              //   fontWeight: FontWeight.w400,
              //   color: appBrownColor,
              // )
            ],
          ),
        ),
        bottomSheet: Container(
            height: MediaQuery.of(context).size.height * 0.37,
            padding: EdgeInsets.all(15.w),
            decoration: BoxDecoration(
              color: appButtonColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 5.w,
                      width: 32.h,
                      decoration: BoxDecoration(
                        color: appBrownColor,
                        borderRadius: BorderRadius.all(Radius.circular(30.r)),
                        // border: Border.all(width: 1, ),
                      ),
                    ),
                  ),
                  10.verticalSpace,
                  Row(
                    children: [
                      SvgPicture.asset('assets/gallery.svg'),
                      SizedBox(
                        width: 15.w,
                      ),
                      BigText(
                        text: 'Media',
                        size: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: appBrownColor,
                      )
                    ],
                  ),
                  10.verticalSpace,
                  // upload cover photo
                  CustomContainer(
                    decortionImage: postImage != null
                        ? DecorationImage(
                            image: FileImage(File(postImage!)),
                            fit: BoxFit.cover)
                        : null,
                    width: 1.sw,
                    height: 145.h,
                    borderRadius: BorderRadius.circular(5.r),
                    conatinerColor: AppColors.greenColor.withOpacity(0.4),
                    shape: BoxShape.rectangle,
                    iconData: Icons.file_upload_outlined,
                    iconWidth: 30.w,
                    iconColor: AppColors.greenColor,
                    text: "Upload Photo",
                    fontColor: AppColors.greenColor,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    onTap: () {
                      Utils.unFocusKeyboard(context);
                      Utils.showImageSourceSheet(
                        context: context,
                        setFile: (file) {
                          postImage = file.path;
                          setState(() {});
                        },
                      );
                    },
                  ),
                  10.verticalSpace,

                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/post_location_icon.svg',
                        height: 24.h,
                        width: 24.w,
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Flexible(
                        child: BigText(
                          textAlign: TextAlign.start,
                          text: location?.address ?? "",

                          //  'Location',
                          size: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: appBrownColor,
                        ),
                      )
                    ],
                  ),
                  10.verticalSpace,
                  InkWell(
                    onTap: () {
                      AppNavigation.push(SelectTagPeople());
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/tag_person_icon.svg',
                          height: 24.h,
                          width: 24.w,
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        BigText(
                          text: 'Tag',
                          size: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: appBrownColor,
                        )
                      ],
                    ),
                  ),
                  if (postData.tagPeopleList.isNotEmpty) 15.verticalSpace,
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Wrap(
                        runSpacing: 5.h,
                        spacing: 5.w,
                        alignment: WrapAlignment.start,
                        children: [
                          if (postData.tagPeopleList.isNotEmpty)
                            ...List.generate(
                              postData.tagPeopleList.length,
                              (index) => Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: appBrownColor,
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.h, horizontal: 10.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      child: BigText(
                                        text: postData
                                                .tagPeopleList[0].displayname ??
                                            "",
                                        color: AppColors.whiteColor,
                                        fontWeight: FontWeight.w500,
                                        size: 14.sp,
                                        textAlign: TextAlign.start,
                                        // maxLines: 2,
                                      ),
                                    ),
                                    8.horizontalSpace,
                                    CustomContainer(
                                      onTap: () {
                                        postData.removeTagPeopleId(
                                            postData.tagPeopleList[index].id!);
                                      },
                                      conatinerColor: AppColors.whiteColor,
                                      iconColor: appBrownColor,
                                      width: 15.w,
                                      height: 15.w,
                                      iconData: Icons.close,
                                      iconWidth: 13.w,
                                    )
                                  ],
                                ),
                              ),
                            ),
                        ]),
                  ),
                ],
              ),
            )),
      );
    });
  }
}
