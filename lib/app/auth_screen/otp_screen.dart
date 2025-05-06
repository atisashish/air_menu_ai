import 'package:air_menu_ai_app/app/auth_screen/phone_number_screen.dart';
import 'package:air_menu_ai_app/constant/constant.dart';
import 'package:air_menu_ai_app/constant/show_toast_dialog.dart';
import 'package:air_menu_ai_app/controllers/otp_controller.dart';
import 'package:air_menu_ai_app/controllers/phone_number_controller.dart';
import 'package:air_menu_ai_app/themes/app_them_data.dart';
import 'package:air_menu_ai_app/utils/dark_theme_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  final PhoneNumberController phoneNumberController = Get.find();

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return GetX<OtpController>(
      init: OtpController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor:
                themeChange.getThem()
                    ? AppThemeData.surfaceDark
                    : AppThemeData.surface,
          ),
          body:
              controller.isLoading.value
                  ? Constant.loader()
                  : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 10,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Verify Your Number 📱".tr,
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
                            "Enter the OTP sent to your mobile number. ${controller.countryCode.value} ${Constant.maskingString(controller.phoneNumber.value, 3)}"
                                .tr,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color:
                                  themeChange.getThem()
                                      ? AppThemeData.grey200
                                      : AppThemeData.grey700,
                              fontSize: 16,
                              fontFamily: AppThemeData.regular,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 60),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: PinCodeTextField(
                              length: 4,
                              appContext: context,
                              keyboardType: TextInputType.phone,
                              enablePinAutofill: true,
                              hintCharacter: "-",
                              textStyle: TextStyle(
                                color:
                                    themeChange.getThem()
                                        ? AppThemeData.grey50
                                        : AppThemeData.grey900,
                                fontFamily: AppThemeData.regular,
                              ),
                              pinTheme: PinTheme(
                                fieldHeight: 50,
                                fieldWidth: 50,
                                inactiveFillColor:
                                    themeChange.getThem()
                                        ? AppThemeData.grey900
                                        : AppThemeData.grey900,
                                selectedFillColor:
                                    themeChange.getThem()
                                        ? AppThemeData.grey900
                                        : AppThemeData.grey900,
                                activeFillColor:
                                    themeChange.getThem()
                                        ? AppThemeData.grey900
                                        : AppThemeData.grey50,
                                selectedColor:
                                    themeChange.getThem()
                                        ? AppThemeData.grey900
                                        : AppThemeData.grey50,
                                activeColor:
                                    themeChange.getThem()
                                        ? AppThemeData.primary300
                                        : AppThemeData.primary300,
                                inactiveColor:
                                    themeChange.getThem()
                                        ? AppThemeData.grey900
                                        : AppThemeData.grey50,
                                disabledColor:
                                    themeChange.getThem()
                                        ? AppThemeData.grey900
                                        : AppThemeData.grey50,
                                shape: PinCodeFieldShape.box,
                                errorBorderColor:
                                    themeChange.getThem()
                                        ? AppThemeData.grey600
                                        : AppThemeData.grey300,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              cursorColor: AppThemeData.primary300,
                              enableActiveFill: true,
                              controller: controller.otpController.value,
                              onCompleted: (v) async {},
                              onChanged: (value) {},
                            ),
                          ),
                          const SizedBox(height: 50),
                          phoneNumberController.isLoading.value
                              ? Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 1,
                                  color: AppThemeData.primary300,
                                ),
                              )
                              : RoundedButtonFillButton(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.red.shade300,
                                    Colors.red.shade400,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                title: "Verify & Next".tr,
                                color: AppThemeData.primary300,
                                textColor: AppThemeData.grey50,
                                onPress: () async {
                                  if (controller
                                          .otpController
                                          .value
                                          .text
                                          .length ==
                                      4) {
                                    Map<String, dynamic> body = {
                                      "phone":
                                          phoneNumberController
                                              .phoneNUmberEditingController
                                              .value
                                              .text,
                                      "otp":
                                          controller.otpController.value.text,
                                    };
                                    phoneNumberController.verifyOtp(body: body);
                                  } else {
                                    ShowToastDialog.showToast(
                                      "Enter Valid otp".tr,
                                    );
                                  }
                                },
                              ),
                          const SizedBox(height: 40),
                          Text.rich(
                            textAlign: TextAlign.start,
                            TextSpan(
                              text: "${'Did’t receive any code? '.tr} ",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                fontFamily: AppThemeData.medium,
                                color:
                                    themeChange.getThem()
                                        ? AppThemeData.grey100
                                        : AppThemeData.grey800,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  recognizer:
                                      TapGestureRecognizer()
                                        ..onTap = () {
                                          controller.otpController.value
                                              .clear();
                                          Map<String, dynamic> body = {
                                            "phone":
                                                phoneNumberController
                                                    .phoneNUmberEditingController
                                                    .value
                                                    .text
                                                    .trim(),
                                          };
                                          phoneNumberController.sendOtp(
                                            body: body,
                                          );
                                        },
                                  text: 'Send Again'.tr,
                                  style: TextStyle(
                                    color:
                                        themeChange.getThem()
                                            ? AppThemeData.primary300
                                            : AppThemeData.primary300,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    fontFamily: AppThemeData.medium,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppThemeData.primary300,
                                  ),
                                ),
                              ],
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
