import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/colors.dart';
import 'big_text.dart';

class ChatsCard extends StatefulWidget {
  final String image;
  final String name;
  final String message;
  final String time;
  const ChatsCard(
      {super.key,
      required this.name,
      required this.message,
      required this.time,
      required this.image});

  @override
  State<ChatsCard> createState() => _ChatsCardState();
}

class _ChatsCardState extends State<ChatsCard> {
  bool changeColor = false;
  bool unreadMessage = true;
  int index = 2;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: changeColor ? appButtonColor : subscriptionCardColor,
        // borderRadius: BorderRadius.circular(20.r)
      ),
      child: GestureDetector(
        onTap: () {
          setState(() {
            changeColor = !changeColor;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(30.r),
              //   child: Image.asset(
              //     widget.image,
              //     // width: 83.w,
              //     // height: 83.h,
              //     fit: BoxFit.cover,
              //   ),
              // ),
              Stack(
                // fit: StackFit.expand,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30.r),
                    child: Image.asset(
                      widget.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 70,
                    child: Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      // width: radius / 2,
                      // height: radius / 2,
                      child: Icon(
                        Icons.circle,
                        size: 13.sp,
                        color: Colors.yellow[700],
                      ),
                    ),
                  )
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: widget.name,
                      fontWeight: FontWeight.w700,
                      color: appBlackColor,
                      size: 16.sp,
                      maxLine: 1,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    BigText(
                      text: widget.message,
                      fontWeight: FontWeight.w400,
                      color: appBrownColor,
                      size: 10.sp,
                      maxLine: 2,
                    ),
                  ],
                ),
              ),

              const Spacer(),
              Padding(
                padding: EdgeInsets.only(right: 10.0.w),
                child: Column(
                  children: [
                    BigText(
                      text: widget.time,
                      fontWeight: FontWeight.w500,
                      color: Colors.brown,
                      size: 10.sp,
                    ),
                    changeColor
                        ? Container(
                            alignment: Alignment.center,
                            height: 24.h,
                            width: 24.w,
                            decoration: BoxDecoration(
                              color: appLightGreenColor,
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            child: BigText(
                              textAlign: TextAlign.center,
                              text: '5',
                              size: 10.sp,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
