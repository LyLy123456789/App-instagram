import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:ly/page/profile/profile_controller.dart';

class HomeController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxBool isLikeAnimating = false.obs;

  final Rx<Map<String, dynamic>> _post = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get post => _post.value;

  ProfileController profileController = Get.find();
  @override
  void onInit() {
    super.onInit();
    getPost();
  }

  Future<void> getPost() async {
  }
  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (err) {
      print(err);
    }
  }
}
