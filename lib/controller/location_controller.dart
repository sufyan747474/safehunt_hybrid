import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../widgets/logs.dart';

class LocationController extends GetxController{
  final Completer<GoogleMapController> googleMapController = Completer();
  List<Placemark> placeMarks = [];
  List<Placemark> homeScreenPlaceMarks = [];
  bool isLoading = false;
  double lat = 0;
  double long = 0;
  CameraPosition kGooglePlex = const CameraPosition(
      target: LatLng(33.6844, 73.0479),
      zoom: 14);

  final List<Marker> markers = <Marker>[
    const Marker(
        markerId: MarkerId('1'),
        position: LatLng(33.6844, 73.0479),
        infoWindow: InfoWindow(
            title: 'The title of the marker'
        )
    )
  ];

  Future<Position> getUserCurrentPosition() async{
    await Geolocator.requestPermission().then((value) => {
    }).onError((error, stackTrace){
      throw error.toString();
    });
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> getAddress(var latitude, var longitude) async{
    logs("this is $latitude $longitude");
    homeScreenPlaceMarks = await placemarkFromCoordinates(latitude, longitude);
    update();

    logs("homeScreenPlaceMarks ${homeScreenPlaceMarks.toString()}");
    // Preferences.saveAddress("${homeScreenPlaceMarks
    //     .first
    //     .street}, ${homeScreenPlaceMarks.last
    //     .street}, ${homeScreenPlaceMarks.first
    //     .locality}, ${homeScreenPlaceMarks.first
    //     .administrativeArea}, ${homeScreenPlaceMarks.first
    //     .country}");


    lat = latitude;
    long = longitude;

    markers.add(
        Marker(
            markerId: const MarkerId('2'),
            position: LatLng(latitude, longitude),
            infoWindow: const InfoWindow(
                title: 'current location'
            )
        )
    );

    CameraPosition cameraPosition = CameraPosition(
        zoom: 14,
        target: LatLng(latitude, longitude)
    );
    final GoogleMapController controller = await googleMapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    placeMarks = await placemarkFromCoordinates(latitude, longitude);
    update();
    logs("in location controller ${placeMarks.toString()}");

    // _addressTextController.text = "${placemarks.first.country}, ${placemarks.first.locality}";
    update();
    // setState(() {
    //
    // });
  }

  @override
  void onInit() { // called after the widget is rendered on screen
    getUserCurrentPosition().then((value) {
      getAddress(value.latitude,value.longitude);
    });
    super.onInit();
  }

// @override
// void onReady() { // called after the widget is rendered on screen
//   getUserCurrentPosition().then((value) {
//     getAddress(value.latitude,value.longitude);
//   });
//   super.onReady();
// }
}