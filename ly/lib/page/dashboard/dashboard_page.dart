import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ly/page/create/create_page.dart';
import 'package:ly/page/dashboard/dashboard_controller.dart';
import 'package:ly/page/home/home_page.dart';
import 'package:ly/page/notification/notifications_page.dart';
import 'package:ly/page/profile/profile_page.dart';
import 'package:ly/page/search/search_page.dart';

class DashBoardPage extends GetWidget<DashboardController> {
  var controller = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            body: SafeArea(
              child: IndexedStack(
                index: controller.tabIndex,
                children: [
                  HomePage(),
                  SearchPage(),
                  CreatePage(),
                  NotificationPage(),
                  ProfilePage(uid: FirebaseAuth.instance.currentUser!.uid,)
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: controller.changeTabIndex,
              currentIndex: controller.tabIndex,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: true,
              showUnselectedLabels: false,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home),
                  label: ('home'.tr),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: ('search'.tr),
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.plus_square),
                  label: ('create'.tr),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications),
                  label: ('notification'.tr),
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.person),
                  label: ('profile'.tr),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}