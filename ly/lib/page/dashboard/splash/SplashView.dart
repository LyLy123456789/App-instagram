import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ly/page/dashboard/splash/splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Get.put(SplashController());
    });
    return const Scaffold(
      body: Center(child: CircularProgressIndicator())
    );
  }
}
