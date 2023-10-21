import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ly/page/create/confirm/confirm_page.dart';
import 'package:ly/page/create/create_controller.dart';

class CreatePage extends GetWidget<CreateController> {
  var controller = Get.put(CreateController());
  var _descriptionController = TextEditingController();
  Uint8List? file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: Get.width * 0.85,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              renderSelectImage(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget renderSelectImage(context) {
    return Column(
      children: [
        Icon(Icons.image),
        TextButton(
            onPressed: () => _selectImage(context),
            child: Text('Tải ảnh lên')),
      ],
    );
  }

  _selectImage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Create a Post'),
          children: <Widget>[
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Get.back();
                  var _file = await pickImage(ImageSource.camera);
                  if (_file != null) {
                    Get.to(() => ConfirmPage(
                          image: _file,
                        ));
                  }
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Get.back();
                  var _file = await pickImage(ImageSource.gallery);
                  if (_file != null) {
                    Get.to(() => ConfirmPage(
                          image: _file,
                        ));
                  }
                }),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Get.back();
              },
            )
          ],
        );
      },
    );
  }

  pickImage(ImageSource source) async {
    final ImagePicker _imagepicker = ImagePicker();

    XFile? _file = await _imagepicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    print('No images select');
  }
}
