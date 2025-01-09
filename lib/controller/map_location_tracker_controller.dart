import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'dart:ui' as ui;
import '../model/user.dart';
import '../widgets/logs.dart';

class MapLocationTrackerController extends GetxController {
  late Completer<GoogleMapController> controller = Completer();
  loc.LocationData? currentLocation;
  late BitmapDescriptor pinLocationIcon;
  final Set<Marker> markers = {};
  final Set<Circle> circles = {};
  double radiusInMeters = 1000;
  int nearbyUserCount = 0;
  int count = 0;
  var selectedUser = Rxn<UserInfo>();

  // UserInfo ? selectedUser ;
  //= Rxn<UserInfo>();

  void getCurrentLocation() async {
    loc.Location location = loc.Location();
    location.getLocation().then(
      (location) {
        currentLocation = location;
        update();
      },
    );

    GoogleMapController googleMapController = await controller.future;
    location.onLocationChanged.listen(
      (newLoc) {
        currentLocation = newLoc;
        update();

        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 13.5,
              target: LatLng(
                currentLocation!.latitude!,
                currentLocation!.longitude!,
              ),
            ),
          ),
        );
        logs('currentLocation $currentLocation');
      },
    );
  }

  void setCustomMarkerIcon() async {
    // pinLocationIcon = await BitmapDescriptor.fromAssetImage(
    //     ImageConfiguration(size: Size(100,200)), 'assets/map_marker.png', );
    //
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration(
        size: Size(
          48,
          48,
        ),
      ),
      'assets/map_marker.png',
    ).then((onValue) {
      pinLocationIcon = onValue;
    });
  }

  void setMarkers() {
    markers.clear();
    // Example users
    List<UserInfo> users = [
      UserInfo(
          name: 'John Doe',
          email: 'johndoe@example.com',
          profileImageUrl:
              'https://images.unsplash.com/photo-1517524206127-48bbd363f3d7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8bWVjaGFuaWN8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=900&q=60',
          location: LatLng(24.877863388678392, 67.0667027515407)),
      UserInfo(
          name: 'John ',
          email: 'john@example.com',
          profileImageUrl:
              'https://plus.unsplash.com/premium_photo-1674375348357-a25140a68bbd?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8bWVjaGFuaWN8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=900&q=60',
          location: LatLng(24.872194469162352, 67.07235366994789)),
      UserInfo(
          name: 'Sam Smith',
          email: 'samsmith@example.com',
          profileImageUrl:
              'https://images.unsplash.com/photo-1599474151975-1f978922fa02?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fG1lY2hhbmljfGVufDB8fDB8fHww&auto=format&fit=crop&w=900&q=60',
          location: LatLng(24.86282291222152, 67.0796842334993)),
      UserInfo(
          name: 'Chris Smith',
          email: 'chrissmith@example.com',
          profileImageUrl:
              'https://images.unsplash.com/photo-1599474151975-1f978922fa02?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fG1lY2hhbmljfGVufDB8fDB8fHww&auto=format&fit=crop&w=900&q=60',
          location: LatLng(24.865396358831063, 67.08821122225692)),
      UserInfo(
          name: 'Jos Butler',
          email: 'josbutler@example.com',
          profileImageUrl:
              'https://plus.unsplash.com/premium_photo-1677009539137-fd41e4219eab?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fG1lY2hhbmljfGVufDB8fDB8fHww&auto=format&fit=crop&w=900&q=60',
          location: LatLng(25.04606678676751, 67.06074553789753)),

      // LatLng(24.877863388678392, 67.0667027515407),
      // LatLng(24.872194469162352, 67.07235366994789),
      // LatLng(24.86282291222152, 67.0796842334993),
      // LatLng(24.865396358831063, 67.08821122225692), // Outside the radius
      // LatLng(25.04606678676751, 67.06074553789753), // Outside the radius
    ];

    markers.add(Marker(
      markerId: const MarkerId('currentLocation'),
      position: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
    ));
    for (UserInfo user in users) {
      if (isWithinRadius(
          user.location,
          LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
          radiusInMeters)) {
        markers.add(
          Marker(
            markerId: MarkerId(user.email),
            position: user.location,
            icon: pinLocationIcon!,
            onTap: () async {
              // selectUser(null);
              await Future.delayed(Duration(milliseconds: 100), () {
                selectUser(user);
              });
            },
          ),
        );
        count++;
      }
    }
    update();
    //
    // setState(() {
    //   nearbyUserCount = count;
    //   _setCircles();
    // });
  }

  bool isWithinRadius(LatLng point, LatLng currentLocation, double radius) {
    final distance = Geolocator.distanceBetween(
      currentLocation.latitude,
      currentLocation.longitude,
      point.latitude,
      point.longitude,
    );
    return distance <= radius;
  }

  void setCircles() {
    circles.clear();
    circles.add(
      Circle(
        circleId: CircleId('radius'),
        center: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
        radius: radiusInMeters, // in meters
        strokeColor: Colors.transparent,
        // strokeWidth: 1,
        // fillColor: Colors.blue.withOpacity(0.1),
      ),
    );
    update();
  }

  void selectUser(UserInfo? user) {
    // selectedUser = user;
    // selectedUser.value = null;
    // update();
    // Future.delayed(Duration(seconds: 2),(){
    //
    //
    // });

    selectedUser.value = user;
    print('user coming  $user');
    update();
  }

  @override
  Future<void> onInit() async {
    getCurrentLocation();
    setCustomMarkerIcon();
    controller = Completer();
    print('object new $selectUser');

    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    // getPolyPoints();
    getCurrentLocation();
    setCustomMarkerIcon();
    setCircles();
    setMarkers();
    controller = Completer();
    // TODO: implement dispose
    super.dispose();
  }
}
