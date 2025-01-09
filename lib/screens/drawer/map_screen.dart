import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:safe_hunt/model/user.dart';
import '../../controller/map_location_tracker_controller.dart';
import '../../utils/colors.dart';
import '../../widgets/big_text.dart';
import '../../widgets/logs.dart';
import '../../widgets/user_info_widow.dart';
import '../journals/hunting_journal_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final bool isLoadingMap = false;

  List<String> numberRadius = ['0', '5', '10', '50', '100'];
  double zoomValue = 28.0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapLocationTrackerController>(
        init: MapLocationTrackerController(),
        builder: (mapLocationTrackerControllerObj) {
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/mapscreen.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              extendBodyBehindAppBar: true,
              extendBody: true,
              appBar: AppBar(
                leadingWidth: 85.w,
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
                elevation: 0.0,
                leading: GestureDetector(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.h),
                    child: Transform.translate(
                      offset: Offset(20.w, 0),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: appLightGreenColor,
                          borderRadius: BorderRadius.all(Radius.circular(38)),
                        ),
                        child: SvgPicture.asset('assets/hamburg_icon.svg',
                            color: Colors.white, fit: BoxFit.scaleDown),
                      ),
                    ),
                  ),
                ),
                title: Row(
                  children: [
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.to(const HuntingJournalScreen());
                      },
                      child: SizedBox(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          width: 70.w,
                          height: 35.h,
                          decoration: const BoxDecoration(
                            color: appBrownColor,
                            borderRadius: BorderRadius.all(Radius.circular(38)),
                          ),
                          child: SvgPicture.asset(
                            'assets/solar_notes-bold.svg',
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        width: 70.w,
                        height: 35.h,
                        decoration: const BoxDecoration(
                          color: appButtonColor,
                          borderRadius: BorderRadius.all(Radius.circular(38)),
                        ),
                        child: SvgPicture.asset(
                          'assets/light_add.svg',
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 4.h, horizontal: 7.w),
                        width: 70.w,
                        height: 35.h,
                        decoration: const BoxDecoration(
                          color: appRedColor,
                          borderRadius: BorderRadius.all(Radius.circular(38)),
                        ),
                        child: BigText(
                          text: 'SOS',
                          size: 20.sp,
                          color: appWhiteColor,
                          fontWeight: FontWeight.w700,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              body: SafeArea(
                  child: SingleChildScrollView(
                child: Stack(
                  children: [
                    SizedBox(
                      child: Container(
                        alignment: Alignment.center,

                        margin: const EdgeInsets.all(30),
                        height: MediaQuery.of(context).size.height * 0.69,
                        // width:double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: appBrownColor),

                          // color: Colors.brown.withOpacity(0.4),
                          borderRadius: BorderRadius.all(
                              Radius.circular(30.r)), //border corner radius
                        ),
                        child: mapLocationTrackerControllerObj
                                    .currentLocation ==
                                null
                            ? lottie.Lottie.asset(
                                'assets/animation_green_loader.json')
                            : ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.r),
                                  topRight: Radius.circular(30.r),
                                  bottomRight: Radius.circular(30.r),
                                  bottomLeft: Radius.circular(30.r),
                                ),
                                child:
                                    // MapLocationTrackerControllerObj.currentLocation==null ? CircularProgressIndicator(color: Colors.red,):
                                    SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child: Stack(
                                    children: [
                                      GoogleMap(
                                        initialCameraPosition: CameraPosition(
                                          target: LatLng(
                                              mapLocationTrackerControllerObj
                                                  .currentLocation!.latitude!,
                                              mapLocationTrackerControllerObj
                                                  .currentLocation!.longitude!),
                                          zoom: 19.5,
                                        ),
                                        markers: mapLocationTrackerControllerObj
                                            .markers,
                                        circles: mapLocationTrackerControllerObj
                                            .circles,
                                        onMapCreated: (mapController) {
                                          logs(
                                              'current location ${mapLocationTrackerControllerObj.currentLocation}');

                                          setState(() {
                                            logs(
                                                'mapLocationTrackerControllerObj.nearbyUserCount ${mapLocationTrackerControllerObj.count}');
                                            // mapController.setMapStyle('[{"featureType": "all","stylers": [{ "color": "0xFFF1F8E9" }]},{"featureType": "road.arterial","elementType": "geometry","stylers": [{ "color": "0XFF000000" }]},{"featureType": "landscape","elementType": "labels","stylers": [{ "visibility": "off" }]}]');
                                            mapLocationTrackerControllerObj
                                                    .nearbyUserCount =
                                                mapLocationTrackerControllerObj
                                                    .count;
                                            mapLocationTrackerControllerObj
                                                .setCircles();
                                            mapLocationTrackerControllerObj
                                                .controller
                                                .complete(mapController);
                                            mapLocationTrackerControllerObj
                                                .markers
                                                .add(Marker(
                                              markerId: const MarkerId('icon'),
                                              position: LatLng(
                                                  mapLocationTrackerControllerObj
                                                      .currentLocation!
                                                      .latitude!,
                                                  mapLocationTrackerControllerObj
                                                      .currentLocation!
                                                      .longitude!),
                                            ));
                                          });
                                        },
                                        onTap: (LatLng latLng) async {
                                          bool response = false;
                                          print('LatLng $LatLng');
                                          mapLocationTrackerControllerObj
                                              .selectUser(null);

                                          // if(response == true){
                                          //   Future.delayed(const Duration(seconds: 10), () async {
                                          //     setState(() {
                                          //       // Here you can write your code for open new view
                                          //       response != response;
                                          //     });
                                          //   });
                                          //   mapLocationTrackerControllerObj
                                          //       .selectUser(
                                          //       UserInfo(name: mapLocationTrackerControllerObj.selectedUser.value!.name  , email: mapLocationTrackerControllerObj.selectedUser.value!.email,profileImageUrl: mapLocationTrackerControllerObj.selectedUser.value!.profileImageUrl , location: mapLocationTrackerControllerObj.selectedUser.value!.location  )
                                          //   );
                                          //
                                          //
                                          // }else{
                                          //   setState(() {
                                          //     mapLocationTrackerControllerObj.selectUser(null);
                                          //   });
                                          //
                                          // }
                                          CameraPosition(
                                            target: LatLng(
                                                mapLocationTrackerControllerObj
                                                    .selectedUser
                                                    .value!
                                                    .location
                                                    .latitude,
                                                mapLocationTrackerControllerObj
                                                    .selectedUser
                                                    .value!
                                                    .location
                                                    .longitude),
                                            zoom: 25.0,
                                          );

                                          print('latLng ${UserInfo}');
                                        },
                                      ),
                                      Obx(() {
                                        if (mapLocationTrackerControllerObj
                                                .selectedUser.value !=
                                            null) {
                                          return Positioned(
                                            top: 150,
                                            left: 0,
                                            right: 0,
                                            bottom: 0,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(17.0),
                                              child: UserInfoWindow(
                                                  user:
                                                      mapLocationTrackerControllerObj
                                                          .selectedUser.value!),
                                            ),
                                          );
                                        } else {
                                          return SizedBox();
                                        }
                                      }),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    ),
                    Positioned(
                      left: 45,
                      right: 45,
                      top: 583,
                      child: Column(
                        children: [
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              trackHeight: 6.0,
                              activeTrackColor: appBrownColor,
                              inactiveTrackColor: appBrownColor,
                              thumbColor: appButtonColor,
                              overlayShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 9.0),
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 8.0),
                            ),
                            child: Slider(
                              //
                              activeColor: appBrownColor,
                              inactiveColor: appBrownColor,
                              thumbColor: appButtonColor,
                              value: mapLocationTrackerControllerObj
                                  .radiusInMeters,
                              // min: 100.0,

                              min: 0,
                              max: 50000,
                              divisions: mapLocationTrackerControllerObj
                                          .radiusInMeters
                                          .toInt() >=
                                      50
                                  ? 10
                                  : 20,

                              label:
                                  '${(mapLocationTrackerControllerObj.radiusInMeters / 1000).toStringAsFixed(1)} km',
                              onChanged: (value) {
                                setState(() {
                                  mapLocationTrackerControllerObj
                                      .radiusInMeters = value;
                                  mapLocationTrackerControllerObj.setMarkers();
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: List.generate(
                                numberRadius.length,
                                (index) => SizedBox(
                                  height: 8.h,
                                  child: VerticalDivider(
                                    thickness: 2,
                                    width: 4,
                                    color: appBrownColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: List.generate(
                                numberRadius.length,
                                (index) => BigText(
                                      text:
                                          ' ${(mapLocationTrackerControllerObj.radiusInMeters / 1000).toStringAsFixed(0)}m',
                                      size: 12.sp,
                                      color: appBrownColor,
                                      fontWeight: FontWeight.w700,
                                    )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
            ),
          );
        });
  }
}
