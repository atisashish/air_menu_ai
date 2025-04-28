import 'package:air_menu_ai_app/constant/show_toast_dialog.dart';
import 'package:air_menu_ai_app/controllers/cart_controller.dart';
import 'package:air_menu_ai_app/controllers/home_controller.dart';
import 'package:air_menu_ai_app/themes/app_them_data.dart';
import 'package:air_menu_ai_app/themes/responsive.dart';
import 'package:air_menu_ai_app/themes/round_button_fill.dart';
import 'package:air_menu_ai_app/themes/text_field_widget.dart';
import 'package:air_menu_ai_app/utils/dark_theme_provider.dart';
import 'package:air_menu_ai_app/widget/my_separator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  HomeController homeController = Get.find();
  late Razorpay _razorpay;

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Map<String, dynamic> body = {
      "address": {
        "street": homeController.streetController.value.text,
        "city": homeController.cityController.value.text,
        "state": homeController.stateController.value.text,
        "zipCode": homeController.zipCodeController.value.text,
      },
      "paymentMethod": "RAZORPAY",
    };
    homeController.putOrder(body: body);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          "Order Placed Successfully",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
    Get.back();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Error: ${response.message}");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment Error: ${response.message}")),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
    print("External Wallet: ${response.walletName}");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("External Wallet: ${response.walletName}")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return GetX(
      init: CartController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor:
              themeChange.getThem()
                  ? AppThemeData.surfaceDark
                  : AppThemeData.surface,
          appBar: AppBar(
            backgroundColor:
                themeChange.getThem()
                    ? AppThemeData.surfaceDark
                    : AppThemeData.surface,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Add Address
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16),
                //   child: InkWell(
                //     onTap: () {
                //       Get.to(AddAddressForm());
                //     },
                //     child: Column(
                //       children: [
                //         Container(
                //           decoration: ShapeDecoration(
                //             color:
                //                 themeChange.getThem()
                //                     ? AppThemeData.grey900
                //                     : AppThemeData.grey50,
                //             shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(8),
                //             ),
                //           ),
                //           child: Padding(
                //             padding: const EdgeInsets.all(10),
                //             child: Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Row(
                //                   mainAxisAlignment: MainAxisAlignment.start,
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     SvgPicture.asset(
                //                       "assets/icons/ic_send_one.svg",
                //                     ),
                //                     const SizedBox(width: 10),
                //                     Text(
                //                       "Add Address",
                //                       textAlign: TextAlign.start,
                //                       style: TextStyle(
                //                         fontFamily: AppThemeData.semiBold,
                //                         color:
                //                             themeChange.getThem()
                //                                 ? AppThemeData.primary300
                //                                 : AppThemeData.primary300,
                //                         fontSize: 16,
                //                       ),
                //                     ),
                //                     const SizedBox(width: 10),
                //                     Icon(
                //                       Icons.add,
                //                       size: 20,
                //                       color:
                //                           themeChange.getThem()
                //                               ? AppThemeData.primary300
                //                               : AppThemeData.primary300,
                //                     ),
                //                   ],
                //                 ),
                //                 const SizedBox(height: 5),
                //                 Obx(
                //                   () => Text(
                //                     homeController.fullAddress.value,
                //                     textAlign: TextAlign.start,
                //                     style: TextStyle(
                //                       fontFamily: AppThemeData.medium,
                //                       color:
                //                           themeChange.getThem()
                //                               ? AppThemeData.grey400
                //                               : AppThemeData.grey500,
                //                     ),
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //         const SizedBox(height: 20),
                //       ],
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
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
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            homeController.cartList.value.data?.items?.length ??
                            0,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {},
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          8.0,
                                        ),
                                        child: CachedNetworkImage(
                                          width: 70,
                                          height: 70,
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              homeController
                                                  .cartList
                                                  .value
                                                  .data
                                                  ?.items?[index]
                                                  .product
                                                  ?.image ??
                                              "",
                                          errorWidget:
                                              (
                                                context,
                                                url,
                                                error,
                                              ) => Container(
                                                color: Colors.grey.withOpacity(
                                                  0.1,
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    8.0,
                                                  ),
                                                  child: Image.network(
                                                    'https://static.thenounproject.com/png/2616531-200.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                          placeholder:
                                              (context, url) => Container(
                                                color: Colors.grey.withOpacity(
                                                  0.1,
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    8.0,
                                                  ),
                                                  child: Image.network(
                                                    'https://static.thenounproject.com/png/2616531-200.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              homeController
                                                      .cartList
                                                      .value
                                                      .data
                                                      ?.items?[index]
                                                      .product
                                                      ?.name ??
                                                  "",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontFamily:
                                                    AppThemeData.regular,
                                                color:
                                                    themeChange.getThem()
                                                        ? AppThemeData.grey50
                                                        : AppThemeData.grey900,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              "₹ ${homeController.cartList.value.data?.items?[index].price ?? ""}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color:
                                                    themeChange.getThem()
                                                        ? AppThemeData.grey50
                                                        : AppThemeData.grey900,
                                                fontFamily:
                                                    AppThemeData.semiBold,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              if ((homeController
                                                          .cartList
                                                          .value
                                                          .data
                                                          ?.items?[index]
                                                          .quantity ??
                                                      0) >
                                                  1) {
                                                setState(() {
                                                  var item =
                                                      homeController
                                                          .cartList
                                                          .value
                                                          .data!
                                                          .items![index];
                                                  if (item.quantity != null &&
                                                      item.quantity! > 1) {
                                                    item.quantity =
                                                        (item.quantity ?? 1) -
                                                        1;
                                                    Map<String, dynamic>
                                                    body = {
                                                      "itemId":
                                                          homeController
                                                              .cartList
                                                              .value
                                                              .data
                                                              ?.items?[index]
                                                              .sId ??
                                                          "",
                                                      "quantity": item.quantity,
                                                      "size":
                                                          homeController
                                                              .cartList
                                                              .value
                                                              .data
                                                              ?.items?[index]
                                                              .size ??
                                                          "",
                                                    };
                                                    homeController.updateCart(
                                                      body: body,
                                                    );
                                                  }
                                                  homeController.cartList
                                                      .refresh();
                                                });
                                              } else {
                                                homeController.removeCart(
                                                  id:
                                                      homeController
                                                          .cartList
                                                          .value
                                                          .data
                                                          ?.items?[index]
                                                          .sId ??
                                                      "",
                                                  index: index,
                                                );
                                                ShowToastDialog.showToast(
                                                  position:
                                                      EasyLoadingToastPosition
                                                          .bottom,
                                                  "Minimum quantity reached. You cannot reduce further.",
                                                );
                                              }
                                            },
                                            icon: Icon(Icons.remove),
                                            color: Colors.red,
                                          ),
                                          Text(
                                            homeController
                                                    .cartList
                                                    .value
                                                    .data!
                                                    .items?[index]
                                                    .quantity
                                                    .toString() ??
                                                "",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              if ((homeController
                                                          .cartList
                                                          .value
                                                          .data
                                                          ?.items?[index]
                                                          .quantity ??
                                                      0) <
                                                  10) {
                                                setState(() {
                                                  var addon =
                                                      homeController
                                                          .cartList
                                                          .value
                                                          .data
                                                          ?.items?[index];
                                                  if (addon != null) {
                                                    addon.quantity =
                                                        (addon.quantity ?? 0) +
                                                        1;
                                                  }
                                                  Map<String, dynamic> body = {
                                                    "itemId":
                                                        homeController
                                                            .cartList
                                                            .value
                                                            .data
                                                            ?.items?[index]
                                                            .sId ??
                                                        "",
                                                    "quantity":
                                                        addon?.quantity ?? 0,
                                                    "size":
                                                        homeController
                                                            .cartList
                                                            .value
                                                            .data
                                                            ?.items?[index]
                                                            .size ??
                                                        "",
                                                  };
                                                  homeController.updateCart(
                                                    body: body,
                                                  );
                                                  homeController.cartList
                                                      .refresh();
                                                });
                                              } else {
                                                ShowToastDialog.showToast(
                                                  position:
                                                      EasyLoadingToastPosition
                                                          .bottom,
                                                  "Maximum limit reached. You cannot add more than 10 items.",
                                                );
                                              }
                                            },
                                            icon: Icon(Icons.add),
                                            color: Colors.green,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 10),
                                      Text(
                                        "Addons".tr,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontFamily: AppThemeData.semiBold,
                                          color:
                                              themeChange.getThem()
                                                  ? AppThemeData.grey300
                                                  : AppThemeData.grey600,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Wrap(
                                        spacing: 6.0,
                                        runSpacing: 6.0,
                                        children:
                                            List.generate(
                                              homeController
                                                      .cartList
                                                      .value
                                                      .data
                                                      ?.items![index]
                                                      .addons
                                                      ?.length ??
                                                  0,
                                              (i) {
                                                return Container(
                                                  decoration: ShapeDecoration(
                                                    color:
                                                        themeChange.getThem()
                                                            ? AppThemeData
                                                                .grey800
                                                            : AppThemeData
                                                                .grey100,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            8,
                                                          ),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 16,
                                                          vertical: 5,
                                                        ),
                                                    child: Text(
                                                      homeController
                                                              .cartList
                                                              .value
                                                              .data
                                                              ?.items![index]
                                                              .addons?[i]
                                                              .key ??
                                                          "",
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            AppThemeData.medium,
                                                        color:
                                                            themeChange
                                                                    .getThem()
                                                                ? AppThemeData
                                                                    .grey500
                                                                : AppThemeData
                                                                    .grey400,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ).toList(),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: MySeparator(
                              color:
                                  themeChange.getThem()
                                      ? AppThemeData.grey700
                                      : AppThemeData.grey200,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bill Details".tr,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: AppThemeData.semiBold,
                          color:
                              themeChange.getThem()
                                  ? AppThemeData.grey50
                                  : AppThemeData.grey900,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: Responsive.width(100, context),
                        decoration: ShapeDecoration(
                          color:
                              themeChange.getThem()
                                  ? AppThemeData.grey900
                                  : AppThemeData.grey50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x14000000),
                              blurRadius: 52,
                              offset: Offset(0, 0),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 14,
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Item totals".tr,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontFamily: AppThemeData.regular,
                                        color:
                                            themeChange.getThem()
                                                ? AppThemeData.grey300
                                                : AppThemeData.grey600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "₹ ${homeController.cartList.value.data?.totalAmount.toString() ?? ''}.00",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontFamily: AppThemeData.regular,
                                      color:
                                          themeChange.getThem()
                                              ? AppThemeData.grey50
                                              : AppThemeData.grey900,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Delivery Fee".tr,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontFamily: AppThemeData.regular,
                                        color:
                                            themeChange.getThem()
                                                ? AppThemeData.grey300
                                                : AppThemeData.grey600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "₹ 40.00",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontFamily: AppThemeData.regular,
                                      color:
                                          themeChange.getThem()
                                              ? AppThemeData.grey50
                                              : AppThemeData.grey900,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              MySeparator(
                                color:
                                    themeChange.getThem()
                                        ? AppThemeData.grey700
                                        : AppThemeData.grey200,
                              ),
                              const SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "To Pay".tr,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontFamily: AppThemeData.regular,
                                        color:
                                            themeChange.getThem()
                                                ? AppThemeData.grey300
                                                : AppThemeData.grey600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "₹ ${(homeController.cartList.value.data?.totalAmount ?? 0) + 40}.00",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontFamily: AppThemeData.regular,
                                      color:
                                          themeChange.getThem()
                                              ? AppThemeData.grey50
                                              : AppThemeData.grey900,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color:
                  themeChange.getThem()
                      ? AppThemeData.grey900
                      : AppThemeData.grey50,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          cardDecoration(),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pay Via".tr,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontFamily: AppThemeData.semiBold,
                                  color:
                                      themeChange.getThem()
                                          ? AppThemeData.grey400
                                          : AppThemeData.grey500,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "Razor Pay",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontFamily: AppThemeData.semiBold,
                                  color:
                                      themeChange.getThem()
                                          ? AppThemeData.grey50
                                          : AppThemeData.grey900,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: RoundedButtonFill(
                      textColor: Colors.white,
                      title: "Pay Now".tr,
                      height: 5,
                      color: AppThemeData.primary300,
                      onPress: () async {
                        var options = {
                          'key': 'rzp_test_1DP5mmOlF5G5ag',
                          'amount':
                              ((homeController
                                          .cartList
                                          .value
                                          .data
                                          ?.totalAmount ??
                                      0) +
                                  40) *
                              100,
                          'name': 'AIR MENU AI',
                          'description': 'Test Payment',
                          'prefill': {
                            'contact': '9876543210',
                            'email': 'test@example.com',
                          },
                          'external': {
                            'wallets': ['paytm'],
                          },
                        };
                        try {
                          _razorpay.open(options);
                        } catch (e) {
                          debugPrint('Error: $e');
                        }
                        // if (homeController.fullAddress.value.isEmpty) {
                        //   ShowToastDialog.showToast(
                        //     "Please Enter Your Full Address",
                        //   );
                        // } else {
                        //
                        // }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  cardDecoration() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        width: 40,
        height: 40,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFFE5E7EB)),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Image.network(
            "https://cdn-images-1.medium.com/max/1200/1*NKfnk1UF9xGoR0URBEc6mw.png",
          ),
        ),
      ),
    );
  }

  tipsDialog(CartController controller, themeChange) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.all(10),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor:
          themeChange.getThem()
              ? AppThemeData.surfaceDark
              : AppThemeData.surface,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: SizedBox(
          width: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFieldWidget(
                title: 'Tips Amount'.tr,
                controller: controller.tipsController.value,
                textInputType: const TextInputType.numberWithOptions(
                  signed: true,
                  decimal: true,
                ),
                textInputAction: TextInputAction.done,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                ],
                prefix: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  child: Text(
                    "867987".tr,
                    style: TextStyle(
                      color:
                          themeChange.getThem()
                              ? AppThemeData.grey50
                              : AppThemeData.grey900,
                      fontFamily: AppThemeData.semiBold,
                      fontSize: 18,
                    ),
                  ),
                ),
                hintText: 'Enter Tips Amount'.tr,
              ),
              Row(
                children: [
                  Expanded(
                    child: RoundedButtonFill(
                      title: "Cancel".tr,
                      color:
                          themeChange.getThem()
                              ? AppThemeData.grey700
                              : AppThemeData.grey200,
                      textColor:
                          themeChange.getThem()
                              ? AppThemeData.grey50
                              : AppThemeData.grey900,
                      onPress: () async {
                        Get.back();
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: RoundedButtonFill(
                      title: "Add".tr,
                      color: AppThemeData.primary300,
                      textColor: AppThemeData.grey50,
                      onPress: () async {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showAddressSelectionSheet() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: Get.isDarkMode ? Colors.grey[900] : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              "Select Address",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            Divider(color: Colors.grey[300]),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: homeController.addresses.length,
              itemBuilder: (context, index) {
                var address = homeController.addresses[index];
                return InkWell(
                  onTap:
                      () => homeController.selectAddress(address["address"]!),
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color:
                          homeController.selectedAddress.value ==
                                  address["address"]
                              ? AppThemeData.primary300.withOpacity(0.1)
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color:
                            homeController.selectedAddress.value ==
                                    address["address"]
                                ? AppThemeData.primary300
                                : Colors.grey[300]!,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          address["label"] == "Home"
                              ? LucideIcons.home
                              : address["label"] == "Work"
                              ? LucideIcons.briefcase
                              : LucideIcons.mapPin,
                          color: AppThemeData.primary300,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                address["label"]!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                address["address"]!,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (homeController.selectedAddress.value ==
                            address["address"])
                          Icon(
                            LucideIcons.checkCircle,
                            color: AppThemeData.primary300,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppThemeData.primary300,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () => Get.back(),
              child: const Text("Cancel"),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}
