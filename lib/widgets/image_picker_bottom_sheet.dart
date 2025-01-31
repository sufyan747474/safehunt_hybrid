import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safe_hunt/utils/common/app_colors.dart';
import 'package:safe_hunt/utils/utils.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  final Function(File)? setFile;

  final bool isMulti;
  final bool isVideo;
  final bool isPickedMedia;

  const ImagePickerBottomSheet(
      {super.key,
      this.setFile,
      this.isMulti = false,
      this.isVideo = false,
      this.isPickedMedia = false});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.r),
                topRight: Radius.circular(24.r))),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                print(isPickedMedia);
                isVideo
                    ? Utils.openVideoPicker(
                        setFile: setFile,
                        context: context,
                        source: ImageSource.camera)
                    : Utils.openImagePicker(
                        source: ImageSource.camera,
                        context: context,
                        setFile: setFile,
                      );
              },
              child: const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 5, left: 17),
                child: Row(
                  children: [
                    Icon(
                      Icons.camera_alt_outlined,
                      color: AppColors.greenColor,
                    ),
                    SizedBox(width: 20),
                    Text(
                      "CAMERA",
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w500,
                      ),
                      // textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
            const Divider(color: AppColors.greenColor),
            InkWell(
              onTap: () {
                isVideo
                    ? Utils.openVideoPicker(
                        setFile: setFile,
                        context: context,
                        source: ImageSource.gallery)
                    : Utils.openImagePicker(
                        isPickMedia: isPickedMedia,
                        source: ImageSource.gallery,
                        context: context,
                        setFile: setFile,
                      );
              },
              child: const Padding(
                padding: EdgeInsets.only(top: 5, bottom: 15, left: 17),
                child: Row(
                  children: [
                    Icon(Icons.photo_library, color: AppColors.greenColor),
                    SizedBox(width: 20),
                    Text(
                      "GALLERY",
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
