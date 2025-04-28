import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantDetailsController extends GetxController {
  Rx<TextEditingController> searchEditingController =
      TextEditingController().obs;

  RxBool isLoading = true.obs;
  Rx<PageController> pageController = PageController().obs;
  RxInt currentPage = 0.obs;

  RxBool isVag = false.obs;
  RxBool isNonVag = false.obs;
  RxBool isMenuOpen = false.obs;
}
