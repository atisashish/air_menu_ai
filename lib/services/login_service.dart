import 'dart:convert';
import 'dart:developer';

import 'package:air_menu_ai_app/app/auth_screen/otp_screen.dart';
import 'package:air_menu_ai_app/constant/show_toast_dialog.dart';
import 'package:air_menu_ai_app/models/send_otp_model.dart';
import 'package:air_menu_ai_app/models/verify_otp_model.dart';
import 'package:air_menu_ai_app/utils/api_constant.dart';
import 'package:air_menu_ai_app/utils/network_helper.dart';
import 'package:get/get.dart';

class LoginService {
  static final NetworkAPICall _networkAPICall = NetworkAPICall();

  static Future<SendOtpModel> sendOtp({
    required Map<String, dynamic> body,
  }) async {
    try {
      final request = await _networkAPICall.post(
        ApiConstants.sendOtp,
        header: {'Content-Type': 'application/json'},
        // jsonEncode(body),
        body,
      );
      if (request != null) {
        if (request["success"] != true) {
          ShowToastDialog.showToast(request["message"]);
        } else {
          Get.to(OtpScreen());
        }
        return SendOtpModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {
      //loader end
    }
    return SendOtpModel();
  }

  static Future<VerifyOtpModel> verifyOtp({
    required Map<String, dynamic> body,
  }) async {
    try {
      final request = await _networkAPICall.post(
        ApiConstants.verifyOtp,
        header: {"Content-Type": "application/json"},
        jsonEncode(body),
      );
      if (request != null) {
        if (request["success"] != true) {
          ShowToastDialog.showToast(request["message"]);
        }
        return VerifyOtpModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {
      //loader end
    }
    return VerifyOtpModel();
  }
}
