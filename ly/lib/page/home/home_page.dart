import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ly/page/home/comment/comment_page.dart';
import 'package:ly/page/home/home_controller.dart';
import 'package:ly/page/profile/profile_page.dart';
import 'package:ly/utils/like_animation.dart';

class HomePage extends GetWidget<HomeController> {
  var controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _renderAppbar(),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('posts').snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (ctx, index) => Column(
                        children: [
                          renderPost(
                            snapshot.data!.docs[index]
                                .data()['profImage']
                                .toString(),
                            snapshot.data!.docs[index]
                                .data()['username']
                                .toString(),
                            snapshot.data!.docs[index].data()['uid'].toString(),
                            snapshot.data!.docs[index]
                                .data()['postUrl']
                                .toString(),
                            snapshot.data!.docs[index]
                                .data()['postId']
                                .toString(),
                            snapshot.data!.docs[index].data()['uid'].toString(),
                            snapshot.data!.docs[index].data()['likes'],
                          )
                        ],
                      ));
            }));
  }

  _renderAppbar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text('Instagram', style: TextStyle(color: Colors.black)),
      actions: [
        IconButton(
            onPressed: () {}, icon: Icon(Icons.favorite), color: Colors.black),
        IconButton(
            onPressed: () {}, icon: Icon(Icons.message), color: Colors.black),
      ],
    );
  }

  Widget renderPost(
      urlInfo, urlInfoName, uidUser, urlImage, postId, uid, likes) {
    return Column(
      children: [
        renderInfo(urlInfo, urlInfoName, uidUser),
        renderImage(urlImage),
        renderInteractPost(postId, uid, likes),
      ],
    );
  }

  Widget renderInfo(urlInfo, urlInfoName, uidUser) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(urlInfo),
            ),
            SizedBox(
              width: Get.width * 0.02,
            ),
            TextButton(
              onPressed: () {
                Get.to(() => ProfilePage(uid: uidUser));
              },
              child: Text(urlInfoName),
            ),
          ],
        ),
        IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert_sharp))
      ],
    );
  }

  Widget renderImage(urlImage) {
    return CachedNetworkImage(
      imageUrl: urlImage,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(
        Icons.error,
      ),
    );
  }

  Widget renderInteractPost(postId, uid, likes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            LikeAnimation(
              isAnimating: likes.contains(uid),
              smallLike: true,
              child: IconButton(
                icon: likes.contains(uid)
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : const Icon(
                        Icons.favorite_border,
                      ),
                onPressed: () => controller.likePost(postId, uid, likes),
              ),
            ),
            IconButton(
                onPressed: () => Get.to(() => CommentPage(postId: postId)),
                icon: const Icon(Icons.comment_outlined)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.send)),
          ],
        ),
        Center(
          child: SizedBox(
              width: Get.width * 0.92, child: Text('${likes.length} likes')),
        )
      ],
    );
  }
}
