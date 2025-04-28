import 'dart:convert';
import 'dart:developer';

import 'package:air_menu_ai_app/constant/show_toast_dialog.dart';
import 'package:air_menu_ai_app/models/add_to_cart_model.dart';
import 'package:air_menu_ai_app/models/banner_model.dart';
import 'package:air_menu_ai_app/models/cart_list_model.dart';
import 'package:air_menu_ai_app/models/category_model.dart';
import 'package:air_menu_ai_app/models/category_wise_product_model.dart';
import 'package:air_menu_ai_app/models/order_list_model.dart';
import 'package:air_menu_ai_app/models/order_model.dart';
import 'package:air_menu_ai_app/models/product_details_model.dart';
import 'package:air_menu_ai_app/models/product_model.dart';
import 'package:air_menu_ai_app/models/qr_code_model.dart';
import 'package:air_menu_ai_app/models/restro_detail_model.dart';
import 'package:air_menu_ai_app/models/restro_model.dart';
import 'package:air_menu_ai_app/models/user_model.dart';
import 'package:air_menu_ai_app/utils/api_constant.dart';
import 'package:air_menu_ai_app/utils/network_helper.dart';
import 'package:air_menu_ai_app/utils/preference.dart';

class HomeService {
  static final NetworkAPICall _networkAPICall = NetworkAPICall();

