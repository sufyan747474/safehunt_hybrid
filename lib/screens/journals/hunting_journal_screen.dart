import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../model/note.dart';
import '../../utils/colors.dart';
import '../../widgets/big_text.dart';
import 'journal_edit_notes.dart';
import 'dart:math' as math;

class HuntingJournalScreen extends StatefulWidget {
  const HuntingJournalScreen({super.key});

  @override
  State<HuntingJournalScreen> createState() => _HuntingJournalScreenState();
}

class _HuntingJournalScreenState extends State<HuntingJournalScreen> {
  List<Note> filteredNotes = [];
  bool sorted = false;
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    filteredNotes = sampleNotes;
  }

  List<Note> sortNotesByModifiedTime(List<Note> notes) {
    if (sorted) {
      notes.sort((a, b) => a.modifiedTime.compareTo(b.modifiedTime));
    } else {
      notes.sort((b, a) => a.modifiedTime.compareTo(b.modifiedTime));
    }

    sorted = !sorted;

    return notes;
  }

  // getRandomColor() {
  //   Random random = Random();
  //   return backgroundColors[random.nextInt(backgroundColors.length)];
  // }

  void onSearchTextChanged(String searchText) {
    setState(() {
      filteredNotes = sampleNotes
          .where((note) =>
              note.content.toLowerCase().contains(searchText.toLowerCase()) ||
              note.title.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  void deleteNote(int index) {
    setState(() {
      Note note = filteredNotes[index];
      sampleNotes.remove(note);
      filteredNotes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: subscriptionCardColor,
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
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(55.0.h),
          child: Padding(
            padding: EdgeInsets.only(
              top: 2.0.h,
              bottom: 20.0.h,
              left: 15.0.w,
              right: 15.0.w,
            ),
            child: TextField(
              onChanged: onSearchTextChanged,
              style: TextStyle(
                fontSize: 12.sp,
                color: appBrownColor,
              ),
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
                hintText: "Search",
                hintStyle: TextStyle(color: appBrownColor, fontSize: 12.sp),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    'assets/search_icon.svg',
                  ),
                ),
                fillColor: subscriptionCardColor,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
            itemCount: filteredNotes.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          EditScreen(note: filteredNotes[index]),
                    ),
                  );
                  if (result != null) {
                    setState(() {
                      int originalIndex =
                          sampleNotes.indexOf(filteredNotes[index]);

                      sampleNotes[originalIndex] = Note(
                          id: sampleNotes[originalIndex].id,
                          title: result[0],
                          content: result[1],
                          modifiedTime: DateTime.now());

                      filteredNotes[index] = Note(
                          id: filteredNotes[index].id,
                          title: result[0],
                          content: result[1],
                          modifiedTime: DateTime.now());
                    });
                  }
                },
                child: Card(
                  margin: const EdgeInsets.only(bottom: 20),
                  color: appButtonColor,
                  // elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BigText(
                              text: '${filteredNotes[index].title} \n',
                              size: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: appBrownColor,
                            ),
                            GestureDetector(
                                onTap: () async {
                                  final result = await confirmDialog(context);
                                  if (result != null && result) {
                                    deleteNote(index);
                                  }
                                },
                                child: const Icon(Icons.more_vert)),
                          ],
                        ),
                        SizedBox(
                          height: 5.0.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(
                              text: DateFormat('d/MM/yyyy')
                                  .format(filteredNotes[index].modifiedTime),
                              size: 10.sp,
                              color: appBlackColor,
                              fontWeight: FontWeight.w400,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                                child: BigText(
                              text: filteredNotes[index].content,
                              maxLine: 2,
                              size: 10.sp,
                              color: appBrownColor,
                            ))
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/post_location_icon.svg',
                              width: 15.w,
                              height: 15.h,
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            BigText(
                              text: 'Sierra National Forest',
                              size: 8.sp,
                            ),
                            SizedBox(
                              width: 50.w,
                            ),
                            SvgPicture.asset(
                              'assets/edit_note_sun_icon.svg',
                              width: 20.w,
                              height: 16.h,
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            BigText(
                              text: 'Sierra National Forest',
                              size: 8.sp,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )),
          SizedBox(
            height: 70.h,
          ),
        ],
      ),
      bottomSheet: Container(
        height: MediaQuery.of(context).size.height * 0.09,
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          color: appLightGreenColor.withOpacity(0.8),
        ),
        child: Row(
          children: [
            const Spacer(),
            BigText(
              text: '14 notes',
              size: 10.sp,
              fontWeight: FontWeight.w700,
              color: appButtonColor,
            ),
            const Spacer(),
            GestureDetector(
                onTap: () async {
                  final result = await Get.to(const EditScreen());
                  // await Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (BuildContext context) => const EditScreen(),
                  //   ),
                  // );

                  if (result != null) {
                    setState(() {
                      sampleNotes.add(Note(
                          id: sampleNotes.length,
                          title: result[0],
                          content: result[1],
                          modifiedTime: DateTime.now()));
                      filteredNotes = sampleNotes;
                    });
                  }
                },
                child: SvgPicture.asset('assets/add_notes_icon.svg')),
          ],
        ),
      ),
    );
  }

  // Future<dynamic> _showPopupMenu(BuildContext context) async {
  //   await showMenu(
  //     context: context,
  //     position: RelativeRect.fromLTRB(100, 100, 100, 100),
  //     items: [
  //       PopupMenuItem(
  //         value: 1,
  //         child: Text("View"),
  //       ),
  //       PopupMenuItem(
  //         value: 2,
  //         child: Text("Edit"),
  //       ),
  //       PopupMenuItem(
  //         value: 3,
  //         child: Text("Delete"),
  //       ),
  //     ],
  //     elevation: 8.0,
  //   ).then((value){
  //
  //     // NOTE: even you didnt select item this method will be called with null of value so you should call your call back with checking if value is not null , value is the value given in PopupMenuItem
  //     if(value!=null)
  //       print(value);
  //   });
  // }

  Future<dynamic> confirmDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: appButtonColor,
            contentPadding: const EdgeInsets.all(0),
            content: SizedBox(
              height: 180,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/delete_icon.svg'),
                        SizedBox(
                          width: 10.w,
                        ),
                        BigText(
                          text: 'Delete your Dear Season',
                          size: 10.sp,
                          color: appBrownColor,
                        ),
                      ],
                    ),
                    const Divider(),
                    const Spacer(),
                    BigText(
                      text: 'Are you sure you want to delete this Dear Season?',
                      size: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: appBrownColor,
                    ),
                    const Spacer(),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context, false);
                            },
                            child: Container(
                                padding: const EdgeInsets.all(6),
                                width: 130.w,
                                decoration: BoxDecoration(
                                  border: Border.all(color: appBrownColor),
                                  color: Colors.transparent,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(38)),
                                ),
                                child: BigText(
                                  text: 'Cancel',
                                  size: 12.sp,
                                  textAlign: TextAlign.center,
                                  color: appBrownColor,
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context, true);
                            },
                            child: Container(
                                padding: const EdgeInsets.all(6),
                                width: 130.w,
                                decoration: BoxDecoration(
                                  color: appBrownColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(38.r)),
                                ),
                                child: BigText(
                                  text: 'Delete',
                                  size: 12.sp,
                                  textAlign: TextAlign.center,
                                  color: appWhiteColor,
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                        ]),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
