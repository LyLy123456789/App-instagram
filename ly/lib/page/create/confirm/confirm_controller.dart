import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:ly/models/post.dart';
import 'package:ly/page/profile/profile_controller.dart';
import 'package:ly/utils/constants.dart';
import 'package:uuid/uuid.dart';

class ConfirmController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  ProfileController profileController = Get.find();
  Future<void> uploadPost(String description, Uint8List file) async {
    try {
      String photoUrl = await uploadToStorage('posts', file);
      String postId = const Uuid().v1();
      Post post = Post(
        description: description,
        uid: _auth.currentUser!.uid,
        username: profileController.user['username'],
        likes: [],
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profImage: Constants.DEFAULT_AVATAR,
      );
      _firestore.collection('posts').doc(postId).set(post.toJson());
      Get.back();
      Get.snackbar('Post', 'Upload complete');
    } catch (e) {
      print(e);
    }
  }

  Future<String> uploadToStorage(
    String childName,
    Uint8List file,
  ) async {
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);
    String id = const Uuid().v1();
    ref = ref.child(id);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
