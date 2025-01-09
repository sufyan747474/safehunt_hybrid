import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe_hunt/utils/colors.dart';
import 'package:safe_hunt/widgets/big_text.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final TextEditingController _messageTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: BigText(
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
                  height: 50.h,
                  width: 50.w,
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: appBrownColor,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: BigText(
                    text: 'W',
                    size: 20.sp,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                BigText(
                  text: 'William jack',
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
          child: Column(
            children: [
              Container(
                height: 5.w,
                width: 32.h,
                decoration: BoxDecoration(
                  color: appBrownColor,
                  borderRadius: BorderRadius.all(Radius.circular(30.r)),
                  // border: Border.all(width: 1, ),
                ),
              ),
              const Spacer(),
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
              const Spacer(),
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
                  BigText(
                    text: 'Location',
                    size: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: appBrownColor,
                  )
                ],
              ),
              const Spacer(),
              Row(
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
              const Spacer(),
            ],
          )),
    );
  }
}
