import 'package:air_menu_ai_app/controllers/scan_qr_code_controller.dart';
import 'package:air_menu_ai_app/themes/app_them_data.dart';
import 'package:air_menu_ai_app/utils/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';

class ScanQrCodeScreen extends StatelessWidget {
  const ScanQrCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return GetBuilder(
      init: ScanQrCodeController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            titleSpacing: 0,
            backgroundColor:
                themeChange.getThem()
                    ? AppThemeData.surfaceDark
                    : AppThemeData.surface,
            title: Text(
              "Scan QRcode",
              style: TextStyle(
                fontSize: 16,
                color:
                    themeChange.getThem()
                        ? AppThemeData.grey50
                        : AppThemeData.grey900,
                fontFamily: AppThemeData.medium,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          body: Stack(
            children: [
              QRCodeDartScanView(
                scanInvertedQRCode: true,
                typeScan: TypeScan.live,
                onCapture: (Result result) {
                  Map<String, dynamic> body = {
                    "tableNumber": result.text,
                    "description": "Window side table",
                    "isActive": true,
                  };
                  controller.qrCodeScan(body: body);
                },
              ),
              Obx(
                () =>
                    controller.isScanner.value
                        ? Center(
                          child: CircularProgressIndicator(
                            color: AppThemeData.primary300,
                          ),
                        )
                        : SizedBox(),
              ),
            ],
          ),
          // body: MobileScanner(
          //   // fit: BoxFit.contain,
          //   onDetect: (capture) async {
          //     final List<Barcode> barcodes = capture.barcodes;
          //     for (final barcode in barcodes) {
          //       Get.back();
          //       ShowToastDialog.showLoader("Please wait".tr);
          //       if (controller.allNearestRestaurant.isNotEmpty) {
          //         for (VendorModel storeModel in controller.allNearestRestaurant) {
          //           if (storeModel.id == barcode.rawValue) {
          //             Get.back();
          //             Get.to(const RestaurantDetailsScreen(), arguments: {"vendorModel": storeModel});
          //           }
          //         }
          //       } else {
          //         Get.back();
          //         ShowToastDialog.showToast("Store is not available");
          //       }
          //     }
          //   },
          // ),
        );
      },
    );
  }
}
