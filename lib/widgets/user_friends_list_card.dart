import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_hunt/widgets/Custom_image_widget.dart';
import 'package:safe_hunt/widgets/big_text.dart';

import '../utils/colors.dart';

class UserFriendsList extends StatelessWidget {
  const UserFriendsList({super.key, required this.title, this.image});
  final String title;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: appButtonColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        // color: Colors.orange,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: CustomImageWidget(
                    imageHeight: 160.h,
                    shape: BoxShape.rectangle,
                    fit: BoxFit.cover,
                    imageUrl: image,
                    isBorder: false,
                  ),
                ),
              ),
              //
              BigText(
                text: title,
                size: 12.sp,
                maxLine: 2,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(
                height: 15.h,
              )
            ]));
  }
}
