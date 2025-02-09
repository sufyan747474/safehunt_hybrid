import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:safe_hunt/bloc/comment/add_comment_bloc.dart';
import 'package:safe_hunt/bloc/comment/childComment/add_child_comment_bloc.dart';
import 'package:safe_hunt/bloc/comment/comment_update_bloc.dart';
import 'package:safe_hunt/screens/journals/model/location_model.dart';
import 'package:safe_hunt/screens/journals/model/weather_model.dart';
import 'package:safe_hunt/screens/post/enums/enums.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/app_navigation.dart';
import 'package:safe_hunt/utils/colors.dart';
import 'package:safe_hunt/utils/common/app_colors.dart';
import 'package:safe_hunt/utils/static_data.dart';
import 'package:safe_hunt/widgets/app_text_field.dart';
import 'package:safe_hunt/widgets/custom_button.dart';
import 'package:safe_hunt/widgets/image_picker_bottom_sheet.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart' as path;

class Utils {
  ///-------------------- get date format -------------------- ///

  static String formattedDate(
      {String formatPattern = 'MMM dd, yyyy', required String date}) {
    try {
      // Parse and format the date
      final DateTime parsedDate = DateTime.parse(date).toLocal();
      final DateFormat formatter = DateFormat(formatPattern);
      return formatter.format(parsedDate);
    } catch (e) {
      // Handle errors gracefully
      return 'Invalid date';
    }
  }

  ///--------------------format time  -------------------- ///

  static String formatTime({
    String formatPattern = 'h:mm a', // Default to "10:30AM"
    required String time,
  }) {
    try {
      // Parse the time string
      final DateTime parsedTime = DateTime.parse(time);
      final DateFormat formatter = DateFormat(formatPattern);
      return formatter.format(parsedTime);
    } catch (e) {
      // Handle invalid input
      return 'Invalid time';
    }
  }

  ///-------------------- get time from date time -------------------- ///

