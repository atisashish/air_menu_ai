import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:air_menu_ai_app/themes/app_them_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class Constant {
  static String userRoleDriver = 'driver';
  static String userRoleCustomer = 'customer';
  static String userRoleVendor = 'vendor';
  static const globalUrl = "https://customer.siswebapp.com/";
  static bool isZoneAvailable = false;
  static String theme = "theme_1";
  static String mapAPIKey = "";
  static String placeHolderImage = "";
  static String senderId = '';
  static String jsonNotificationFileURL = '';
  static String radius = "50";
  static String driverRadios = "50";
  static String distanceType = "km";
  static String placeholderImage = "";
  static String googlePlayLink = "";
  static String appStoreLink = "";
  static String appVersion = "";
  static String websiteUrl = "";
  static String termsAndConditions = "";
  static String privacyPolicy = "";
  static String supportURL = "";
  static String minimumAmountToDeposit = "0.0";
  static String minimumAmountToWithdrawal = "0.0";
  static String? referralAmount = "0.0";
  static bool? walletSetting = true;
  static bool? storyEnable = true;
  static bool? specialDiscountOffer = true;
  static const String orderPlaced = "Order Placed";
  static const String orderAccepted = "Order Accepted";
  static const String orderRejected = "Order Rejected";
  static const String driverPending = "Driver Pending";
  static const String driverRejected = "Driver Rejected";
  static const String orderShipped = "Order Shipped";
  static const String orderInTransit = "In Transit";
  static const String orderCompleted = "Order Completed";
  static bool isSubscriptionModelApplied = false;
  static String walletTopup = "wallet_topup";
  static String newVendorSignup = "new_vendor_signup";
  static String payoutRequestStatus = "payout_request_status";
  static String payoutRequest = "payout_request";
  static String newOrderPlaced = "order_placed";
  static String scheduleOrder = "schedule_order";
  static String dineInPlaced = "dinein_placed";
  static String dineInCanceled = "dinein_canceled";
  static String dineinAccepted = "dinein_accepted";
  static String restaurantRejected = "restaurant_rejected";
  static String driverCompleted = "driver_completed";
  static String restaurantAccepted = "restaurant_accepted";
  static String takeawayCompleted = "takeaway_completed";
  static String selectedMapType = 'osm';
  static String? mapType = "google";
  static String? we = "google";
  static bool? isEnabledForCustomer = true;

  static Color statusColor({required String? status}) {
    if (status == orderPlaced) {
      return AppThemeData.secondary300;
    } else if (status == orderAccepted || status == orderCompleted) {
      return AppThemeData.success400;
    } else if (status == orderRejected) {
      return AppThemeData.danger300;
    } else {
      return AppThemeData.warning300;
    }
  }

  static Color statusText({required String? status}) {
    if (status == orderPlaced) {
      return AppThemeData.grey50;
    } else if (status == orderAccepted || status == orderCompleted) {
      return AppThemeData.grey50;
    } else if (status == orderRejected) {
      return AppThemeData.grey50;
    } else {
      return AppThemeData.grey900;
    }
  }

  static String calculateReview({
    required String? reviewCount,
    required String? reviewSum,
  }) {
    if (0 == double.parse(reviewSum.toString()) &&
        0 == double.parse(reviewSum.toString())) {
      return "0";
    }
    return (double.parse(reviewSum.toString()) /
            double.parse(reviewCount.toString()))
        .toStringAsFixed(1);
  }

  static const userPlaceHolder = 'assets/images/user_placeholder.png';

  static String getUuid() {
    return const Uuid().v4();
  }

  static Widget loader() {
    return Center(
      child: CircularProgressIndicator(color: AppThemeData.primary300),
    );
  }

  static Widget showEmptyView({required String message}) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(fontFamily: AppThemeData.medium, fontSize: 18),
      ),
    );
  }

  static String getReferralCode() {
    var rng = math.Random();
    return (rng.nextInt(900000) + 100000).toString();
  }

  static String maskingString(String documentId, int maskingDigit) {
    String maskedDigits = documentId;
    for (int i = 0; i < documentId.length - maskingDigit; i++) {
      maskedDigits = maskedDigits.replaceFirst(documentId[i], "*");
    }
    return maskedDigits;
  }

  String? validateRequired(String? value, String type) {
    if (value!.isEmpty) {
      return '$type required';
    }
    return null;
  }

  String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  static String getDistance({
    required String lat1,
    required String lng1,
    required String lat2,
    required String lng2,
  }) {
    double distance;
    double distanceInMeters = Geolocator.distanceBetween(
      double.parse(lat1),
      double.parse(lng1),
      double.parse(lat2),
      double.parse(lng2),
    );
    if (distanceType == "miles") {
      distance = distanceInMeters / 1609;
    } else {
      distance = distanceInMeters / 1000;
    }
    return distance.toStringAsFixed(2);
  }

  bool hasValidUrl(String? value) {
    String pattern =
        r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
    RegExp regExp = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return false;
    } else if (!regExp.hasMatch(value)) {
      return false;
    }
    return true;
  }

  static Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(launchUri);
  }

  launchURL(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(
      format: ui.ImageByteFormat.png,
    ))!.buffer.asUint8List();
  }

  static Future<TimeOfDay?> selectTime(context) async {
    FocusScope.of(context).requestFocus(FocusNode()); //remove focus
    TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null) {
      return newTime;
    }
    return null;
  }

  static Future<DateTime?> selectDate(context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppThemeData.primary300, // header background color
              onPrimary: AppThemeData.grey900, // header text color
              onSurface: AppThemeData.grey900, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppThemeData.grey900, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
      initialDate: DateTime.now(),
      //get today's date
      firstDate: DateTime(2000),
      //DateTime.now() - not to allow to choose before today.
      lastDate: DateTime(2101),
    );
    return pickedDate;
  }

  static int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(
      date.year,
      date.month,
      date.day,
    ).difference(DateTime(now.year, now.month, now.day)).inDays;
  }

  static DateTime stringToDate(String openDineTime) {
    return DateFormat('HH:mm').parse(
      DateFormat('HH:mm').format(
        DateFormat("hh:mm a").parse(
          (Intl.getCurrentLocale() == "en_US")
              ? openDineTime
              : openDineTime.toLowerCase(),
        ),
      ),
    );
  }

  static String orderId({String orderId = ''}) {
    return "#${(orderId).substring(orderId.length - 10)}";
  }

  static Uri createCoordinatesUrl(
    double latitude,
    double longitude, [
    String? label,
  ]) {
    Uri uri;
    if (kIsWeb) {
      uri = Uri.https('www.google.com', '/maps/search/', {
        'api': '1',
        'query': '$latitude,$longitude',
      });
    } else if (Platform.isAndroid) {
      var query = '$latitude,$longitude';
      if (label != null) query += '($label)';
      uri = Uri(scheme: 'geo', host: '0,0', queryParameters: {'q': query});
    } else if (Platform.isIOS) {
      var params = {'ll': '$latitude,$longitude'};
      if (label != null) params['q'] = label;
      uri = Uri.https('maps.apple.com', '/', params);
    } else {
      uri = Uri.https('www.google.com', '/maps/search/', {
        'api': '1',
        'query': '$latitude,$longitude',
      });
    }

    return uri;
  }
}

extension StringExtension on String {
  String capitalizeString() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
