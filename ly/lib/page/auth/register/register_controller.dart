import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ly/routes/app_routes.dart';
import 'package:ly/utils/constants.dart';
import 'package:ly/models/user.dart' as models;

class RegisterController extends GetxController {
  Future<void> register(email, password) async {
    try {
      var UserCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      models.User _user = models.User(
        username: '',
        uid: UserCredential.user!.uid,
        photoUrl: Constants.DEFAULT_AVATAR,
        email: email,
        bio: '',
        followers: [],
        following: [],
      );
      await FirebaseFirestore.instance
          .collection("users")
          .doc(UserCredential.user!.uid)
          .set(_user.toJson());
      if (UserCredential.user?.uid != null) {
        Get.snackbar('Register', 'Success');
        Get.offAndToNamed(AppRoutes.DASHBOARD);
      }
    } catch (e) {
      print(e);
    }
  }
}
