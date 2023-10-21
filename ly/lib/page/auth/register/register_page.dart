import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ly/page/auth/register/register_controller.dart';
import 'package:ly/utils/colors.dart';

class RegisterPage extends GetWidget<RegisterController> {
  var controller = Get.put(RegisterController());
  var _txtEmailController = TextEditingController();
  var _txtPasswordController = TextEditingController();
  static const String EMAIL = 'email';
  static const String PASSWORD = 'password';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _renderAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          renderInput(EMAIL),
          const SizedBox(height: 30),
          renderInput(PASSWORD),
          const SizedBox(height: 30),
          renderRegisterButton(),
        ],
      ),
    );
  }

  _renderAppBar() {
    return AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          ("registerTitle".tr), style: const TextStyle(color: Colors.black),
        ));
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
              type == EMAIL ? _txtEmailController : _txtPasswordController,
          obscureText: type == EMAIL ? false : true,
          decoration: InputDecoration(
              hintText: type == EMAIL ? ('username'.tr) : ('password'.tr),
              border: InputBorder.none),
        ),
      ),
    );
  }

  Widget renderRegisterButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: ElevatedButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          side: BorderSide(width: 1, color: MyColors.VeryDarkCyan),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(("registerTitle".tr),
                style: TextStyle(fontSize: 20, color: MyColors.WhiteColor)),
          ],
        ),
        onPressed: () => controller.register(
            _txtEmailController.text, _txtPasswordController.text),
      ),
    );
  }
}
