import 'package:air_menu_ai_app/constant/show_toast_dialog.dart';
import 'package:air_menu_ai_app/controllers/dash_board_controller.dart';
import 'package:air_menu_ai_app/themes/app_them_data.dart';
import 'package:air_menu_ai_app/utils/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return GetX(
      init: DashBoardController(),
      builder: (controller) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: Colors.white,
          ),
          child: PopScope(
            canPop: controller.canPopNow.value,
            onPopInvoked: (didPop) {
              final now = DateTime.now();
              if (controller.currentBackPressTime == null ||
                  now.difference(controller.currentBackPressTime!) >
                      const Duration(seconds: 2)) {
                controller.currentBackPressTime = now;
                controller.canPopNow.value = false;
                ShowToastDialog.showToast("Double press to exit");
                return;
              } else {
                controller.canPopNow.value = true;
              }
            },
            child: Scaffold(
              body: controller.pageList[controller.selectedIndex.value],
              bottomNavigationBar: Container(
                height: 80,
                decoration: BoxDecoration(
                  color:
                      themeChange.getThem()
                          ? AppThemeData.grey900
                          : AppThemeData.grey50,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Home Button
                    IconButton(
                      icon: Icon(
                        Icons.home,
                        size: 35,
                        color:
                            controller.selectedIndex.value == 0
                                ? Colors.red.shade400
                                : AppThemeData.grey600,
                      ),
                      onPressed: () => controller.selectedIndex.value = 0,
                    ),

                    // Centered Scan Button (not floating)
                    Material(
                      shape: const CircleBorder(),
                      color: Colors.red.shade400,
                      child: InkWell(
                        onTap: () {
                          controller.selectedIndex.value = 1;
                        },
                        customBorder: const CircleBorder(),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Icon(
                            Icons.qr_code_scanner,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                      ),
                    ),

                    // Profile Button
                    IconButton(
                      icon: Icon(
                        Icons.person,
                        size: 35,
                        color:
                            controller.selectedIndex.value == 2
                                ? Colors.red.shade400
                                : AppThemeData.grey600,
                      ),
                      onPressed: () => controller.selectedIndex.value = 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
