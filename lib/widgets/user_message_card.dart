import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/colors.dart';
import 'big_text.dart';

class UserChatCard extends StatelessWidget {
  final bool isMe;
  final String message;
  final String userName;
  final String chatTime;
  const UserChatCard(
      {super.key,
      required this.isMe,
      required this.message,
      required this.userName,
      required this.chatTime});

  @override
  Widget build(BuildContext context) {
    return isMe
        ? Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.h),
              child: Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.6),
                //   width: MediaQuery.of(context).size.width,
                //  height: 60.h,
                decoration: BoxDecoration(
                    color: appButtonColor,
                    borderRadius: BorderRadius.circular(8.r)),
                padding:
                    EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: 'Charles',
                      fontWeight: FontWeight.w600,
                      color: appLightGreenColor,
                      size: 14.sp,
                    ),
                    BigText(
                      text: message,
                      fontWeight: FontWeight.w500,
                      color: Colors.brown,
                      size: 12.sp,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: BigText(
                        // textAlign: TextAlign.end,
                        text: chatTime,
                        fontWeight: FontWeight.w400,
                        color: appBrownColor,
                        size: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.h),
              child: Row(
                children: [
                  Stack(
                    // fit: StackFit.expand,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30.r),
                        child: Image.asset(
                          'assets/post_picture.png',
                          fit: BoxFit.cover,
                          width: 55.w,
                          height: 55.h,
                        ),
                      ),
                      Positioned(
                        right: 8,
                        top: 43,
                        child: Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          // width: radius / 2,
                          // height: radius / 2,
                          child: Icon(
                            Icons.circle,
                            size: 11.sp,
                            color: Colors.yellow[700],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.6),
                    //   width: MediaQuery.of(context).size.width,
                    //  height: 60.h,
                    decoration: BoxDecoration(
                        color: appButtonColor,
                        borderRadius: BorderRadius.circular(8.r)),
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.0.w, vertical: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(
                          text: userName,
                          fontWeight: FontWeight.w600,
                          color: appLightGreenColor,
                          size: 14.sp,
                        ),
                        BigText(
                          text: message,
                          fontWeight: FontWeight.w500,
                          color: Colors.brown,
                          size: 12.sp,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: BigText(
                            // textAlign: TextAlign.end,
                            text: chatTime,
                            fontWeight: FontWeight.w400,
                            color: appBrownColor,
                            size: 10.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
