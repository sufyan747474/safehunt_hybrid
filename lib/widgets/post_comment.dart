import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_hunt/utils/colors.dart';
import 'package:safe_hunt/widgets/big_text.dart';

class PostComment extends StatelessWidget {
  final String time;
  final String postComment;
  final String profileName;
  final String profileImage;
  final int likeCount;

  const PostComment({
    super.key,
    required this.time,
    required this.postComment,
    required this.profileName,
    required this.profileImage,
    required this.likeCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(30.r),
                  child: Image.asset(
                    profileImage,
                    width: 50,
                    height: 50.h,
                    fit: BoxFit.cover,
                  )),
              const SizedBox(
                width: 16.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: BoxDecoration(
                      color: appButtonColor,
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // SizedBox(
                          //   height: 20.h,
                          // ),
                          BigText(
                            text: profileName,
                            size: 12.sp,
                            color: appBrownColor,
                            fontWeight: FontWeight.w700,
                          ),
                          BigText(
                            text: postComment,
                            size: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    children: [
                      BigText(
                        text: time,
                        size: 8.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      BigText(
                        text: 'Like',
                        size: 8.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      InkWell(
                        onTap: () {},
                        child: BigText(
                          text: 'Reply',
                          size: 8.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.24,
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
