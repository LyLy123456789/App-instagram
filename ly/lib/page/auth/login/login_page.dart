import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ly/page/auth/login/login_controller.dart';
import 'package:ly/page/auth/register/register_page.dart';
import 'package:ly/utils/colors.dart';

class LoginPage extends GetWidget<LoginController> {
  var controller = Get.put(LoginController());
  var _txtEmailController = TextEditingController();
  var _txtPasswordController = TextEditingController();
  static const String EMAIL = 'email';
  static const String PASSWORD = 'password';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _renderAppBarChangeLanguage(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            renderIconApp(),
            const SizedBox(height: 30),
            renderInput(EMAIL),
            const SizedBox(height: 30),
            renderInput(PASSWORD),
            const SizedBox(height: 30),
            renderLoginButton(),
            renderRegister()
          ],
        ),
      ),
    );
  }

  _renderAppBarChangeLanguage() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                Get.updateLocale(Locale('vi', 'VN'));
              },
              child: const Text('Tiếng Việt')),
          const Text('|', style: TextStyle(color: Colors.black)),
          TextButton(
              onPressed: () {
                Get.updateLocale(Locale('en', 'US'));
              },
              child: const Text('English')),
        ],
      ),
    );
  }

  Widget renderIconApp() {
    return const Icon(Icons.add_a_photo_outlined, size: 70);
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

  Widget renderLoginButton() {
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
            Text(("loginTitle".tr),
                style: TextStyle(fontSize: 20, color: MyColors.WhiteColor)),
          ],
        ),
        onPressed: () => controller.login(
            _txtEmailController.text, _txtPasswordController.text),
      ),
    );
  }

  Widget renderRegister() {
    return TextButton(
        style: TextButton.styleFrom(padding: EdgeInsets.fromLTRB(0, 20, 0, 20)),
        child: Text(('registerTitle'.tr),
            style: TextStyle(
                color: MyColors.VeryDarkCyan,
                fontSize: 18,
                fontWeight: FontWeight.w500)),
        onPressed: () {
          Get.to(() => RegisterPage());
        });
  }
}
