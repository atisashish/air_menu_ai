import 'package:air_menu_ai_app/app/profile_screen/order_list_screen.dart';
import 'package:air_menu_ai_app/constant/constant.dart';
import 'package:air_menu_ai_app/constant/show_toast_dialog.dart';
import 'package:air_menu_ai_app/controllers/my_profile_controller.dart';
import 'package:air_menu_ai_app/themes/app_them_data.dart';
import 'package:air_menu_ai_app/themes/custom_dialog_box.dart';
import 'package:air_menu_ai_app/themes/responsive.dart';
import 'package:air_menu_ai_app/utils/dark_theme_provider.dart';
import 'package:air_menu_ai_app/utils/preference.dart';
import 'package:air_menu_ai_app/utils/preferences.dart';
import 'package:air_menu_ai_app/widget/webview_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      backgroundColor:
          themeChange.getThem()
              ? AppThemeData.surfaceDark
              : AppThemeData.surface,
      body: GetX(
        init: MyProfileController(),
        builder: (controller) {
          return controller.isLoading.value
              ? Constant.loader()
              : Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).viewPadding.top,
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "My Profile".tr,
                          style: TextStyle(
                            fontSize: 24,
                            color:
                                themeChange.getThem()
                                    ? AppThemeData.grey50
                                    : AppThemeData.grey900,
                            fontFamily: AppThemeData.semiBold,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Manage your personal information, preferences, and settings all in one place."
                              .tr,
                          style: TextStyle(
                            fontSize: 16,
                            color:
                                themeChange.getThem()
                                    ? AppThemeData.grey50
                                    : AppThemeData.grey900,
                            fontFamily: AppThemeData.regular,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Text(
                        //   "General Information".tr,
                        //   style: TextStyle(
                        //     fontSize: 12,
                        //     color: themeChange.getThem()
                        //         ? AppThemeData.grey400
                        //         : AppThemeData.grey500,
                        //     fontFamily: AppThemeData.semiBold,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // Container(
                        //   width: Responsive.width(100, context),
                        //   decoration: ShapeDecoration(
                        //     color: themeChange.getThem()
                        //         ? AppThemeData.grey900
                        //         : AppThemeData.grey50,
                        //     shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(8)),
                        //   ),
                        //   child: Padding(
                        //     padding: const EdgeInsets.symmetric(
                        //         horizontal: 10, vertical: 8),
                        //     child: Column(
                        //       children: [
                        //         Constant.userModel == null
                        //             ? const SizedBox()
                        //             : cardDecoration(
                        //                 themeChange,
                        //                 controller,
                        //                 "assets/images/ic_profile.svg",
                        //                 "Profile Information".tr, () {
                        //                 Get.to(const EditProfileScreen());
                        //               }),
                        //         // if (Constant.isEnabledForair_menu_ai_app == true)
                        //         //   cardDecoration(
                        //         //       themeChange,
                        //         //       controller,
                        //         //       "assets/images/ic_dinin.svg",
                        //         //       "Dine-In".tr, () {
                        //         //     Get.to(const DineInScreen());
                        //         //   }),
                        //         // cardDecoration(
                        //         //     themeChange,
                        //         //     controller,
                        //         //     "assets/images/ic_gift.svg",
                        //         //     "Gift Card".tr, () {
                        //         //   Get.to(const GiftCardScreen());
                        //         // }),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Orders Information",
                              style: TextStyle(
                                fontSize: 12,
                                color:
                                    themeChange.getThem()
                                        ? AppThemeData.grey400
                                        : AppThemeData.grey500,
                                fontFamily: AppThemeData.semiBold,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: Responsive.width(100, context),
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
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                child: Column(
                                  children: [
                                    cardDecoration(
                                      themeChange,
                                      controller,
                                      "assets/icons/ic_orders.svg",
                                      "Orders",
                                      color: AppThemeData.primary300,
                                      () {
                                        Get.to(const OrderListScreen());
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Preferences".tr,
                          style: TextStyle(
                            fontSize: 12,
                            color:
                                themeChange.getThem()
                                    ? AppThemeData.grey400
                                    : AppThemeData.grey500,
                            fontFamily: AppThemeData.semiBold,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: Responsive.width(100, context),
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            child: Column(
                              children: [
                                // cardDecoration(
                                //     themeChange,
                                //     controller,
                                //     "assets/icons/ic_change_language.svg",
                                //     "Change Language".tr, () {
                                //   ShowToastDialog.showToast(
                                //     "We Are Working On it..",
                                //   );
                                //   // Get.to(const ChangeLanguageScreen());
                                // }),
                                cardDecoration(
                                  themeChange,
                                  controller,
                                  "assets/icons/ic_light_dark.svg",
                                  "Dark Mode".tr,
                                  () {},
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Social".tr,
                          style: TextStyle(
                            fontSize: 12,
                            color:
                                themeChange.getThem()
                                    ? AppThemeData.grey400
                                    : AppThemeData.grey500,
                            fontFamily: AppThemeData.semiBold,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: Responsive.width(100, context),
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            child: Column(
                              children: [
                                // cardDecoration(
                                //   themeChange,
                                //   controller,
                                //   "assets/icons/ic_refer.svg",
                                //   "Refer a Friend",
                                //   () {},
                                // ),
                                cardDecoration(
                                  themeChange,
                                  controller,
                                  "assets/icons/ic_share.svg",
                                  "Share app",
                                  () {
                                    Share.share(
                                      'Check out air_menu_ai_app, your ultimate food delivery application! \n\nGoogle Play: ${Constant.googlePlayLink} \n\nApp Store: ${Constant.appStoreLink}',
                                      subject: 'Look what I made!',
                                    );
                                  },
                                ),
                                cardDecoration(
                                  themeChange,
                                  controller,
                                  "assets/icons/ic_rate.svg",
                                  "Rate the app",
                                  () {
                                    ShowToastDialog.showToast(
                                      "We Are Working On it..",
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Legal".tr,
                          style: TextStyle(
                            fontSize: 12,
                            color:
                                themeChange.getThem()
                                    ? AppThemeData.grey400
                                    : AppThemeData.grey500,
                            fontFamily: AppThemeData.semiBold,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: Responsive.width(100, context),
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            child: Column(
                              children: [
                                cardDecoration(
                                  themeChange,
                                  controller,
                                  "assets/icons/ic_privacy_policy.svg",
                                  "Privacy Policy",
                                  () {
                                    Get.to(PrivacyPolicyView());
                                  },
                                ),
                                cardDecoration(
                                  themeChange,
                                  controller,
                                  "assets/icons/ic_tearm_condition.svg",
                                  "Terms and Conditions",
                                  () {
                                    Get.to(TermsAndConditionsView());
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: 10),
                        Container(
                          width: Responsive.width(100, context),
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            child: Column(
                              children: [
                                cardDecoration(
                                  themeChange,
                                  controller,
                                  "assets/icons/ic_logout.svg",
                                  "Log out",
                                  () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CustomDialogBox(
                                          title: "Log out".tr,
                                          descriptions:
                                              "Are you sure you want to log out? You will need to enter your credentials to log back in."
                                                  .tr,
                                          positiveString: "Log out".tr,
                                          negativeString: "Cancel".tr,
                                          positiveClick: () async {
                                            SharedPrefs.prefsDataClear();
                                          },
                                          negativeClick: () {
                                            Get.back();
                                          },
                                          img: Image.asset(
                                            'assets/images/ic_logout.gif',
                                            height: 50,
                                            width: 50,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialogBox(
                                    title: "Delete Account".tr,
                                    descriptions:
                                        "Are you sure you want to delete your account? This action is irreversible and will permanently remove all your data."
                                            .tr,
                                    positiveString: "Delete".tr,
                                    negativeString: "Cancel".tr,
                                    positiveClick: () async {
                                      SharedPrefs.prefsDataClear();
                                    },
                                    negativeClick: () {
                                      Get.back();
                                    },
                                    img: Image.asset(
                                      'assets/icons/delete_dialog.gif',
                                      height: 50,
                                      width: 50,
                                    ),
                                  );
                                },
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset("assets/icons/ic_delete.svg"),
                                const SizedBox(width: 10),
                                Text(
                                  "Delete Account".tr,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: AppThemeData.medium,
                                    fontSize: 16,
                                    color:
                                        themeChange.getThem()
                                            ? AppThemeData.danger300
                                            : AppThemeData.danger300,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Center(
                        //   child: Text(
                        //     "V : ${Constant.appVersion}",
                        //     textAlign: TextAlign.center,
                        //     style: TextStyle(
                        //       fontFamily: AppThemeData.medium,
                        //       fontSize: 14,
                        //       color: themeChange.getThem()
                        //           ? AppThemeData.grey50
                        //           : AppThemeData.grey900,
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
              );
        },
      ),
    );
  }

  cardDecoration(
    themeChange,
    MyProfileController controller,
    String image,
    String title,
    Function()? onPress, {
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          onPress!();
        },
        child: Row(
          children: [
            SvgPicture.asset(
              image,
              colorFilter:
                  title == "Log In".tr
                      ? const ColorFilter.mode(
                        AppThemeData.success500,
                        BlendMode.srcIn,
                      )
                      : null,
              color: color,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title.tr,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: AppThemeData.medium,
                  fontSize: 16,
                  color:
                      title == "Log out".tr
                          ? AppThemeData.danger300
                          : title == "Log In".tr
                          ? AppThemeData.success500
                          : themeChange.getThem()
                          ? AppThemeData.grey100
                          : AppThemeData.grey800,
                ),
              ),
            ),
            title == "Dark Mode".tr
                ? Transform.scale(
                  scale: 0.8,
                  child: CupertinoSwitch(
                    value: controller.isDarkModeSwitch.value,
                    activeColor: AppThemeData.primary300,
                    onChanged: (value) {
                      controller.isDarkModeSwitch.value = value;
                      if (controller.isDarkModeSwitch.value == true) {
                        Preferences.setString(Preferences.themKey, "Dark");
                        themeChange.darkTheme = 0;
                      } else if (controller.isDarkMode.value == "Light") {
                        Preferences.setString(Preferences.themKey, "Light");
                        themeChange.darkTheme = 1;
                      } else {
                        Preferences.setString(Preferences.themKey, "");
                        themeChange.darkTheme = 2;
                      }
                    },
                  ),
                )
                : const Icon(Icons.keyboard_arrow_right),
          ],
        ),
      ),
    );
  }
}
