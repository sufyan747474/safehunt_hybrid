import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safe_hunt/bloc/hunting_journal/add_journal_bloc.dart';
import 'package:safe_hunt/bloc/hunting_journal/update_journal_bloc.dart';
import 'package:safe_hunt/screens/journals/model/journal_model.dart';
import 'package:safe_hunt/screens/journals/model/location_model.dart';
import 'package:safe_hunt/screens/journals/model/weather_model.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/app_navigation.dart';
import 'package:safe_hunt/utils/common/app_colors.dart';
import 'package:safe_hunt/utils/utils.dart';
import '../../utils/colors.dart';
import '../../widgets/big_text.dart';

class EditScreen extends StatefulWidget {
  final JournalData? journal;
  final bool isEdit;
  const EditScreen({super.key, this.journal, this.isEdit = false});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  LocationModel? location;
  WeatherModel? wheather;

  @override
  void initState() {
    if (widget.isEdit) {
      _titleController =
          TextEditingController(text: widget.journal?.title ?? "");
      _contentController =
          TextEditingController(text: widget.journal?.description ?? "");
      location = widget.journal?.location;
    } else {
// Call getLatLong and update state
      Utils.getLatLong().then((result) {
        if (!mounted) return; // ✅ Prevent setState if widget is disposed
        setState(() {
          location = result.$1;
          wheather = result.$2;
        });
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appButtonColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appButtonColor,
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
                    color: Colors.black,
                  ))),
        ),
        title: BigText(
          text: "${widget.isEdit ? "Update" : ''} Hunting Journal",
          size: 16.sp,
          fontWeight: FontWeight.w700,
        ),
        titleSpacing: -10,
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: GestureDetector(
        //         onTap: () async {
        //           // final result = await confirmDialog(context);
        //           // if (result != null && result) {
        //           //   deleteNote(index);
        //           // }
        //         },
        //         child: const Icon(
        //           Icons.more_vert,
        //           color: appBrownColor,
        //         )),
        //   ),
        // ],
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              children: [
                TextField(
                  controller: _titleController,
                  style: TextStyle(color: appBrownColor, fontSize: 24.sp),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Title',
                      hintStyle: TextStyle(
                          color: appBrownColor,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700)),
                ),
                TextField(
                  controller: _contentController,
                  style: TextStyle(
                    color: appBrownColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                  maxLines: null,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'description',
                      hintStyle: TextStyle(
                        color: appBrownColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      )),
                ),
              ],
            ),
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.standard,
                  onPressed: () async {
                    Utils.unFocusKeyboard(context);

                    // AppNavigation.push(
                    //   GoogleMapLocationPicker(
                    //     apiKey: Constant.googleApiKey,
                    //     currentLatLng: const LatLng(38.7945952, -106.5348379),
                    //     hideMapTypeButton: true,
                    //     onNext: (loc) async {
                    //       location = LocationModel(
                    //         address: loc?.formattedAddress ?? '',
                    //         lat: loc?.geometry.location.lat,
                    //         lng: loc?.geometry.location.lng,
                    //       );
                    //       log('address ${loc?.formattedAddress}');
                    //       log('lat ${loc?.geometry.location.lat}');
                    //       log('long ${loc?.geometry.location.lng}');
                    //       setState(() {});

                    //       AppNavigation.pop();
                    //     },
                    //   ),
                    // );
                  },
                  icon: SvgPicture.asset(
                    'assets/post_location_icon.svg',
                    width: 18.w,
                    height: 18.h,
                  ),
                ),
                // SizedBox(
                //   width: 15.w,
                // ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(right: 15.w),
                    child: BigText(
                      textAlign: TextAlign.start,
                      text: location?.address ?? "",
                      // location?.address ?? 'Pick Location',
                      size: 12.sp,
                      color: appBlackColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // SizedBox(
          //   height: 15.h,
          // ),
          Row(
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.standard,
                onPressed: () {},
                icon:
                    //  SvgPicture.asset(
                    //   'assets/edit_note_sun_icon.svg',
                    //   width: 20.w,
                    //   height: 16.h,
                    // ),
                    Icon(
                  Utils.getWeatherIcon(
                    widget.isEdit
                        ? widget.journal?.weather?.split(' with').first
                        : wheather?.weather?[0].main,
                    widget.isEdit
                        ? widget.journal?.weather?.split(',').last
                        : wheather?.weather?[0].icon,
                  ),
                  color: appLightGreenColor,
                  size: 20.w,
                ),
              ),
              BigText(
                text: widget.isEdit
                    ? widget.journal?.weather?.split(',').first ?? ''
                    : '${wheather?.weather?[0].main ?? ""} with temp : ${wheather?.main?.temp?.round() ?? "0"}°',
                // 'Breezy with hazy sun Hi: 31°',
                size: 12.sp,
                fontWeight: FontWeight.w600,
                color: appBlackColor,
              ),
            ],
          ),
          const Spacer(),
          Builder(builder: (index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // SvgPicture.asset('assets/delete_icon.svg', width: 20.w,height: 22.h,),
                IconButton(
                    onPressed: () {
                      if (_titleController.text.isEmpty) {
                        AppDialogs.showToast(
                            message: 'Title field is required');
                      } else if (_contentController.text.isEmpty) {
                        AppDialogs.showToast(
                            message: 'Description field is required');
                      } else {
                        Utils.unFocusKeyboard(context);

                        widget.isEdit
                            ? UpdatejournalingBloc().updatejournalingBlocMethod(
                                context: context,
                                setProgressBar: () {
                                  AppDialogs.progressAlertDialog(
                                      context: context);
                                },
                                id: widget.journal?.id,
                                title: _titleController.text,
                                description: _contentController.text,
                              )
                            : AddjournalingBloc().addjournalingBlocMethod(
                                context: context,
                                setProgressBar: () {
                                  AppDialogs.progressAlertDialog(
                                      context: context);
                                },
                                title: _titleController.text,
                                description: _contentController.text,
                                location: location,
                                weather:
                                    '${wheather?.weather?[0].main ?? ""} with temp : ${wheather?.main?.temp?.round() ?? "0"}°,${wheather?.weather?[0].icon}');
                      }
                    },
                    icon: SvgPicture.asset(
                      'assets/add_notes_brown_filled.svg',
                      width: 25.w,
                      height: 25.h,
                    )),
              ],
            );
          }),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }

  // Future<dynamic> confirmDialog(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           backgroundColor: appButtonColor,
  //           contentPadding: EdgeInsets.all(0),
  //           content: SizedBox(
  //             height: 180,
  //             width: MediaQuery.of(context).size.width * 0.9,
  //             child: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Column(
  //                 children: [
  //                   Row(
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       SvgPicture.asset('assets/delete_icon.svg'),
  //                       SizedBox(
  //                         width: 10.w,
  //                       ),
  //                       BigText(
  //                         text: 'Delete your Dear Season',
  //                         size: 10.sp,
  //                         color: appBrownColor,
  //                       ),
  //                     ],
  //                   ),
  //                   Divider(),
  //                   Spacer(),
  //                   BigText(
  //                     text: 'Are you sure you want to delete this Dear Season?',
  //                     size: 10.sp,
  //                     fontWeight: FontWeight.w500,
  //                     color: appBrownColor,
  //                   ),
  //                   Spacer(),
  //                   Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                       children: [
  //                         GestureDetector(
  //                           onTap: () {
  //                             Navigator.pop(context, false);
  //                           },
  //                           child: Container(
  //                               padding: const EdgeInsets.all(6),
  //                               width: 130.w,
  //                               decoration: BoxDecoration(
  //                                 border: Border.all(color: appBrownColor),
  //                                 color: Colors.transparent,
  //                                 borderRadius:
  //                                 BorderRadius.all(Radius.circular(38)),
  //                               ),
  //                               child: BigText(
  //                                 text: 'Cancel',
  //                                 size: 12.sp,
  //                                 textAlign: TextAlign.center,
  //                                 color: appBrownColor,
  //                                 fontWeight: FontWeight.w600,
  //                               )),
  //                         ),
  //                         GestureDetector(
  //                           onTap: () {
  //                             Navigator.pop(context, true);
  //                           },
  //                           child: Container(
  //                               padding: const EdgeInsets.all(6),
  //                               width: 130.w,
  //                               decoration: BoxDecoration(
  //                                 color: appBrownColor,
  //                                 borderRadius:
  //                                 BorderRadius.all(Radius.circular(38.r)),
  //                               ),
  //                               child: BigText(
  //                                 text: 'Delete',
  //                                 size: 12.sp,
  //                                 textAlign: TextAlign.center,
  //                                 color: appWhiteColor,
  //                                 fontWeight: FontWeight.w600,
  //                               )),
  //                         ),
  //                       ]),
  //                   Spacer(),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       });
  // }
}
