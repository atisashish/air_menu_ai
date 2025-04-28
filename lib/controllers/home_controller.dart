import 'package:air_menu_ai_app/constant/show_toast_dialog.dart';
import 'package:air_menu_ai_app/models/add_to_cart_model.dart'
    show AddToCartModel;
import 'package:air_menu_ai_app/models/category_model.dart';
import 'package:air_menu_ai_app/models/order_list_model.dart' as OrderListModel;
import 'package:air_menu_ai_app/models/product_details_model.dart'
    as productDetailModel;
import 'package:air_menu_ai_app/models/restro_model.dart' as restroModel;
import 'package:air_menu_ai_app/models/user_model.dart' show UserModel;
import 'package:air_menu_ai_app/services/home_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../models/banner_model.dart' as BannerModel;
import '../models/cart_list_model.dart' show CartListModel;
import '../models/category_wise_product_model.dart' as categoryWiseProductModel;
import '../models/order_model.dart' show OrderListModel, OrderModel;
import '../models/product_model.dart' as productModel;
import '../models/restro_detail_model.dart' show RestaurantDetailModel;

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isCart = false.obs;
  RxBool isCartUpdate = false.obs;
  RxBool isProductLoading = false.obs;
  RxBool isRestaurantLoading = false.obs;
  RxBool isProductDetailLoading = false.obs;
  RxBool isProductCategoryLoading = false.obs;
  RxBool isRetsroDetailLoading = false.obs;
  RxBool isSearchLoading = false.obs;
  RxBool isCartList = false.obs;
  RxBool isOrderLoading = false.obs;
  RxBool isOrderList = false.obs;
  RxBool isBanner = false.obs;
  RxList<Data> category = <Data>[].obs;
  RxList<OrderListModel.Data> orderList = <OrderListModel.Data>[].obs;
  RxList<BannerModel.Data> bannerList = <BannerModel.Data>[].obs;
  RxList<productModel.Data> productList = <productModel.Data>[].obs;
  RxList<restroModel.Data> restroList = <restroModel.Data>[].obs;
  RxList<categoryWiseProductModel.Data> categoryProductList =
      <categoryWiseProductModel.Data>[].obs;
  RxList<categoryWiseProductModel.Data> searchProductList =
      <categoryWiseProductModel.Data>[].obs;
  Rx<productDetailModel.Data> productDetail = productDetailModel.Data().obs;
  Rx<CartListModel> cartList = CartListModel().obs;
  Rx<UserModel> userData = UserModel().obs;
  Rx<RestaurantDetailModel> restroDetail = RestaurantDetailModel().obs;
  var quantity = 1.obs;
  var quantityAddOns = 1.obs;
  var selectedAddress = "123, Street Name, City".obs; // Stores selected address
  var addresses =
      [
        {"label": "Home", "address": "123, Street Name, City"},
        {"label": "Work", "address": "456, Business Park, City"},
        {"label": "Other", "address": "789, Apartment Name, City"},
      ].obs;
  var streetController = TextEditingController().obs;
  var nameController = TextEditingController().obs;
  var cityController = TextEditingController().obs;
  var stateController = TextEditingController().obs;
  var zipCodeController = TextEditingController().obs;

  void selectAddress(String address) {
    selectedAddress.value = address;
    Get.back();
  }

  var fullAddress = "".obs;

  void updateAddress() {
    fullAddress.value =
        "${nameController.value.text}, ${streetController.value.text}, ${cityController.value.text}, ${stateController.value.text}, ${zipCodeController.value.text}";
  }

  void increment() {
    if (quantity < 10) {
      quantity++;
    } else {
      ShowToastDialog.showToast(
        position: EasyLoadingToastPosition.bottom,
        "Maximum limit reached. You cannot add more than 10 items.",
      );
    }
  }

  void decrement() {
    if (quantity > 1) {
      quantity--;
    } else {
      ShowToastDialog.showToast(
        position: EasyLoadingToastPosition.bottom,
        "Minimum quantity reached. You cannot reduce further.",
      );
    }
  }

  Future<CategoryModel> getCategory() async {
    try {
      isLoading.value = true;
      CategoryModel user = await HomeService.getCategory();
      isLoading.value = false;
      if (user.success == true) {
        category.value = user.data ?? [];
        print("category------>>${category.value}");
      } else {
        ShowToastDialog.showToast(user.message);
      }
      return user;
    } catch (e, st) {
      print("st--->>>$st");
      isLoading.value = false;
    } finally {}
    return CategoryModel();
  }

  Future<CartListModel> getCartList() async {
    try {
      isCartList.value = true;
      CartListModel user = await HomeService.getCartList();
      isCartList.value = false;
      if (user.success == true) {
        cartList.value = user;
        print("cartList------>>${cartList.value}");
      } else {
        ShowToastDialog.showToast(user.message);
      }
      return user;
    } catch (e, st) {
      print("st--->>>$st");
      isCartList.value = false;
    } finally {}
    return CartListModel();
  }

  Future<productModel.ProductModel> getProduct() async {
    try {
      isProductLoading.value = true;
      productModel.ProductModel user = await HomeService.getProduct();
      isProductLoading.value = false;
      if (user.success == true) {
        productList.value = user.data ?? [];
        print("productList------>>${productList.value}");
      } else {
        ShowToastDialog.showToast(user.message);
      }
      return user;
    } catch (e, st) {
      print("st--->>>$st");
      isProductLoading.value = false;
    } finally {}
    return productModel.ProductModel();
  }

  Future<restroModel.RestroModel> getRestaurant() async {
    try {
      isRestaurantLoading.value = true;
      restroModel.RestroModel user = await HomeService.getRestaurant();
      isRestaurantLoading.value = false;
      if (user.success == true) {
        restroList.value = user.data ?? [];
        print("restroList------>>${restroList.value}");
      } else {
        ShowToastDialog.showToast(user.message);
      }
      return user;
    } catch (e, st) {
      print("st--->>>$st");
      isRestaurantLoading.value = false;
    } finally {}
    return restroModel.RestroModel();
  }

  Future<categoryWiseProductModel.CategoryWiseProductModel> getCategoryProduct({
    String? categoryID,
  }) async {
    try {
      isProductCategoryLoading.value = true;
      categoryWiseProductModel.CategoryWiseProductModel user =
          await HomeService.getCategoryProduct(categoryID: categoryID);
      isProductCategoryLoading.value = false;
      if (user.success == true) {
        categoryProductList.value = user.data ?? [];
        print("categoryProductList------>>${productList.value}");
      } else {
        ShowToastDialog.showToast(user.message);
      }
      return user;
    } catch (e, st) {
      print("st--->>>$st");
      isProductCategoryLoading.value = false;
    } finally {}
    return categoryWiseProductModel.CategoryWiseProductModel();
  }

  Future<RestaurantDetailModel> gerRestroDetail({String? restroID}) async {
    try {
      isRetsroDetailLoading.value = true;
      RestaurantDetailModel user = await HomeService.gerRestroDetail(
        restroId: restroID,
      );
      isRetsroDetailLoading.value = false;
      if (user.success == true) {
        restroDetail.value = user;
        print("restroDetail------>>${restroDetail.value}");
      } else {
        ShowToastDialog.showToast(user.message);
      }
      return user;
    } catch (e, st) {
      print("st--->>>$st");
      isRetsroDetailLoading.value = false;
    } finally {}
    return RestaurantDetailModel();
  }

  Future<categoryWiseProductModel.CategoryWiseProductModel> searchProduct({
    String? searchValue,
  }) async {
    try {
      isSearchLoading.value = true;
      categoryWiseProductModel.CategoryWiseProductModel user =
          await HomeService.searchProduct(searchValue: searchValue);
      isSearchLoading.value = false;
      if (user.success == true) {
        searchProductList.value = user.data ?? [];
        print("searchProductList------>>${searchProductList.value}");
      } else {
        ShowToastDialog.showToast(user.message);
      }
      return user;
    } catch (e, st) {
      print("st--->>>$st");
      isSearchLoading.value = false;
    } finally {}
    return categoryWiseProductModel.CategoryWiseProductModel();
  }

  Future<productDetailModel.ProductDetailsModel> getProductDetail({
    String? productId,
  }) async {
    try {
      isProductDetailLoading.value = true;
      productDetailModel.ProductDetailsModel user =
          await HomeService.getProductDetail(productId: productId);
      isProductDetailLoading.value = false;
      if (user.success == true) {
        productDetail.value = user.data ?? productDetailModel.Data();
        print("productDetail------>>${productDetail.value.addons}");
      } else {
        ShowToastDialog.showToast(user.message);
      }
      return user;
    } catch (e, st) {
      print("st--->>>$st");
      isProductDetailLoading.value = false;
    } finally {}
    return productDetailModel.ProductDetailsModel();
  }

  Future<UserModel> getUserDetail() async {
    try {
      UserModel user = await HomeService.getUserDetail();
      if (user.success == true) {
        userData.value = user;
        print("userData------>>${userData.value.data?.name}");
      } else {
        ShowToastDialog.showToast(user.message);
      }
      return user;
    } catch (e, st) {
      print("st--->>>$st");
    } finally {}
    return UserModel();
  }

  Future<OrderListModel.OrderListModel> getOrders() async {
    isOrderList.value = true;
    try {
      OrderListModel.OrderListModel user = await HomeService.getOrders();
      isOrderList.value = false;
      if (user.success == true) {
        orderList.value = user.data ?? [];
        print("orderList------>>${orderList.value}");
      } else {
        ShowToastDialog.showToast(user.message);
      }
      return user;
    } catch (e, st) {
      print("st--->>>$st");
    } finally {
      isOrderList.value = false;
    }
    return OrderListModel.OrderListModel();
  }

  Future<BannerModel.BannerModel> getBanners() async {
    isBanner.value = true;
    try {
      BannerModel.BannerModel user = await HomeService.getBanners();
      isBanner.value = false;
      if (user.success == true) {
        bannerList.value = user.data ?? [];
        print("bannerList------>>${bannerList.value}");
      } else {
        ShowToastDialog.showToast(user.message);
      }
      return user;
    } catch (e, st) {
      print("st--->>>$st");
    } finally {
      isBanner.value = false;
    }
    return BannerModel.BannerModel();
  }

  Future<AddToCartModel> addToCart({required Map<String, dynamic> body}) async {
    try {
      isCart.value = true;
      AddToCartModel user = await HomeService.addToCart(body: body);
      isCart.value = false;
      if (user.success == true) {
        ShowToastDialog.showToast(
          user.message,
          position: EasyLoadingToastPosition.bottom,
        );
        Get.back();
        getCartList();
      } else {
        ShowToastDialog.showToast(
          user.message,
          position: EasyLoadingToastPosition.bottom,
        );
      }
      return user;
    } catch (e, st) {
      print("st--->>>${st}");
      isCart.value = false;
    } finally {}
    return AddToCartModel();
  }

  Future<CartListModel> updateCart({required Map<String, dynamic> body}) async {
    try {
      isCartUpdate.value = true;
      CartListModel user = await HomeService.updateCart(body: body);
      isCartUpdate.value = false;
      if (user.success == true) {
        ShowToastDialog.showToast(
          user.message,
          position: EasyLoadingToastPosition.bottom,
        );
        getCartList();
      } else {
        ShowToastDialog.showToast(
          user.message,
          position: EasyLoadingToastPosition.bottom,
        );
      }
      return user;
    } catch (e, st) {
      print("st--->>>${st}");
      isCartUpdate.value = false;
    } finally {}
    return CartListModel();
  }

  Future<OrderModel> putOrder({required Map<String, dynamic> body}) async {
    try {
      isOrderLoading.value = true;
      OrderModel user = await HomeService.putOrder(body: body);
      isOrderLoading.value = false;
      if (user.success == true) {
        ShowToastDialog.showToast(
          user.message,
          position: EasyLoadingToastPosition.bottom,
        );
        getCartList();
      } else {
        ShowToastDialog.showToast(
          user.message,
          position: EasyLoadingToastPosition.bottom,
        );
      }
      return user;
    } catch (e, st) {
      print("st--->>>${st}");
      isOrderLoading.value = false;
    } finally {}
    return OrderModel();
  }

  Future<AddToCartModel> removeCart({
    required String id,
    required int index,
  }) async {
    try {
      cartList.value.data?.items?[index].isLoading.value = true;
      AddToCartModel user;
      try {
        user = await HomeService.removeCart(id: id);
        getCartList();
      } catch (e) {
        print("API Call Failed: $e");
        user = AddToCartModel(success: false, message: "Something went wrong");
      }
      cartList.value.data?.items?[index].isLoading.value = false;
      if (user.success == true) {
        ShowToastDialog.showToast(
          user.message,
          position: EasyLoadingToastPosition.bottom,
        );
        getCartList();
        Get.back();
      } else {
        ShowToastDialog.showToast(
          user.message,
          position: EasyLoadingToastPosition.bottom,
        );
      }
      return user;
    } catch (e, st) {
      print("Error in removeCart: $e\nStackTrace: $st");
      cartList.value.data?.items?[index].isLoading.value = false;
      return AddToCartModel(success: false, message: "An error occurred");
    }
  }

  @override
  void onInit() {
    getBanners();
    getCategory();
    getProduct();
    getCartList();
    getUserDetail();
    getRestaurant();
    streetController.value.addListener(updateAddress);
    cityController.value.addListener(updateAddress);
    stateController.value.addListener(updateAddress);
    zipCodeController.value.addListener(updateAddress);
    super.onInit();
  }
}

class RestaurantModel {
  final String id;
  final String name;
  final String imageUrl;
  final String cuisine;
  final double rating;
  final int reviewCount;
  final double distance;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.cuisine,
    required this.rating,
    required this.reviewCount,
    required this.distance,
  });
}
