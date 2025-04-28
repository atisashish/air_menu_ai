import 'package:air_menu_ai_app/constant/show_toast_dialog.dart';
import 'package:air_menu_ai_app/controllers/address_list_controller.dart';
import 'package:air_menu_ai_app/themes/app_them_data.dart';
import 'package:air_menu_ai_app/themes/round_button_fill.dart';
import 'package:air_menu_ai_app/themes/text_field_widget.dart';
import 'package:air_menu_ai_app/utils/dark_theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AddressListScreen extends StatelessWidget {
  const AddressListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return GetX(
      init: AddressListController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            titleSpacing: 0,
            backgroundColor:
                themeChange.getThem()
                    ? AppThemeData.surfaceDark
                    : AppThemeData.surface,
            title: Text(
              "Add Address",
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
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () async {
                    ShowToastDialog.showLoader("Please wait".tr);
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/icons/ic_send_one.svg"),
                      const SizedBox(width: 10),
                      Text(
                        "Use my current location".tr,
                        style: TextStyle(
                          fontSize: 16,
                          color:
                              themeChange.getThem()
                                  ? AppThemeData.primary300
                                  : AppThemeData.primary300,
                          fontFamily: AppThemeData.medium,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                InkWell(
                  onTap: () {
                    controller.clearData();
                    addAddressBottomSheet(context, controller);
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/icons/ic_plus.svg"),
                      const SizedBox(width: 10),
                      Text(
                        "Add Location".tr,
                        style: TextStyle(
                          fontSize: 16,
                          color:
                              themeChange.getThem()
                                  ? AppThemeData.primary300
                                  : AppThemeData.primary300,
                          fontFamily: AppThemeData.medium,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  "Saved Addresses".tr,
                  style: TextStyle(
                    fontSize: 16,
                    color:
                        themeChange.getThem()
                            ? AppThemeData.grey50
                            : AppThemeData.grey900,
                    fontFamily: AppThemeData.semiBold,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                            decoration: ShapeDecoration(
                              color:
                                  themeChange.getThem()
                                      ? AppThemeData.grey900
                                      : AppThemeData.grey50,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/ic_send_one.svg",
                                        colorFilter: ColorFilter.mode(
                                          themeChange.getThem()
                                              ? AppThemeData.grey100
                                              : AppThemeData.grey800,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Text(
                                              "shippingAddress.addressAs",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color:
                                                    themeChange.getThem()
                                                        ? AppThemeData.grey100
                                                        : AppThemeData.grey800,
                                                fontFamily:
                                                    AppThemeData.semiBold,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Container(
                                              decoration: ShapeDecoration(
                                                color:
                                                    themeChange.getThem()
                                                        ? AppThemeData.primary50
                                                        : AppThemeData
                                                            .primary50,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 5,
                                                    ),
                                                child: Text(
                                                  "Default".tr,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color:
                                                        themeChange.getThem()
                                                            ? AppThemeData
                                                                .primary300
                                                            : AppThemeData
                                                                .primary300,
                                                    fontFamily:
                                                        AppThemeData.semiBold,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          showActionSheet(
                                            context,
                                            index,
                                            controller,
                                          );
                                        },
                                        child: SvgPicture.asset(
                                          "assets/icons/ic_more_one.svg",
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "shippingAddress",
                                    style: TextStyle(
                                      color:
                                          themeChange.getThem()
                                              ? AppThemeData.grey400
                                              : AppThemeData.grey500,
                                      fontFamily: AppThemeData.regular,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showActionSheet(
    BuildContext context,
    int index,
    AddressListController controller,
  ) {
    showCupertinoModalPopup<void>(
      context: context,
      builder:
          (BuildContext context) => CupertinoActionSheet(
            actions: <CupertinoActionSheetAction>[
              CupertinoActionSheetAction(
                onPressed: () async {
                  ShowToastDialog.showLoader("Please wait".tr);
                },
                child: Text(
                  'Default'.tr,
                  style: const TextStyle(color: Colors.blue),
                ),
              ),
              CupertinoActionSheetAction(
                onPressed: () async {
                  Get.back();
                  controller.clearData();
                  addAddressBottomSheet(context, controller, index: index);
                },
                child: const Text('Edit', style: TextStyle(color: Colors.blue)),
              ),
              CupertinoActionSheetAction(
                onPressed: () async {
                  ShowToastDialog.showLoader("Please wait".tr);
                },
                child: Text(
                  'Delete'.tr,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              isDefaultAction: true,
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel'.tr),
            ),
          ),
    );
  }

  addAddressBottomSheet(
    BuildContext context,
    AddressListController controller, {
    int? index,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder:
          (context) => FractionallySizedBox(
            heightFactor: 0.6,
            child: StatefulBuilder(
              builder: (context1, setState) {
                final themeChange = Provider.of<DarkThemeProvider>(context);
                return Obx(
                  () => Scaffold(
                    body: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Center(
                              child: Container(
                                width: 134,
                                height: 5,
                                margin: const EdgeInsets.only(bottom: 6),
                                decoration: ShapeDecoration(
                                  color:
                                      themeChange.getThem()
                                          ? AppThemeData.grey50
                                          : AppThemeData.grey800,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: InkWell(
                              onTap: () {},
                              child: Row(
                                children: [
                                  SvgPicture.asset("assets/icons/ic_focus.svg"),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Choose Current Location".tr,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color:
                                          themeChange.getThem()
                                              ? AppThemeData.primary300
                                              : AppThemeData.primary300,
                                      fontFamily: AppThemeData.medium,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Save as'.tr,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: AppThemeData.semiBold,
                                    color:
                                        themeChange.getThem()
                                            ? AppThemeData.grey50
                                            : AppThemeData.grey900,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: 34,
                                  child: ListView.builder(
                                    itemCount: controller.saveAsList.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            controller.selectedSaveAs.value =
                                                controller.saveAsList[index]
                                                    .toString();
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 5,
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  controller
                                                              .selectedSaveAs
                                                              .value ==
                                                          controller
                                                              .saveAsList[index]
                                                              .toString()
                                                      ? AppThemeData.primary300
                                                      : themeChange.getThem()
                                                      ? AppThemeData.grey800
                                                      : AppThemeData.grey100,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                    Radius.circular(20),
                                                  ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                  ),
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    controller.saveAsList[index] ==
                                                            "Home".tr
                                                        ? "assets/icons/ic_home_add.svg"
                                                        : controller
                                                                .saveAsList[index] ==
                                                            "Work".tr
                                                        ? "assets/icons/ic_work.svg"
                                                        : controller
                                                                .saveAsList[index] ==
                                                            "Hotel".tr
                                                        ? "assets/icons/ic_building.svg"
                                                        : "assets/icons/ic_location.svg",
                                                    width: 18,
                                                    height: 18,
                                                    colorFilter: ColorFilter.mode(
                                                      controller
                                                                  .selectedSaveAs
                                                                  .value ==
                                                              controller
                                                                  .saveAsList[index]
                                                                  .toString()
                                                          ? AppThemeData.grey50
                                                          : themeChange
                                                              .getThem()
                                                          ? AppThemeData.grey700
                                                          : AppThemeData
                                                              .grey300,
                                                      BlendMode.srcIn,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    controller.saveAsList[index]
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily:
                                                          AppThemeData.medium,
                                                      color:
                                                          controller
                                                                      .selectedSaveAs
                                                                      .value ==
                                                                  controller
                                                                      .saveAsList[index]
                                                                      .toString()
                                                              ? AppThemeData
                                                                  .grey50
                                                              : themeChange
                                                                  .getThem()
                                                              ? AppThemeData
                                                                  .grey700
                                                              : AppThemeData
                                                                  .grey300,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextFieldWidget(
                                  title: 'House/Flat/Floor No.'.tr,
                                  controller:
                                      controller
                                          .houseBuildingTextEditingController
                                          .value,
                                  hintText: 'House/Flat/Floor No.'.tr,
                                ),
                                TextFieldWidget(
                                  title: 'Apartment/Road/Area'.tr,
                                  controller:
                                      controller
                                          .localityEditingController
                                          .value,
                                  hintText: 'Apartment/Road/Area'.tr,
                                ),
                                TextFieldWidget(
                                  title: 'Nearby landmark'.tr,
                                  controller:
                                      controller
                                          .landmarkEditingController
                                          .value,
                                  hintText: 'Nearby landmark (Optional)'.tr,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    bottomNavigationBar: Container(
                      color:
                          themeChange.getThem()
                              ? AppThemeData.grey800
                              : AppThemeData.grey100,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: RoundedButtonFill(
                          isEnabled: !controller.isLoading.value,
                          title: "Save Address Details".tr,
                          height: 5.5,
                          color: AppThemeData.primary300,
                          fontSizes: 16,
                          onPress: () async {},
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
    );
  }
}
