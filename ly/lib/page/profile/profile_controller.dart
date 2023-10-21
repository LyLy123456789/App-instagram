import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:ly/routes/app_routes.dart';

class ProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;
  Rx<String> _uid = "".obs;

  updateUserId(String uid) {
    _uid.value = uid;
    getUser(uid);
  }

  Future<void> getUser(uid) async {
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(_uid.value).get();

    var postSnap = await FirebaseFirestore.instance
        .collection('posts')
        .where('uid', isEqualTo: _uid.value)
        .get();
    int postlength = postSnap.docs.length;

    final userData = userDoc.data()! as dynamic;
    String uid = userData['uid'];
    String name = userData['username'];
    String profilePhoto = userData['photoUrl'];
    String email = userData['email'];
    int followers = userData['followers'].length;
    int following = userData['following'].length;
    String bio = userData['bio'];
    _user.value = {
      'uid': uid,
      'username': name,
      'photoUrl': profilePhoto,
      'email': email,
      'followers': followers.toString(),
      'following': following.toString(),
      'bio': bio,
      'postlength': postlength
    };
    update();
  }
  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
