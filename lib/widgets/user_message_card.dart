import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_hunt/utils/common/app_colors.dart';
import 'package:safe_hunt/utils/common/asset_path.dart';
import 'package:safe_hunt/utils/utils.dart';
import 'package:safe_hunt/widgets/Custom_image_widget.dart';

import '../utils/colors.dart';
import 'big_text.dart';

class UserChatCard extends StatelessWidget {
  final bool isMe;
  final String message;
  final String userName;
  final String chatTime;
  final String? attachment;
  final String? reveiverImage;

  const UserChatCard(
      {super.key,
      required this.isMe,
      required this.message,
      required this.userName,
      required this.chatTime,
      this.reveiverImage,
      this.attachment});

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
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: userName,
                      fontWeight: FontWeight.w600,
                      color: appLightGreenColor,
                      size: 14.sp,
                    ),
                    attachment != null
                        ? ChatImage(
                            base64String: attachment,
                          )
                        : BigText(
                            textAlign: TextAlign.start,
                            text: message,
                            fontWeight: FontWeight.w500,
                            color: Colors.brown,
                            size: 12.sp,
                          ),
                    // SizedBox(
                    //   height: 10.h,
                    // ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: BigText(
                        // textAlign: TextAlign.end,
                        text: Utils.getDayFromDateTime(chatTime),
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
              padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 20.h),
              child: Row(
                children: [
                  CustomImageWidget(
                    imageUrl: reveiverImage,
                    imageHeight: 50.w,
                    imageWidth: 50.w,
                    borderColor: AppColors.greenColor,
                    borderWidth: 2.r,
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.w),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(
                          text: userName,
                          fontWeight: FontWeight.w600,
                          color: appLightGreenColor,
                          size: 14.sp,
                        ),
                        attachment != null
                            ? ChatImage(
                                base64String: attachment,
                              )
                            : BigText(
                                textAlign: TextAlign.start,
                                text: message,
                                fontWeight: FontWeight.w500,
                                color: Colors.brown,
                                size: 12.sp,
                              ),
                        // SizedBox(
                        //   height: 10.h,
                        // ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: BigText(
                            // textAlign: TextAlign.end,
                            text: Utils.getDayFromDateTime(chatTime),
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

class ChatImage extends StatelessWidget {
  final String? base64String;

  const ChatImage({super.key, this.base64String});

  @override
  Widget build(BuildContext context) {
    if (base64String == null || base64String!.isEmpty) {
      return const SizedBox(); // Return an empty widget if no image
    }

    if (base64String!.contains('uploads/')) {
      // If it's a URL, use CustomImageWidget
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 5.w),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.r), // Apply rounded corners
          child: CustomImageWidget(
            isBaseUrl: false,
            imageUrl:
                "https://safehunt.app/safehunt-backend/public$base64String",
            isBorder: false,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.zero,
            fit: BoxFit.cover,
            imageAssets: AppAssets.postImagePlaceHolder,
            imageWidth: 1.sw, // Full width
            imageHeight: 200.h,
          ),
        ),
      );
    }

    try {
      // Remove Base64 prefix if present
      String cleanBase64 = base64String!;
      if (base64String!.contains(',')) {
        cleanBase64 = base64String!.split(',')[1];
      }

      Uint8List imageBytes = base64Decode(cleanBase64);

      return Padding(
        padding: EdgeInsets.symmetric(vertical: 5.w),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.r), // Apply rounded corners
          child: Image.memory(
            imageBytes,
            fit: BoxFit.cover,
            width: 1.sw, // Full width
            height: 200.h, // Adjust height as needed
          ),
        ),
      );
    } catch (e) {
      return const Text("Error loading image");
    }
  }
}
