import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../model/note.dart';
import '../../utils/colors.dart';
import '../../widgets/big_text.dart';

class EditScreen extends StatefulWidget {
  final Note? note;
  const EditScreen({super.key, this.note});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  List<Note> filteredNotes = [];
  //  void  deleteNote(index) {
  //   setState(() {
  //     Note note = filteredNotes[index];
  //     sampleNotes.remove(note);
  //     filteredNotes.removeAt(index);
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    if (widget.note != null) {
      _titleController = TextEditingController(text: widget.note!.title);
      _contentController = TextEditingController(text: widget.note!.content);
    }

    super.initState();
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
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 23.sp,
                    color: Colors.black,
                  ))),
        ),
        title: BigText(
          text: 'Hunting Journal',
          size: 16.sp,
          fontWeight: FontWeight.w700,
        ),
        titleSpacing: -10,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () async {
                  // final result = await confirmDialog(context);
                  // if (result != null && result) {
                  //   deleteNote(index);
                  // }
                },
                child: const Icon(
                  Icons.more_vert,
                  color: appBrownColor,
                )),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView(
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
            Row(
              children: [
                SvgPicture.asset(
                  'assets/post_location_icon.svg',
                  width: 18.w,
                  height: 18.h,
                ),
                SizedBox(
                  width: 15.w,
                ),
                BigText(
                  text: 'Sierra National Forest',
                  size: 12.sp,
                  color: appBlackColor,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/edit_note_sun_icon.svg',
                  width: 20.w,
                  height: 16.h,
                ),
                SizedBox(
                  width: 15.w,
                ),
                BigText(
                  text: 'Breezy with hazy sun Hi: 31°',
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
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context,
                            [_titleController.text, _contentController.text]);
                      },
                      child: SvgPicture.asset(
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
