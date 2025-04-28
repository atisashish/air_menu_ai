import 'package:get/get.dart';

class ReviewListController extends GetxController {
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getArgument();
    super.onInit();
  }


  getArgument() {
    dynamic argumentData = Get.arguments;
    if (argumentData != null) {

    }
    isLoading.value = false;
  }
}
