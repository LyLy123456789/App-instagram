import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ly/routes/app_routes.dart';

class DashboardController extends GetxController {
  var tabIndex = 0;
  late Rx<User?> _user;
  var firebaseAuth = FirebaseAuth.instance;

  // @override
  // void onInit() {
  //   super.onInit();
  //   _user = Rx<User?>(firebaseAuth.currentUser);
  //   _user.bindStream(firebaseAuth.authStateChanges());
  //   ever(_user, _setInitialScreen);
  // }

  // _setInitialScreen(User? user) {
  //   if (user == null) {
  //     Get.offAndToNamed(AppRoutes.LOGIN);
  //   } else {
  //     Get.offAndToNamed(AppRoutes.DASHBOARD);
  //   }
  // }

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }
}
