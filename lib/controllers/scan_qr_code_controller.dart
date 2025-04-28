import 'package:air_menu_ai_app/app/home_screen/all_product_list.dart';
import 'package:air_menu_ai_app/constant/show_toast_dialog.dart';
import 'package:air_menu_ai_app/models/qr_code_model.dart';
import 'package:air_menu_ai_app/services/home_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ScanQrCodeController extends GetxController {
  RxBool isScanner = false.obs;

  Future<QrCodeModel> qrCodeScan({required Map<String, dynamic> body}) async {
    try {
      isScanner.value = true;
      QrCodeModel user = await HomeService.qrCodeScan(body: body);
      isScanner.value = false;
      if (user.success == true) {
        ShowToastDialog.showToast(
          user.message,
          position: EasyLoadingToastPosition.bottom,
        );
        Get.to(AllProductListScreen());
      } else {
        ShowToastDialog.showToast(
          user.message,
          position: EasyLoadingToastPosition.bottom,
        );
      }
      return user;
    } catch (e, st) {
      print("st--->>>${st}");
      isScanner.value = false;
    } finally {}
    return QrCodeModel();
  }
}
