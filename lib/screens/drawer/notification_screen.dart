import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe_hunt/widgets/big_text.dart';

import '../../utils/colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appButtonColor,
      appBar: AppBar(
        centerTitle: true,
        bottomOpacity: 0.0,
        scrolledUnderElevation: 0,
        toolbarOpacity: 0,
        elevation: 0,
        backgroundColor: appButtonColor,
        leadingWidth: 200,
        leading: Padding(
          padding: const EdgeInsets.all(15.0),
          child: BigText(
            text: 'Notificatons',
            size: 16.sp,
            color: appBlackColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: 60.w,
              height: 30.h,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: subscriptionCardColor,
                borderRadius: BorderRadius.all(Radius.circular(15.r)),
              ),
              child: SvgPicture.asset(
                'assets/search_icon.svg',
              ),
            ),
          ),
        ],
      ),
      body: listView(),
    );
  }

  Widget listView() {
    return ListView.separated(
        // Offset itemCount to start with separator
        itemCount: 15,
        itemBuilder: (context, index) {
          return listViewItem(index);
        },
        separatorBuilder: (context, index) {
          return Container(
            height: 0.h,
          );
        });
  }

  Widget listViewItem(int index) {
    return Container(
      color: index == 0 ? subscriptionCardColor : appButtonColor,
      // height: 120.h,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            prefixIcon(),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 10, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    message(index),
                    SizedBox(
                      height: 10.h,
                    ),
                    timeAndDate(index),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget prefixIcon() {
    return Center(
      child: CircleAvatar(
        radius: 35,
        backgroundImage: const AssetImage("assets/post_picture.png"),
        child: Stack(children: [
          Align(
            alignment: Alignment.bottomRight,
            child: CircleAvatar(
              radius: 13,
              backgroundColor: appDarkGreenColor,
              child: SvgPicture.asset('assets/gallery.svg',
                  color: Colors.white, height: 12),
            ),
          ),
        ]),
      ),
    );
  }

  Widget message(int index) {
    double textSize = 16.sp;
    return Container(
      child: RichText(
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
            text: 'Henry',
            style: TextStyle(
                fontSize: textSize,
                color: appBlackColor,
                fontWeight: FontWeight.w700),
            children: const [
              TextSpan(
                text: ' has posted 1 photo on sunday ',
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
            ]),
      ),
    );
  }

  Widget timeAndDate(int index) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BigText(
            text: 'Fri at 1:36 Am',
            size: 10.sp,
            color: appBrownColor,
            fontWeight: FontWeight.w400,
          )
        ],
      ),
    );
  }
}