  static String getDayFromDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString).toLocal();
    DateTime now = DateTime.now();

    // Check if the date is today
    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day) {
      // Return the time only
      return DateFormat.jm().format(dateTime); // Example: "12:57 PM"
    }

    // Check if the date is yesterday
    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day - 1) {
      return 'Yesterday';
    }

    // Check if the date is within the last 3 days
    if (now.difference(dateTime).inDays <= 3) {
      // Return the date only
      return DateFormat('MMMM dd').format(dateTime); // Example: "April 19"
    }

    // Return the full date and time
    return DateFormat('MMMM dd').format(dateTime);
    // return DateFormat('MMMM dd, yyyy hh:mm a')
    // .format(dateTime);
    // Example: "April 19, 2024 12:57 PM"
  }

  ///--------------------clean phone number masking -------------------- ///

  static String cleanPhoneNumber(String phoneNumber) {
    // Use a regular expression to replace non-numeric characters with an empty string
    return phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
  }

  ///-------------------- Format Phone Number Masking -------------------- ///
  static String formatPhoneNumberMasking(String phoneNumber) {
    // Remove any non-digit characters
    String digitsOnly = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');

    try {
      // Check if the number has the correct length (11 for +1 and 10 digits)
      if (digitsOnly.length == 11 && digitsOnly.startsWith('1')) {
        return '+1(${digitsOnly.substring(1, 4)}) ${digitsOnly.substring(4, 7)}-${digitsOnly.substring(7)}';
      } else {
        throw const FormatException(
            'Invalid phone number format. Expected a number like +11234567890');
      }
    } catch (e) {
      // Handle the exception gracefully and return an error message or rethrow
      return '';
    }
  }

  ///-------------------- phone number masking -------------------- ///

  static MaskTextInputFormatter maskTextFormatterPhoneNo =
      MaskTextInputFormatter(
    mask: '+1(###) ###-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  ///-------------------- phone number masking -------------------- ///

  static MaskTextInputFormatter maskTextFormatterPhoneNoLogin =
      MaskTextInputFormatter(
    mask: '(###) ###-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  ///--------------------unfocus keyboard -------------------- ///

  static Future<void> unFocusKeyboard(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    await Future.delayed(const Duration(milliseconds: 50));
  }

  //   ///-------------------- Image Picker Bottom Sheet (Image Picker and Cropper) -------------------- ///
  static void showImageSourceSheet({
    BuildContext? context,
    final Function(File)? setFile,
    bool isPickedMedia = false,
    bool isVideo = false,
  }) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      context: context!,
      builder: (BuildContext context) {
        return ImagePickerBottomSheet(
          setFile: setFile,
          isPickedMedia: isPickedMedia,
          isVideo: isVideo,
        );
      },
    );
  }

  static Future openVideoPicker({
    ImageSource? source,
    BuildContext? context,
    Function(File)? setFile,
    bool action = false,
  }) async {
    FocusScope.of(context!).unfocus();
    action == true ? AppNavigation.pop() : null;
    try {
      final video = await ImagePicker().pickVideo(
        // maxDuration: const Duration(seconds: 30),
        source: source!,
      );

      if (video != null) {
        // Initialize the video player controller to get video duration
        // VideoPlayerController videoPlayerController =
        //     VideoPlayerController.file(File(video.path));

        // await videoPlayerController.initialize();

        // // Get the video duration
        // Duration duration = videoPlayerController.value.duration;
        // print("Video Duration: ${duration.inSeconds} seconds");

        // // Dispose the video player controller to free up resources
        // await videoPlayerController.dispose();
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        print(video.path);
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");

        File _video = File(video.path);
        print(_video);
        print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
        // if (duration.inSeconds < 45) {
        // AppNavigator.push(
        //     navigatorKey.currentContext!, TrimmerView(_video, setFile));
        // // setFile!(_video);
        // } else {
        //   showToastMessage(
        //       msg: 'Video duration should not exceed from 45 secounds');
        // }
      }
    } catch (e) {
      print(e.toString() + "5455555555555555555555555555555555555555555");
    }
  }

  static void cropImage({
    final image,
    Function(File)? setFile,
    BuildContext? context,
  }) async {
    try {
      CroppedFile? croppedFile = await ImageCropper()
          .cropImage(sourcePath: image, aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ], uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Photo',
          toolbarColor: appButtonWhiteColor,
          toolbarWidgetColor: Colors.green,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      ]);
      log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
      log(croppedFile.toString());
      log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
      log(croppedFile!.path);
      log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
      File _image = File(croppedFile.path);
      print(_image);
      log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
      // print(_image);
      setFile!(_image);
      print(setFile);
      log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    } catch (e) {
      log(e.toString());
    }
  }

  static Future openImagePicker({
    ImageSource? source,
    BuildContext? context,
    Function(File)? setFile,
    bool action = true,
    bool isPickMedia = false,
  }) async {
    FocusScope.of(context!).unfocus();
    action == true ? Navigator.pop(context) : null;

    try {
      final XFile? media = isPickMedia
          ? await ImagePicker().pickMedia(imageQuality: 50)
          : await ImagePicker().pickImage(source: source!, imageQuality: 50);

      if (media != null) {
        log("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        log(media.path);
        log("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");

        final String extension = path.extension(media.path).toLowerCase();
        if (['.jpg', '.jpeg', '.png'].contains(extension)) {
          // Handle image cropping
          cropImage(
            image: media.path,
            setFile: setFile,
            context: context,
          );
        } else if (['.mp4', '.mov', '.avi'].contains(extension)) {
          // Handle video file directly
          if (setFile != null) {
            setFile(File(media.path));
          }
        } else {
          log('Unsupported file type: $extension');
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // ///-------------------- rating bar -------------------- ///
  // static RatingBar ratingBar(
  //     {double initialRating = 1.0,
  //     double minRating = 1.0,
  //     double? itemSize,
  //     void Function(double)? onRatingUpdate,
  //     bool ignoreGestures = true}) {
  //   return RatingBar.builder(
  //     initialRating: initialRating,
  //     minRating: minRating,
  //     direction: Axis.horizontal,
  //     allowHalfRating: true,
  //     itemCount: 5,
  //     itemSize: itemSize ?? 18.w,
  //     ignoreGestures: ignoreGestures,
  //     itemPadding: EdgeInsets.symmetric(horizontal: 0.w),
  //     itemBuilder: (context, _) => Icon(
  //       Icons.star,
  //       color: Colors.amber,
  //       size: 16.w,
  //     ),
  //     onRatingUpdate: onRatingUpdate ?? (rating) {},
  //   );
  // }

  static Future<(LocationModel?, WeatherModel?)> getLatLong() async {
    await Geolocator.requestPermission();

    final loc = await Geolocator.getCurrentPosition();
    LocationModel? location;
    WeatherModel? weather;

    // Get Address
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(loc.latitude, loc.longitude);
      Placemark place = placemarks[0];

      final address =
          "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      log("Address: $address");

      location = LocationModel(
        address: address,
        lat: loc.latitude,
        lng: loc.longitude,
      );
    } catch (e) {
      log("Error getting address: $e");
    }

    // Fetch Weather
    const url = 'https://api.openweathermap.org/data/2.5/weather';
    try {
      final Dio dio = Dio();
      final Response response = await dio.get(
        url,
        queryParameters: {
          'APPID': 'be0e7ea07db2ec59d69dadf9c98a479c',
          'lat': loc.latitude,
          'lon': loc.longitude,
          'units': 'Metric'
        },
      );

      if (response.statusCode == 200) {
        log('Weather Data: ${response.data}');
        weather = WeatherModel.fromJson(response.data);
      } else {
        log('Failed to fetch weather data: ${response.statusMessage}');
      }
    } catch (e) {
      log('Error occurred: $e');
    }

    return (location, weather);
  }

  /// Function to get icon based on weather condition
  static IconData getWeatherIcon(String? condition, String? iconCode) {
    bool isNight = iconCode?.endsWith("n") ?? false; // Check if it's night

    switch (condition) {
      case 'Clear':
        return isNight ? Icons.nightlight_round : Icons.wb_sunny; // 🌙 / ☀️
      case 'Clouds':
        return isNight ? Icons.cloud_outlined : Icons.cloud; // ☁️
      case 'Rain':
        return Icons.umbrella; // 🌧️
      case 'Drizzle':
        return Icons.grain; // 🌦️
      case 'Thunderstorm':
        return Icons.flash_on; // ⚡
      case 'Snow':
        return Icons.ac_unit; // ❄️
      case 'Mist':
      case 'Fog':
      case 'Haze':
      case 'Smoke':
        return Icons.blur_on; // 🌫️
      case 'Dust':
      case 'Sand':
        return Icons.waves; // 🌪️
      case 'Squall':
      case 'Tornado':
        return Icons.air; // 💨
      default:
        return Icons.help_outline; // ❓
    }
  }

  static void typingModal(
    modalType type, {
    isEdit = false,
    String? text,
    String? postId,
    String? sharePostId,
    String? commentId,
    String? parrentId,
    String? comment,
    bool isChild = false,
    bool isSharedPost = false,
  }) {
    final msgController = TextEditingController(text: text);
    isEdit ? msgController.text = comment ?? '' : null;
    log('comment id : $commentId');
    log('comment type : ${type.name}');

    showModalBottomSheet(
        isScrollControlled: true,
        context: StaticData.navigatorKey.currentContext!,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                height: .3.sh,
                width: 1.sw,
                decoration: BoxDecoration(
                    color: appButtonColor,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.r))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: .06.sw),
                  child: Column(
                    children: [
                      8.verticalSpace,
                      Container(
                          width: 70.w,
                          height: 6.h,
                          decoration: BoxDecoration(
                              color: appBrownColor,
                              borderRadius: BorderRadius.circular(10.r))),
                      20.verticalSpace,
                      Text(
                        type == modalType.comment ? "Comment" : "Reply",
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.w700),
                      ),
                      20.verticalSpace,
                      AppTextField(
                        textController: msgController,
                        maxLength: 275,
                        onChanged: (val) {
                          setState(() {});
                        },
                        onEditingComplete: () {
                          if (msgController.text.trim().isNotEmpty) {
                            if (isEdit) {
                              updateCommentMethod(context, msgController,
                                  commentId, isEdit, type);
                            } else {
                              if (type == modalType.comment) {
                                addCommentMethod(context, msgController, postId,
                                    isEdit, type);
                              } else if (type == modalType.reply) {
                                addChildCommentMethod(context, msgController,
                                    postId, commentId, isEdit, type);
                              }
                            }
                          }
                        },
                        textInputAction: TextInputAction.send,
                        hintText: "Write your ${type.name}...",
                      ),
                      15.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                AppNavigation.pop();
                              },
                              child: CustomButton(
                                textColor: AppColors.whiteColor,
                                text: "Cancel",
                                border: Border.all(
                                    width: 1.5, color: AppColors.darkRedColor),
                                color: appBrownColor,
                              ),
                            ),
                          ),
                          8.horizontalSpace,
                          Expanded(
                            child: Opacity(
                              opacity:
                                  msgController.text.trim().isEmpty ? .5 : 1,
                              child: InkWell(
                                onTap: () {
                                  if (msgController.text.trim().isNotEmpty) {
                                    if (isEdit) {
                                      updateCommentMethod(
                                          context,
                                          msgController,
                                          commentId,
                                          isEdit,
                                          type);
                                    } else {
                                      if (type == modalType.comment) {
                                        addCommentMethod(context, msgController,
                                            postId, isEdit, type);
                                      } else if (type == modalType.reply) {
                                        addChildCommentMethod(
                                            context,
                                            msgController,
                                            postId,
                                            commentId,
                                            isEdit,
                                            type);
                                      }
                                    }
                                  }
                                },
                                child: CustomButton(
                                    textColor: AppColors.whiteColor,
                                    border: Border.all(
                                        width: 1.5,
                                        color: AppColors.darkRedColor),
                                    color: appBrownColor,
                                    text: isEdit ? "Edit" : "Add",
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  static void addChildCommentMethod(
      BuildContext context,
      TextEditingController msgController,
      String? postId,
      String? commentId,
      isEdit,
      modalType type) {
    AddChildCommentBloc().addChildCommentBlocMethod(
      context: context,
      setProgressBar: () {
        AppDialogs.progressAlertDialog(context: context);
      },
      comment: msgController.text,
      postId: postId,
      parrentId: commentId,
      onSuccess: () {
        AppNavigation.pop();
        AppDialogs.showToast(
            message: "${isEdit ? "Edit" : "Add"} ${type.name} Successfully");
      },
    );
  }

  static void updateCommentMethod(
      BuildContext context,
      TextEditingController msgController,
      String? commentId,
      isEdit,
      modalType type) {
    UpdateCommentBloc().updateCommentBlocMethod(
        context: context,
        setProgressBar: () {
          AppDialogs.progressAlertDialog(context: context);
        },
        comment: msgController.text.trim(),

        // postId: postId,
        // shareId: sharePostId,
        commentId: commentId,
        onSuccess: () {
          AppNavigation.pop();
          AppDialogs.showToast(
              message: "${isEdit ? "Edit" : "Add"} ${type.name} Successfully");
        });
  }

  static void addCommentMethod(
      BuildContext context,
      TextEditingController msgController,
      String? postId,
      isEdit,
      modalType type) {
    AddCommentBloc().addCommentBlocMethod(
        context: context,
        setProgressBar: () {
          AppDialogs.progressAlertDialog(context: context);
        },
        comment: msgController.text.trim(),
        postId: postId,
        onSuccess: () {
          AppNavigation.pop();
          AppDialogs.showToast(
              message: "${isEdit ? "Edit" : "Add"} ${type.name} Successfully");
        });
  }

  static getLocationFromLatLng({
    required double lat,
    required double lng,
  }) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;

        String address = [
          place.street,
          place.locality,
          place.administrativeArea,
          place.country
        ].where((element) => element != null && element.isNotEmpty).join(", ");

        log("Address: $address");
        return address;
      } else {
        log("No address found for coordinates.");
        return "No address found";
      }
    } catch (e) {
      log("Error getting address: $e");
      return "Error fetching address";
    }
  }
}
