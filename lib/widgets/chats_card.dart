import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_hunt/utils/common/app_colors.dart';
import 'package:safe_hunt/utils/common/asset_path.dart';
import 'package:safe_hunt/widgets/Custom_image_widget.dart';

import '../utils/colors.dart';
import 'big_text.dart';

class ChatsCard extends StatefulWidget {
  final String? image;
  final String name;
  final String message;
  final String time;
  final bool isGroup;
  const ChatsCard(
      {super.key,
      required this.name,
      required this.message,
      required this.time,
      this.isGroup = false,
      this.image});

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
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CustomImageWidget(
                imageUrl: widget.image,
                imageHeight: 50.w,
                imageWidth: 50.w,
                borderColor: AppColors.greenColor,
                borderWidth: 2.r,
                imageAssets:
                    widget.isGroup ? AppAssets.postImagePlaceHolder : null,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(
                        text: widget.name,
                        fontWeight: FontWeight.w700,
                        color: appBlackColor,
                        size: 16.sp,
                        maxLine: 1,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      BigText(
                        textAlign: TextAlign.start,
                        text: widget.message,
                        fontWeight: FontWeight.w400,
                        color: appBrownColor,
                        size: 10.sp,
                        maxLine: 2,
                      ),
                    ],
                  ),
                ),
              ),
              if (!widget.isGroup) ...[
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
            ],
          )),
    );
  }
}
