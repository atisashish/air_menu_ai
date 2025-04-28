import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressListController extends GetxController {
  List saveAsList = ['Home'.tr, 'Work'.tr, 'Hotel'.tr, 'other'.tr].obs;
  RxString selectedSaveAs = "Home".tr.obs;

  Rx<TextEditingController> houseBuildingTextEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> localityEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> landmarkEditingController =
      TextEditingController().obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getUser();
    super.onInit();
  }

  clearData() {
    houseBuildingTextEditingController.value.clear();
    localityEditingController.value.clear();
    landmarkEditingController.value.clear();

    selectedSaveAs.value = "Home".tr;
  }

  getUser() async {}
}
