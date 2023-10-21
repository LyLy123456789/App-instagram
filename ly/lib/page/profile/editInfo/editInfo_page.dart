import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ly/page/profile/editInfo/editInfo_controller.dart';
import 'package:ly/utils/constants.dart';

class EditInfoPage extends StatefulWidget {
  final uid;
  EditInfoPage({super.key, required this.uid});

  @override
  State<EditInfoPage> createState() => _EditInfoPageState();
}

class _EditInfoPageState extends State<EditInfoPage> {
  var controller = Get.put(EditInfoController());
  Uint8List? _image;
  static const String USERNAME = 'username';
  static const String BIO = 'bio';
  var _txtUserNameController = TextEditingController();
  var _txtBioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      body: Center(
        child: Column(
          children: [
            renderChangeAvatar(),
            const SizedBox(height: 10),
            renderInput(USERNAME),
            const SizedBox(height: 10),
            renderInput(BIO),
            const SizedBox(height: 10),
            renderUpdateButton(_txtUserNameController.text,_txtBioController.text)
          ],
        ),
      ),
    );
  }

  renderAppBar() {
    return AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Chỉnh sửa trang cá nhân',
            style: TextStyle(color: Colors.black)));
  }

  Widget renderInput(type) {
    return SizedBox(
      width: Get.width * 0.85,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(12)),
        child: TextField(
          controller:
              type == USERNAME ? _txtUserNameController : _txtBioController,
          decoration: InputDecoration(
              hintText: type == USERNAME ? ('Tên người dùng') : ('Tiểu sử'),
              border: InputBorder.none),
        ),
      ),
    );
  }

  Widget renderChangeAvatar() {
    return Stack(
      children: [
        _image != null
            ? CircleAvatar(
                radius: 64,
                backgroundImage: MemoryImage(_image!),
                backgroundColor: Colors.red,
              )
            : const CircleAvatar(
                radius: 64,
                backgroundImage: NetworkImage(Constants.DEFAULT_AVATAR),
                backgroundColor: Colors.red,
              ),
        Positioned(
          bottom: -10,
          left: 80,
          child: IconButton(
            onPressed: selectImage,
            icon: const Icon(Icons.add_a_photo),
          ),
        )
      ],
    );
  }
  Widget renderUpdateButton(name,bio){
    return ElevatedButton(onPressed: (){
      // updatePhotoUrl();
      updateName(name);
      updateBio(bio);
    }, child: Text('Cập nhật'));
  }

  pickImage(ImageSource source) async {
    final ImagePicker _imagepicker = ImagePicker();

    XFile? _file = await _imagepicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    print('No images select');
  }

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
  void updatePhotoUrl() async{
    if(_image != null){
    final user = FirebaseFirestore.instance.collection('users').doc(widget.uid).set({
      'photoUrl' : _image
    });
    }
  }
  updateName(name)async{
      final user =await FirebaseFirestore.instance.collection('users').doc(widget.uid).update({
      'username' : name
    });
  }
  updateBio(bio)async{
      final user =await FirebaseFirestore.instance.collection('users').doc(widget.uid).update({
      'bio' : bio
    });
  }
}
