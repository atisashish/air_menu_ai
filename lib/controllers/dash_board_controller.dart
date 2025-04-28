import 'package:air_menu_ai_app/app/home_screen/home_screen_two.dart';
import 'package:air_menu_ai_app/app/profile_screen/profile_screen.dart';
import 'package:air_menu_ai_app/app/scan_qrcode_screen/scan_qr_code_screen.dart';
import 'package:get/get.dart';

class DashBoardController extends GetxController {
  RxInt selectedIndex = 0.obs;

  RxList pageList = [].obs;

  @override
  void onInit() {
    pageList.value = [HomeScreenTwo(), ScanQrCodeScreen(), ProfileScreen()];
    super.onInit();
  }

  DateTime? currentBackPressTime;
  RxBool canPopNow = false.obs;
}
