import 'package:air_menu_ai_app/constant/show_toast_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CartController extends GetxController {
  Rx<TextEditingController> reMarkController = TextEditingController().obs;
  Rx<TextEditingController> couponCodeController = TextEditingController().obs;
  Rx<TextEditingController> tipsController = TextEditingController().obs;
  RxString selectedFoodType = "Delivery".tr.obs;

  RxString selectedPaymentMethod = ''.obs;

  RxString deliveryType = "instant".tr.obs;
  Rx<DateTime> scheduleDateTime = DateTime.now().obs;
  RxDouble totalDistance = 0.0.obs;
  RxDouble deliveryCharges = 0.0.obs;
  RxDouble subTotal = 0.0.obs;
  RxDouble couponAmount = 0.0.obs;

  RxDouble specialDiscountAmount = 0.0.obs;
  RxDouble specialDiscount = 0.0.obs;
  RxString specialType = "".obs;

  RxDouble deliveryTips = 0.0.obs;
  RxDouble taxAmount = 0.0.obs;
  RxDouble totalAmount = 0.0.obs;

  void handleExternalWaller(ExternalWalletResponse response) {
    Get.back();
    ShowToastDialog.showToast("Payment Processing!! via");
  }

  void handlePaymentError(PaymentFailureResponse response) {
    Get.back();
    ShowToastDialog.showToast("Payment Failed!!");
  }

  bool isCurrentDateInRange(DateTime startDate, DateTime endDate) {
    final currentDate = DateTime.now();
    return currentDate.isAfter(startDate) && currentDate.isBefore(endDate);
  }

  //Orangepay payment
  static String accessToken = '';
  static String payToken = '';
  static String orderId = '';
  static String amount = '';

  Future fetchToken({
    required String orderId,
    required String currency,
    required BuildContext context,
    required String amount,
  }) async {
    String apiUrl = 'https://api.orange.com/oauth/v3/token';
    Map<String, String> requestBody = {'grant_type': 'client_credentials'};
  }
}
