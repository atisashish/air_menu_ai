import 'package:air_menu_ai_app/themes/app_them_data.dart';
import 'package:air_menu_ai_app/utils/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class OrderPlacingScreen extends StatelessWidget {
  const OrderPlacingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      backgroundColor:
          themeChange.getThem()
              ? AppThemeData.surfaceDark
              : AppThemeData.surface,
      appBar: AppBar(
        backgroundColor:
            themeChange.getThem()
                ? AppThemeData.surfaceDark
                : AppThemeData.surface,
        centerTitle: false,
        titleSpacing: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Order Placed".tr,
              textAlign: TextAlign.start,
              style: TextStyle(
                color:
                    themeChange.getThem()
                        ? AppThemeData.grey100
                        : AppThemeData.grey900,
                fontSize: 34,
                fontFamily: AppThemeData.medium,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              "Your delicious meal is on its way! Sit tight and we’ll handle the rest."
                  .tr,
              textAlign: TextAlign.start,
              style: TextStyle(
                color:
                    themeChange.getThem()
                        ? AppThemeData.grey300
                        : AppThemeData.grey600,
                fontSize: 16,
                fontFamily: AppThemeData.regular,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 40),
            Container(
              decoration: ShapeDecoration(
                color:
                    themeChange.getThem()
                        ? AppThemeData.grey900
                        : AppThemeData.grey50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/ic_location.svg",
                          colorFilter: ColorFilter.mode(
                            AppThemeData.primary300,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Order ID",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: AppThemeData.semiBold,
                              color:
                                  themeChange.getThem()
                                      ? AppThemeData.primary300
                                      : AppThemeData.primary300,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "controller.orderModel.value.id.toString()",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: AppThemeData.medium,
                        color:
                            themeChange.getThem()
                                ? AppThemeData.grey400
                                : AppThemeData.grey500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
