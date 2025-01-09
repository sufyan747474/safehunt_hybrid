import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:safe_hunt/utils/colors.dart';

import '../../widgets/big_text.dart';
import '../../widgets/user_message_card.dart';

class UserChat extends StatefulWidget {
  final String id;
  const UserChat({super.key, required this.id});

  @override
  State<UserChat> createState() => _UserChatState();
}

class _UserChatState extends State<UserChat> {
  final TextEditingController _messageController = TextEditingController();
  var radius = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: subscriptionCardColor,
      appBar: AppBar(
        backgroundColor: appButtonColor,
        elevation: 0.0,
        // centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.all(8.0.w),
          child: Transform.translate(
              offset: Offset(1.w, 0),
              child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 23.sp,
                    color: Colors.black,
                  ))),
        ),

        titleSpacing: -3,
// toolbarHeight: 70.h,
        title: Row(
          children: [
            Stack(
              // fit: StackFit.expand,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(30.r),
                  child: Image.asset(
                    'assets/post_picture.png',
                    fit: BoxFit.cover,
                    width: 50.w,
                    height: 50.h,
                  ),
                ),
                Positioned(
                  right: 6.0,
                  top: 39.0,
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
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(40.r),
            //   child: Image.asset('assets/post_picture.png', fit: BoxFit.cover, width: 55.w,height: 56.h,),
            // ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(
                    text: 'Henry',
                    size: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: appBlackColor,
                  ),
                  BigText(
                    text: 'typing',
                    size: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: appBrownColor,
                  ),
                ],
              ),
            )
          ],
        ),

        actions: const [
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Icon(
              Icons.more_vert,
              color: appBrownColor,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.h),
            //   child: Container(
            //     width: MediaQuery.of(context).size.width,
            //     decoration: BoxDecoration(
            //         color: Colors.red,
            //         borderRadius: BorderRadius.circular(20.r)),
            //     child: Row(
            //       children: [
            //         Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: ClipRRect(
            //             borderRadius: BorderRadius.circular(20.r),
            //             child: Image.network(
            //               'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=3744&q=80',
            //               width: 80.w,
            //               fit: BoxFit.cover,
            //               height: 100,
            //             ),
            //           ),
            //         ),
            //         SizedBox(
            //           width: 160.w,
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               BigText(
            //                 text: 'Dianne Russell!',
            //                 fontWeight: FontWeight.bold,
            //                 color: Colors.white,
            //                 size: 15.sp,
            //                 maxLine: 1,
            //               ),
            //               SizedBox(
            //                 height: 5.h,
            //               ),
            //               Row(
            //                 children: [
            //                   Container(
            //                     width: 10.w,
            //                     height: 10.w,
            //                     decoration: BoxDecoration(
            //                         color: Colors.red,
            //                         borderRadius: BorderRadius.circular(40.r)),
            //                   ),
            //                   SizedBox(
            //                     width: 5.w,
            //                   ),
            //                   BigText(
            //                     text: 'Online',
            //                     fontWeight: FontWeight.w500,
            //                     color: Colors.white,
            //                     size: 13.sp,
            //                     maxLine: 2,
            //                   ),
            //                 ],
            //               ),
            //             ],
            //           ),
            //         ),
            //         Padding(
            //           padding: EdgeInsets.symmetric(horizontal: 10.0.w),
            //           child: Container(
            //               width: 50.w,
            //               height: 50.w,
            //               decoration: BoxDecoration(
            //                   color: Colors.black26,
            //                   borderRadius: BorderRadius.circular(40.r)),
            //               child: Icon(Icons.phone)),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 15,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      UserChatCard(
                        isMe: index % 2 == 0 ? true : false,
                        message: index % 2 == 0
                            ? 'Lorem ipsum dolor sit amet, consectetur adipiscing elit!!!'
                            : 'Lorem ipsum dolor sit amet, consectetur adipiscing elit,',
                        userName: 'Henry',
                        chatTime: '14.50',
                      ),
                    ],
                  );
                },
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                // borderRadius: BorderRadius.circular(20.r),
                color: appButtonColor,
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Row(
                children: [
                  Image.asset('assets/chat_emoji.png'),
                  SizedBox(
                    width: 5.w,
                  ),
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: appBrownColor,
                          fontWeight: FontWeight.w500),
                      controller: _messageController,
                      maxLines: 20,
                      minLines: 1,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            fontSize: 12.sp,
                            color: appBrownColor,
                            fontWeight: FontWeight.w400),
                        hintText: 'Write a message.......',
                        contentPadding: const EdgeInsets.all(8),
                        fillColor: Colors.black,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(
                            width: 0.0,
                            color: Colors.transparent,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(
                            width: 0.0,
                            color: Colors.transparent,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(
                            width: 0.0,
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Image.asset('assets/paper_clip.png'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
