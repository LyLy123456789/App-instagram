import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ly/page/create/confirm/confirm_controller.dart';
import 'package:ly/utils/constants.dart';

class ConfirmPage extends GetWidget<ConfirmController> {
  var controller = Get.put(ConfirmController());
  var _descriptionController = TextEditingController();
  final image;
  ConfirmPage({super.key, required this.image});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _renderAppbar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            renderInfoAndInput(),
            SizedBox(height: Get.height *0.05),
            Image(image: MemoryImage(image)),
          ],
        ),
      ),
    );
  }

  _renderAppbar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(Icons.arrow_back),
        color: Colors.black,
      ),
      title: Text(
        'Tạo bài viết mới',
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        TextButton(onPressed: () => controller.uploadPost(_descriptionController.text,image), child: Text('Đăng'))
      ],
    );
  }

  Widget renderInfoAndInput() {
    return Center(
      child: SizedBox(
        width: Get.width * 0.85,
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                    backgroundImage: NetworkImage(Constants.DEFAULT_AVATAR)),
                SizedBox(width: 10),
                Text(controller.profileController.user['username'], style: TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
            TextField(
                controller: _descriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(hintText: 'Viết 1 tiêu đề')),
          ],
        ),
      ),
    );
  }
}
