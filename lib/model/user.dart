import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserInfo {
  final String name;
  final String email;
  final String profileImageUrl;
  final LatLng location;

  UserInfo({required this.name, required this.email, required this.profileImageUrl, required this.location});
}