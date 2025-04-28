import 'package:air_menu_ai_app/constant/show_toast_dialog.dart';
import 'package:air_menu_ai_app/controllers/phone_number_controller.dart';
import 'package:air_menu_ai_app/themes/app_them_data.dart';
import 'package:air_menu_ai_app/themes/text_field_widget.dart';
import 'package:air_menu_ai_app/utils/dark_theme_provider.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class PhoneNumberScreen extends StatelessWidget {
  const PhoneNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return GetX(
      init: PhoneNumberController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor:
                themeChange.getThem()
                    ? AppThemeData.surfaceDark
                    : AppThemeData.surface,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome Back! 👋".tr,
                    style: TextStyle(
                      color:
                          themeChange.getThem()
                              ? AppThemeData.grey50
                              : AppThemeData.grey900,
                      fontSize: 22,
                      fontFamily: AppThemeData.semiBold,
                    ),
                  ),
                  Text(
                    "Log in to continue enjoying delicious food delivered to your doorstep."
                        .tr,
                    style: TextStyle(
                      color:
                          themeChange.getThem()
                              ? AppThemeData.grey400
                              : AppThemeData.grey500,
                      fontSize: 16,
                      fontFamily: AppThemeData.regular,
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextFieldWidget(
                    title: 'Phone Number'.tr,
                    controller: controller.phoneNUmberEditingController.value,
                    hintText: 'Enter Phone Number'.tr,
                    textInputType: const TextInputType.numberWithOptions(
                      signed: true,
                      decimal: true,
                    ),
                    textInputAction: TextInputAction.done,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                    ],
                    prefix: CountryCodePicker(
                      initialSelection: 'IN',
                      favorite: ['+91', 'IN'],
                      onChanged: (value) {
                        controller.countryCodeEditingController.value.text =
                            value.dialCode.toString();
                      },
                      dialogTextStyle: TextStyle(
                        color:
                            themeChange.getThem()
                                ? AppThemeData.grey50
                                : AppThemeData.grey900,
                        fontWeight: FontWeight.w500,
                        fontFamily: AppThemeData.medium,
                      ),
                      dialogBackgroundColor:
                          themeChange.getThem()
                              ? AppThemeData.grey800
                              : AppThemeData.grey100,
                      // initialSelection:
                      //     controller.countryCodeEditingController.value.text,
                      comparator:
                          (a, b) => b.name!.compareTo(a.name.toString()),
                      textStyle: TextStyle(
                        fontSize: 14,
                        color:
                            themeChange.getThem()
                                ? AppThemeData.grey50
                                : AppThemeData.grey900,
                        fontFamily: AppThemeData.medium,
                      ),
                      searchDecoration: InputDecoration(
                        iconColor:
                            themeChange.getThem()
                                ? AppThemeData.grey50
                                : AppThemeData.grey900,
                      ),
                      searchStyle: TextStyle(
                        color:
                            themeChange.getThem()
                                ? AppThemeData.grey50
                                : AppThemeData.grey900,
                        fontWeight: FontWeight.w500,
                        fontFamily: AppThemeData.medium,
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),
                  controller.isLoading.value
                      ? Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                          color: AppThemeData.primary300,
                        ),
                      )
                      : RoundedButtonFillButton(
                        title: "Send OTP".tr,
                        textColor: Colors.white,
                        gradient: LinearGradient(
                          colors: [Colors.red.shade300, Colors.red.shade400],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        onPress: () async {
                          String phoneNumber =
                              controller
                                  .phoneNUmberEditingController
                                  .value
                                  .text;

                          if (phoneNumber.isEmpty) {
                            ShowToastDialog.showToast(
                              "Please enter mobile number".tr,
                            );
                          } else {
                            Map<String, dynamic> body = {"phone": phoneNumber};
                            print("mobile---->>>$phoneNumber");
                            controller.sendOtp(body: body);
                          }
                        },
                      ),

                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 40),
                  //   child: Row(
                  //     children: [
                  //       const Expanded(child: Divider(thickness: 1)),
                  //       Padding(
                  //         padding: const EdgeInsets.symmetric(
                  //             horizontal: 20, vertical: 30),
                  //         child: Text(
                  //           "or".tr,
                  //           textAlign: TextAlign.center,
                  //           style: TextStyle(
                  //             color: themeChange.getThem()
                  //                 ? AppThemeData.grey500
                  //                 : AppThemeData.grey400,
                  //             fontSize: 16,
                  //             fontFamily: AppThemeData.medium,
                  //             fontWeight: FontWeight.w500,
                  //           ),
                  //         ),
                  //       ),
                  //       const Expanded(child: Divider()),
                  //     ],
                  //   ),
                  // ),
                  // RoundedButtonBorder(
                  //   title: "Continue with Email".tr,
                  //   textColor: AppThemeData.primary300,
                  //   icon: SvgPicture.asset("assets/icons/ic_mail.svg"),
                  //   isRight: false,
                  //   onPress: () async {
                  //     Get.back();
                  //   },
                  // ),
                ],
              ),
            ),
          ),
          // bottomNavigationBar: Padding(
          //   padding: EdgeInsets.symmetric(vertical: 40),
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       Text.rich(
          //         TextSpan(
          //           children: [
          //             TextSpan(
          //               text: 'Didn’t have an account?'.tr,
          //               style: TextStyle(
          //                 color: themeChange.getThem()
          //                     ? AppThemeData.grey50
          //                     : AppThemeData.grey900,
          //                 fontFamily: AppThemeData.medium,
          //                 fontWeight: FontWeight.w500,
          //               ),
          //             ),
          //             const WidgetSpan(
          //               child: SizedBox(
          //                 width: 10,
          //               ),
          //             ),
          //             TextSpan(
          //               recognizer: TapGestureRecognizer()
          //                 ..onTap = () {
          //                   Get.to(const SignupScreen());
          //                 },
          //               text: 'Sign up'.tr,
          //               style: TextStyle(
          //                 color: AppThemeData.primary300,
          //                 fontFamily: AppThemeData.bold,
          //                 fontWeight: FontWeight.w500,
          //                 decoration: TextDecoration.underline,
          //                 decorationColor: AppThemeData.primary300,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        );
      },
    );
  }
}

class RoundedButtonFillButton extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final Color? color;
  final Color? textColor;
  final LinearGradient? gradient;

  const RoundedButtonFillButton({
    super.key,
    required this.title,
    required this.onPress,
    this.color,
    this.textColor,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          color: gradient == null ? color : null,
          gradient: gradient,
          borderRadius: BorderRadius.circular(30), // pill shape
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(
            title,
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
