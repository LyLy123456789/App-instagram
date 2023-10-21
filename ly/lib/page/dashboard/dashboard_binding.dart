import 'package:get/get.dart';
import 'package:ly/page/create/create_controller.dart';
import 'package:ly/page/dashboard/dashboard_controller.dart';
import 'package:ly/page/home/home_controller.dart';
import 'package:ly/page/notification/notifications_controller.dart';
import 'package:ly/page/profile/profile_controller.dart';
import 'package:ly/page/search/search_controller.dart';

class DashboardBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<SearchController>(() => SearchController());
    Get.lazyPut<CreateController>(() => CreateController());
    Get.lazyPut<NotificationController>(() => NotificationController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}