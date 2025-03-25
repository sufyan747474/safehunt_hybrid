import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_hunt/utils/app_navigation.dart';
import 'package:safe_hunt/utils/common/app_colors.dart';
import 'package:safe_hunt/utils/common/asset_path.dart';
import 'package:safe_hunt/widgets/Custom_image_widget.dart';

class ViewFullImageScreen extends StatelessWidget {
  final String? imageUrl;
  final bool isBaseUrl;
  const ViewFullImageScreen({
    Key? key,
    this.imageUrl,
    this.isBaseUrl = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        leading: Padding(
          padding: EdgeInsets.all(8.0.w),
          child: Transform.translate(
              offset: Offset(1.w, 0),
              child: GestureDetector(
                  onTap: () {
                    AppNavigation.pop();
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 23.sp,
                    color: Colors.white,
                  ))),
        ),
      ),
      backgroundColor: AppColors.blackColor,
      body: Center(
        child: InteractiveViewer(
          // minScale: 1.0, // Minimum zoom level
          // maxScale: 5.0,
          child: CustomImageWidget(
            imageUrl: imageUrl,
            shape: BoxShape.rectangle,
            isBorder: false,
            isBaseUrl: isBaseUrl,
            fit: BoxFit.contain,
            imageWidth: 1.sw,
            imageHeight: 1.sh,
            imageAssets: AppAssets.postImagePlaceHolder,
          ),
        ),
      ),
    );
  }
}
