import 'package:air_menu_ai_app/controllers/splash_controller.dart';
import 'package:air_menu_ai_app/themes/app_them_data.dart';
import 'package:air_menu_ai_app/utils/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red.shade300, Colors.red.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Air Menu Ai".tr,
                    style: TextStyle(
                      color:
                          themeChange.getThem()
                              ? AppThemeData.grey50
                              : AppThemeData.grey50,
                      fontSize: 35,
                      fontFamily: AppThemeData.bold,
                    ),
                  ),
                  Text(
                    "Your Favorite Food Delivered Fast!".tr,
                    style: TextStyle(
                      color:
                          themeChange.getThem()
                              ? AppThemeData.grey50
                              : AppThemeData.grey50,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
