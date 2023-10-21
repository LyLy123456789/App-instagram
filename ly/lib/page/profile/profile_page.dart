import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ly/page/profile/editInfo/editInfo_page.dart';
import 'package:ly/page/profile/profile_controller.dart';

class ProfilePage extends StatefulWidget {
  final uid;
  ProfilePage({super.key, required this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var controller = Get.put(ProfileController());
  var uidPersonal = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    controller.updateUserId(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          if (controller.user.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
              appBar: _renderAppbar(),
              body: Column(
                children: [renderInfo(), renderButton(), renderPostImage()],
              ));
        });
  }

  _renderAppbar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(controller.user['username'],
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold)),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.add_box_outlined),
          color: Colors.black,
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.settings),
          color: Colors.black,
        ),
      ],
    );
  }

  Widget renderInfo() {
    return Row(
      children: [
        SizedBox(
          width: Get.width * 0.2,
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(controller.user['photoUrl']),
                radius: 30,
              ),
              Text(
                controller.user['username'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(controller.user['bio']),
            ],
          ),
        ),
        SizedBox(width: Get.width * 0.1),
        SizedBox(
          width: Get.width * 0.6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(controller.user['postlength'].toString()),
                  Text('bài viết'),
                ],
              ),
              Column(
                children: [
                  Text(controller.user['following'].toString()),
                  Text('following'),
                ],
              ),
              Column(
                children: [
                  Text(controller.user['followers'].toString()),
                  Text('followers'),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget renderButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
            onPressed: () {
              Get.to(() => EditInfoPage(uid: uidPersonal,));
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
            child: Text('Chỉnh sửa thông tin cá nhân')),
        ElevatedButton(
            onPressed: () => controller.signOut(),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Đăng xuất')),
      ],
    );
  }

  Widget renderPostImage() {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: widget.uid)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return GridView.builder(
          shrinkWrap: true,
          itemCount: (snapshot.data! as dynamic).docs.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 1.5,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            DocumentSnapshot snap = (snapshot.data! as dynamic).docs[index];

            return Container(
              child: Image(
                image: NetworkImage(snap['postUrl']),
                fit: BoxFit.cover,
              ),
            );
          },
        );
      },
    );
  }
}
