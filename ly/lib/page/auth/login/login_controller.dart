import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ly/page/dashboard/dashboard_page.dart';
import 'package:ly/routes/app_routes.dart';

class LoginController extends GetxController {
  // late Rx<User?> _user;
  // var firebaseAuth = FirebaseAuth.instance;

  // @override
  // void onInit() {
  //   super.onInit();
  //   _user = Rx<User?>(firebaseAuth.currentUser);
  //   _user.bindStream(firebaseAuth.authStateChanges());
  //   ever(_user, _setInitialScreen);
  // }

  // _setInitialScreen(User? user) {
  //   if (user != null) {
  //     Get.offAndToNamed(AppRoutes.DASHBOARD);
  //   } else {}
  // }

  Future<void> login(username, password) async {
    try {
      var UserCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: username, password: password);
      if (UserCredential.user?.uid != null) {
        Get.snackbar('Login', 'Success');
        Get.offAndToNamed(AppRoutes.DASHBOARD);
      }
    } catch (e) {
      print(e);
    }
  }
}
