import 'package:get/get.dart';

class RestaurantListController extends GetxController {
  RxBool isLoading = true.obs;

  RxString title = "Restaurants".obs;

  getArgument() async {
    dynamic argumentData = Get.arguments;
    if (argumentData != null) {
      title.value = argumentData['title'] ?? "Restaurants";
    }

    isLoading.value = false;
  }
}
