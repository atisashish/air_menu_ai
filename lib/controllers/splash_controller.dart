import 'dart:async';

import 'package:air_menu_ai_app/app/auth_screen/phone_number_screen.dart';
import 'package:air_menu_ai_app/app/dash_board_screens/dash_board_screen.dart';
import 'package:air_menu_ai_app/constant/show_toast_dialog.dart';
import 'package:air_menu_ai_app/utils/preference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Timer(const Duration(seconds: 3), () => redirectScreen());
    super.onInit();
  }

  redirectScreen() async {
    bool isLogin = await SharedPrefs.getLogin();
    if (isLogin) {
      Get.offAll(const DashBoardScreen());
      // Future.delayed(Duration(milliseconds: 300), () {
      //   showOrderPopup();
      // });
    } else {
      Get.offAll(const PhoneNumberScreen());
    }
  }

  void showOrderPopup() {
    Get.defaultDialog(
      barrierDismissible: false,
      backgroundColor: Colors.white,
      title: "",
      content: WillPopScope(
        onWillPop: () async => false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/icons/logo_horizontal.png",
                width: 100,
                height: 100,
              ),
              Text(
                "How Would You Like To Order?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Get.back();
                  ShowToastDialog.showToast("Dine-in selected");
                },
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.redAccent,
                      child: Icon(
                        Icons.restaurant,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Dine-in",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Get.back();
                  ShowToastDialog.showToast("Home Delivery/Takeaway selected");
                },
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.orangeAccent,
                      child: Icon(
                        Icons.shopping_bag,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Home Delivery / Takeaway",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
      radius: 10,
    );
  }
}
