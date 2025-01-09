import 'package:get/get.dart';
import '../controller/location_controller.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<LocationController>(LocationController());
    // Get.put<MapLocationTrackerController>(MapLocationTrackerController());
    // Get.lazyPut(() => ImagePickerController());
    // Get.lazyPut(() => AddGardenController());
    // // Get.put<AddGardenController>(AddGardenController());
    // Get.lazyPut(() => LoginController());
    // Get.put<CountryCodeController>(CountryCodeController());
    // Get.lazyPut(() => HomeController());
    // Get.lazyPut(() => OtpController());
    // Get.lazyPut(() => PaymentMapController());
    // Get.lazyPut(() => RegisterController());
  }
}
