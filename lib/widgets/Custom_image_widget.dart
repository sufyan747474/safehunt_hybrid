import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_hunt/utils/colors.dart';
import 'package:safe_hunt/utils/common/app_colors.dart';
import 'package:safe_hunt/utils/common/asset_path.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/utils.dart';
import 'package:shimmer/shimmer.dart';

class CustomImageWidget extends StatefulWidget {
  final File? pickedImage;
  final Function(File?)? setFile;
  final bool canSelectImage;
  final Color borderColor;
  final bool isPlaceHolderShow;
  final String? imageAssets;
  final String? imageUrl;
  final BoxFit? fit;
  final double? imageWidth;
  final double? imageHeight;
  final double? borderWidth;
  final bool isBorder;
  final BoxShape shape;
  final BorderRadius? borderRadius;
  final Color uploadIconColor;
  final String? uploadImage;
  final bool isBaseUrl;

  const CustomImageWidget(
      {super.key,
      this.isBaseUrl = true,
      this.pickedImage,
      this.fit,
      this.isPlaceHolderShow = true,
      this.setFile,
      this.canSelectImage = false,
      this.borderColor = Colors.white,
      this.imageAssets,
      this.imageUrl,
      this.isBorder = true,
      this.imageWidth,
      this.imageHeight,
      this.borderWidth,
      this.shape = BoxShape.circle,
      this.borderRadius,
      this.uploadIconColor = appButtonColor,
      this.uploadImage});

  @override
  State<CustomImageWidget> createState() => _CustomImageWidgetState();
}

class _CustomImageWidgetState extends State<CustomImageWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: widget.canSelectImage == false
          ? null
          : () {
              Utils.showImageSourceSheet(
                context: context,
                setFile: widget.setFile,
              );
            },
      child: Stack(
        children: [
          Container(
            width: widget.imageWidth ?? 140.w,
            height: widget.imageHeight ?? 140.w,
            decoration: BoxDecoration(
              image: widget.isPlaceHolderShow
                  ? DecorationImage(
                      image: AssetImage(
                        widget.imageAssets ?? AppAssets.imagePlaceholder,
                      ),
                      fit: widget.fit ?? BoxFit.cover,
                    )
                  : null,
              border: widget.isBorder
                  ? Border.all(
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: widget.borderColor,
                      width: widget.borderWidth ?? 5.w,
                    )
                  : null,
              borderRadius: widget.borderRadius,
              shape: widget.borderRadius == null
                  ? widget.shape
                  : BoxShape.rectangle,
            ),
            child: widget.pickedImage != null
                ? ExtendedImage.file(
                    widget.pickedImage!,
                    fit: widget.fit ?? BoxFit.cover,
                    borderRadius: widget.borderRadius,
                    shape: widget.borderRadius == null
                        ? widget.shape
                        : BoxShape.rectangle,
                  )
                : widget.imageUrl != null
                    ? ExtendedImage.network(
                        widget.isBaseUrl
                            ? NetworkStrings.IMAGE_BASE_URL + widget.imageUrl!
                            : widget.imageUrl!,
                        borderRadius: widget.borderRadius,
                        shape: widget.borderRadius == null
                            ? widget.shape
                            : BoxShape.rectangle,
                        fit: widget.fit ?? BoxFit.cover,
                        loadStateChanged: (ExtendedImageState state) {
                          switch (state.extendedImageLoadState) {
                            case LoadState.completed:
                              return ExtendedRawImage(
                                image: state.extendedImageInfo?.image,
                                fit: widget.fit ?? BoxFit.cover,
                              );
                            case LoadState.failed:
                              return Image.asset(
                                widget.imageAssets ??
                                    AppAssets.imagePlaceholder,
                              );
                            default:
                              return Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(color: Colors.white),
                              );
                          }
                        },
                      )
                    : null,
          ),
          widget.canSelectImage
              ? Positioned(
                  bottom: 00,
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      Utils.showImageSourceSheet(
                        context: context,
                        setFile: widget.setFile,
                      );
                    },
                    child: Container(
                      height: 33,
                      width: 33,
                      decoration: const BoxDecoration(
                        color: AppColors.whiteColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: SizedBox(
                          height: 32,
                          width: 32,
                          child: CircleAvatar(
                              backgroundColor: AppColors.blackColor,
                              child: widget.uploadImage == null
                                  ? Icon(
                                      Icons.file_upload_outlined,
                                      color: widget.uploadIconColor,
                                      size: 13.w,
                                    )
                                  : Image(
                                      image: AssetImage(widget.uploadImage!),
                                      width: 13.w,
                                      height: 13.h,
                                    )),
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
