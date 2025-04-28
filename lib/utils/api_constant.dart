import 'dart:developer';

class ApiConstants {
  static const String baseUrl = "https://rastorant-server.vercel.app/v1/api/";
  static const String sendOtp = "auth/request-otp";
  static const String verifyOtp = "auth/verify-otp";
  static const String categories = "categories";
  static const String products = "products";
  static const String productsDetail = "products/";
  static const String productCategory = "products?category=";
  static const String searchProduct = "products?search=";
  static const String cart = "cart";
  static const String removeCart = "cart/item/";
  static const String orders = "orders";
  static const String user = "auth/user/";
  static const String cartUpdate = "cart/item";
  static const String userUpdate = "auth/user/";
  static const String myOrders = "/orders/my-orders";
  static const String banners = "banners";
  static const String qrScanner = "qr-scanner";
  static const String hotels = "hotels";
  static const String hotelsDetails = "hotels/";

  static String getParamsFromBody(Map<String, dynamic>? body) {
    String params = '?';
    for (var i = 0; i < body!.keys.length; i++) {
      params += '${List.from(body.keys)[i]}=${List.from(body.values)[i]}';
      if (i != body.keys.length - 1) {
        params += '&';
      }
    }
    log(params);
    return params;
  }
}