  static Future<CategoryModel> getCategory() async {
    String token = await SharedPrefs.getToken();
    try {
      final request = await _networkAPICall.get(
        ApiConstants.categories,
        header: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $token',
        },
      );
      if (request != null) {
        return CategoryModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {
      //loader end
    }
    return CategoryModel();
  }

  static Future<CartListModel> getCartList() async {
    String token = await SharedPrefs.getToken();
    try {
      final request = await _networkAPICall.get(
        ApiConstants.cart,
        header: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $token',
        },
      );
      if (request != null) {
        return CartListModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {
      //loader end
    }
    return CartListModel();
  }

  static Future<ProductModel> getProduct() async {
    String token = await SharedPrefs.getToken();
    try {
      final request = await _networkAPICall.get(
        ApiConstants.products,
        header: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $token',
        },
      );
      if (request != null) {
        return ProductModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {
      //loader end
    }
    return ProductModel();
  }

  static Future<RestroModel> getRestaurant() async {
    String token = await SharedPrefs.getToken();
    try {
      final request = await _networkAPICall.get(
        ApiConstants.hotels,
        header: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $token',
        },
      );
      if (request != null) {
        return RestroModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {
      //loader end
    }
    return RestroModel();
  }

  static Future<CategoryWiseProductModel> getCategoryProduct({
    String? categoryID,
  }) async {
    String token = await SharedPrefs.getToken();
    try {
      final request = await _networkAPICall.get(
        ApiConstants.productCategory + (categoryID ?? ""),
        header: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $token',
        },
      );
      if (request != null) {
        return CategoryWiseProductModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {
      //loader end
    }
    return CategoryWiseProductModel();
  }

  static Future<RestaurantDetailModel> gerRestroDetail({
    String? restroId,
  }) async {
    // String token = await SharedPrefs.getToken();
    try {
      final request = await _networkAPICall.get(
        ApiConstants.hotelsDetails + (restroId ?? ""),
        header: {
          "Content-Type": "application/json",
          // "Authorization": 'Bearer $token',
        },
      );
      if (request != null) {
        return RestaurantDetailModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {
      //loader end
    }
    return RestaurantDetailModel();
  }

  static Future<CategoryWiseProductModel> searchProduct({
    String? searchValue,
  }) async {
    String token = await SharedPrefs.getToken();
    try {
      final request = await _networkAPICall.get(
        ApiConstants.searchProduct + (searchValue ?? ""),
        header: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $token',
        },
      );
      if (request != null) {
        return CategoryWiseProductModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {
      //loader end
    }
    return CategoryWiseProductModel();
  }

  static Future<ProductDetailsModel> getProductDetail({
    String? productId,
  }) async {
    String token = await SharedPrefs.getToken();
    try {
      final request = await _networkAPICall.get(
        ApiConstants.productsDetail + (productId ?? ''),
        header: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $token',
        },
      );
      if (request != null) {
        return ProductDetailsModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {
      //loader end
    }
    return ProductDetailsModel();
  }

  static Future<UserModel> getUserDetail() async {
    String token = await SharedPrefs.getToken();
    String id = await SharedPrefs.getId();
    try {
      final request = await _networkAPICall.get(
        ApiConstants.user + id,
        header: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $token',
        },
      );
      if (request != null) {
        return UserModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {
      //loader end
    }
    return UserModel();
  }

  static Future<OrderListModel> getOrders() async {
    String token = await SharedPrefs.getToken();
    try {
      final request = await _networkAPICall.get(
        ApiConstants.myOrders,
        header: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $token',
        },
      );
      if (request != null) {
        return OrderListModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {
      //loader end
    }
    return OrderListModel();
  }

  static Future<BannerModel> getBanners() async {
    String token = await SharedPrefs.getToken();
    try {
      final request = await _networkAPICall.get(
        ApiConstants.banners,
        header: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $token',
        },
      );
      if (request != null) {
        return BannerModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {
      //loader end
    }
    return BannerModel();
  }

  static Future<AddToCartModel> addToCart({
    required Map<String, dynamic> body,
  }) async {
    String token = await SharedPrefs.getToken();
    try {
      final request = await _networkAPICall.post(
        ApiConstants.cart,
        header: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $token',
        },
        jsonEncode(body),
      );
      if (request != null) {
        if (request["success"] != true) {
          ShowToastDialog.showToast(request["message"]);
        }
        return AddToCartModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {
      //loader end
    }
    return AddToCartModel();
  }

  static Future<QrCodeModel> qrCodeScan({
    required Map<String, dynamic> body,
  }) async {
    String token = await SharedPrefs.getToken();
    try {
      final request = await _networkAPICall.post(
        ApiConstants.qrScanner,
        header: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $token',
        },
        jsonEncode(body),
      );
      if (request != null) {
        if (request["success"] != true) {
          ShowToastDialog.showToast(request["message"]);
        }
        return QrCodeModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {
      //loader end
    }
    return QrCodeModel();
  }

  static Future<CartListModel> updateCart({
    required Map<String, dynamic> body,
  }) async {
    String token = await SharedPrefs.getToken();
    try {
      final request = await _networkAPICall.patch(
        ApiConstants.cartUpdate,
        body,
        header: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $token',
        },
      );
      if (request != null) {
        if (request["success"] != true) {
          ShowToastDialog.showToast(request["message"]);
        }
        return CartListModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {
      //loader end
    }
    return CartListModel();
  }

  static Future<UserModel> updateUser({
    required Map<String, dynamic> body,
  }) async {
    String token = await SharedPrefs.getToken();
    try {
      String id = await SharedPrefs.getId();
      final request = await _networkAPICall.patch(
        ApiConstants.userUpdate + id,
        body,
        header: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $token',
        },
      );
      if (request != null) {
        if (request["success"] != true) {
          ShowToastDialog.showToast(request["message"]);
        }
        return UserModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {
      //loader end
    }
    return UserModel();
  }

  static Future<OrderModel> putOrder({
    required Map<String, dynamic> body,
  }) async {
    String token = await SharedPrefs.getToken();
    try {
      final request = await _networkAPICall.post(
        ApiConstants.orders,
        header: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $token',
        },
        jsonEncode(body),
      );
      if (request != null) {
        if (request["success"] != true) {
          ShowToastDialog.showToast(request["message"]);
        }
        return OrderModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {
      //loader end
    }
    return OrderModel();
  }

  static Future<AddToCartModel> removeCart({required String id}) async {
    String token = await SharedPrefs.getToken();
    try {
      var request = await _networkAPICall.delete(
        ApiConstants.removeCart + id,
        header: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $token',
        },
      );

      // ✅ Debugging: Print the actual response
      log("Raw API Response: $request");

      // ✅ Ensure request is a valid JSON object
      if (request is String) {
        try {
          request = jsonDecode(request);
        } catch (e) {
          log("JSON Decode Error in removeCart(): $e");
          return AddToCartModel(); // Return an empty model to prevent crash
        }
      }

      if (request is! Map<String, dynamic>) {
        log(
          "Invalid API response: Expected Map<String, dynamic> but got ${request.runtimeType}",
        );
        return AddToCartModel(); // Return an empty model
      }

      if (request["success"] != true) {
        ShowToastDialog.showToast(request["message"] ?? "Unknown Error");
      }

      return AddToCartModel.fromJson(request);
    } catch (e, st) {
      log("Discover log In Api Error $e ---- $st");
      return AddToCartModel(); // Return an empty model in case of error
    }
  }
}
