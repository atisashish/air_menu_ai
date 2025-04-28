import 'package:air_menu_ai_app/app/cart_screen/cart_screen.dart';
import 'package:air_menu_ai_app/app/home_screen/home_screen_two.dart';
import 'package:air_menu_ai_app/constant/constant.dart';
import 'package:air_menu_ai_app/constant/show_toast_dialog.dart';
import 'package:air_menu_ai_app/controllers/home_controller.dart';
import 'package:air_menu_ai_app/controllers/restaurant_details_controller.dart';
import 'package:air_menu_ai_app/themes/app_them_data.dart';
import 'package:air_menu_ai_app/themes/responsive.dart';
import 'package:air_menu_ai_app/themes/round_button_fill.dart';
import 'package:air_menu_ai_app/utils/dark_theme_provider.dart';
import 'package:air_menu_ai_app/utils/network_image_widget.dart';
import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class RestaurantDetailsScreen extends StatefulWidget {
  const RestaurantDetailsScreen({super.key});

  @override
  State<RestaurantDetailsScreen> createState() =>
      _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends State<RestaurantDetailsScreen> {
  var selectedOption = 'Regular'.obs;
  String productId = '';
  RxInt mainItem = 1.obs;
  var waterItem = 1;
  RxInt drinkItem = 1.obs;
  RxInt selectedIndex = 0.obs;
  final TextEditingController controller = TextEditingController();
  final HomeController homeController = Get.find();

  @override
  void initState() {
    dynamic argumentData = Get.arguments;
    productId = argumentData["productId"];
    homeController.getProductDetail(productId: productId);
    homeController.quantity = 1.obs;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      body: Obx(
        () =>
            homeController.isProductDetailLoading.value
                ? _buildShimmerEffect()
                : NestedScrollView(
                  headerSliverBuilder: (
                    BuildContext context,
                    bool innerBoxIsScrolled,
                  ) {
                    return <Widget>[
                      SliverAppBar(
                        expandedHeight: Responsive.height(30, context),
                        floating: true,
                        pinned: true,
                        automaticallyImplyLeading: false,
                        backgroundColor: AppThemeData.primary300,
                        title: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color:
                                    themeChange.getThem()
                                        ? AppThemeData.grey50
                                        : AppThemeData.grey50,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                homeController.productDetail.value.name ?? "",
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: AppThemeData.semiBold,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            badges.Badge(
                              showBadge: true,
                              badgeContent: Text(
                                homeController
                                        .cartList
                                        .value
                                        .data
                                        ?.items
                                        ?.length
                                        .toString() ??
                                    "",
                                style: TextStyle(
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                  fontFamily: AppThemeData.semiBold,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      themeChange.getThem()
                                          ? AppThemeData.grey50
                                          : AppThemeData.grey50,
                                ),
                              ),
                              badgeStyle: const badges.BadgeStyle(
                                shape: badges.BadgeShape.circle,
                                badgeColor: AppThemeData.secondary300,
                              ),
                              child: InkWell(
                                onTap: () {
                                  Get.to(CartScreen());
                                },
                                child: ClipOval(
                                  child: SvgPicture.asset(
                                    "assets/icons/ic_shoping_cart.svg",
                                    width: 24,
                                    height: 24,
                                    colorFilter: const ColorFilter.mode(
                                      AppThemeData.grey50,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        flexibleSpace: FlexibleSpaceBar(
                          background: Stack(
                            children: [
                              CachedNetworkImage(
                                imageUrl:
                                    homeController.productDetail.value.image ??
                                    "",
                                fit: BoxFit.cover,
                                width: Responsive.width(100, context),
                                height: Responsive.height(40, context),
                                errorWidget:
                                    (context, url, error) => Container(
                                      color: Colors.grey.withOpacity(0.1),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.network(
                                          'https://static.thenounproject.com/png/2616531-200.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ];
                  },
                  body: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            homeController
                                                    .productDetail
                                                    .value
                                                    .name ??
                                                "",
                                            textAlign: TextAlign.start,
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontSize: 18,
                                              overflow: TextOverflow.ellipsis,
                                              fontFamily: AppThemeData.semiBold,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  themeChange.getThem()
                                                      ? AppThemeData.grey50
                                                      : AppThemeData.grey900,
                                            ),
                                          ),
                                          // SizedBox(
                                          //   width: Responsive.width(78, context),
                                          //   child: Text(
                                          //     homeController
                                          //             .productDetail.value.name ??
                                          //         "",
                                          //     textAlign: TextAlign.start,
                                          //     style: TextStyle(
                                          //       fontSize: 18,
                                          //       fontFamily:
                                          //           AppThemeData.extraBold,
                                          //       fontWeight: FontWeight.bold,
                                          //       color: themeChange.getThem()
                                          //           ? AppThemeData.primary300
                                          //           : AppThemeData.primary300,
                                          //     ),
                                          //   ),
                                          // ),
                                          SizedBox(height: 5),
                                          Text(
                                            homeController
                                                    .productDetail
                                                    .value
                                                    .description ??
                                                "",
                                            textAlign: TextAlign.start,
                                            maxLines: 3,
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontFamily: AppThemeData.regular,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  themeChange.getThem()
                                                      ? AppThemeData.grey50
                                                      : AppThemeData.grey900,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          onPressed: homeController.decrement,
                                          icon: Icon(Icons.remove),
                                          color: Colors.red,
                                        ),
                                        Obx(
                                          () => Text(
                                            homeController.quantity.toString(),
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: homeController.increment,
                                          icon: Icon(Icons.add),
                                          color: Colors.green,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                // SizedBox(height: 10),
                                // Text(
                                //   "Size :",
                                //   textAlign: TextAlign.start,
                                //   maxLines: 1,
                                //   style: TextStyle(
                                //     fontSize: 16,
                                //     overflow: TextOverflow.ellipsis,
                                //     fontFamily: AppThemeData.semiBold,
                                //     fontWeight: FontWeight.w600,
                                //     color: themeChange.getThem()
                                //         ? AppThemeData.grey50
                                //         : AppThemeData.grey900,
                                //   ),
                                // ),
                                SizedBox(height: 10),
                                SizedBox(
                                  height: 40,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        homeController
                                            .productDetail
                                            .value
                                            .sizes
                                            ?.length ??
                                        0,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          right: 10,
                                        ),
                                        child: Obx(
                                          () => _buildOption(
                                            text:
                                                "${homeController.productDetail.value.sizes?[index].name ?? ""}  ₹${homeController.productDetail.value.sizes?[index].price.toString() ?? ""}.00",
                                            isSelected:
                                                selectedIndex.value == index,
                                            onTap: () {
                                              selectedIndex.value = index;
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          homeController.productDetail.value.addons == []
                              ? SizedBox()
                              : Padding(
                                padding: const EdgeInsets.only(left: 14),
                                child: Text(
                                  "Addons :",
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 16,
                                    overflow: TextOverflow.ellipsis,
                                    fontFamily: AppThemeData.semiBold,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        themeChange.getThem()
                                            ? AppThemeData.grey50
                                            : AppThemeData.grey900,
                                  ),
                                ),
                              ),
                          homeController.productDetail.value.addons == []
                              ? SizedBox()
                              : SizedBox(
                                height:
                                    150 *
                                    (homeController
                                                .productDetail
                                                .value
                                                .addons
                                                ?.length ??
                                            0)
                                        .toDouble(),
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount:
                                      homeController
                                          .productDetail
                                          .value
                                          .addons
                                          ?.length ??
                                      0,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                      child: DrinkCard(
                                        button: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                if ((homeController
                                                            .productDetail
                                                            .value
                                                            .addons?[index]
                                                            .quantity ??
                                                        0) >
                                                    0) {
                                                  setState(() {
                                                    homeController
                                                        .productDetail
                                                        .value
                                                        .addons?[index]
                                                        .quantity--;
                                                  });
                                                } else {
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
                                                      .productDetail
                                                      .value
                                                      .addons?[index]
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
                                                            .productDetail
                                                            .value
                                                            .addons?[index]
                                                            .quantity ??
                                                        0) <
                                                    10) {
                                                  setState(() {
                                                    homeController
                                                        .productDetail
                                                        .value
                                                        .addons?[index]
                                                        .quantity++;
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
                                        title:
                                            homeController
                                                .productDetail
                                                .value
                                                .addons?[index]
                                                .name ??
                                            "",
                                        subTitle:
                                            homeController
                                                .productDetail
                                                .value
                                                .addons?[index]
                                                .key ??
                                            "",
                                        image:
                                            homeController
                                                .productDetail
                                                .value
                                                .addons?[index]
                                                .image ??
                                            "",
                                        amount:
                                            "₹ ${homeController.productDetail.value.addons?[index].price ?? ""}",
                                      ),
                                    );
                                  },
                                ),
                              ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: SizedBox(
                              height: 50,
                              child: TextFormField(
                                controller: controller,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    borderSide: BorderSide(
                                      color:
                                          themeChange.getThem()
                                              ? AppThemeData.grey900
                                              : AppThemeData.grey50,
                                      width: 1,
                                    ),
                                  ),
                                  hintText:
                                      'Add note (extra mayo, cheese, etc.)'.tr,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Obx(
                            () =>
                                homeController.isCart.value
                                    ? Center(
                                      child: CircularProgressIndicator(
                                        color: AppThemeData.primary300,
                                        strokeWidth: 1,
                                      ),
                                    )
                                    : InkWell(
                                      onTap: () {
                                        Map<String, dynamic> body = {
                                          "productId": productId,
                                          "quantity":
                                              homeController.quantity.value,
                                          "size":
                                              homeController
                                                  .productDetail
                                                  .value
                                                  .sizes?[selectedIndex.value]
                                                  .name ??
                                              "",
                                          "addons":
                                              homeController
                                                  .productDetail
                                                  .value
                                                  .addons
                                                  ?.where(
                                                    (addon) =>
                                                        (addon.quantity) > 0,
                                                  )
                                                  .map(
                                                    (addon) => {
                                                      "key": addon.key,
                                                      "quantity":
                                                          addon.quantity,
                                                    },
                                                  )
                                                  .toList(),
                                        };
                                        homeController.addToCart(body: body);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppThemeData.primary300,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 18,
                                            vertical: 12,
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.shopping_bag,
                                                size: 15,
                                                color: Colors.white,
                                              ),
                                              SizedBox(width: 7),
                                              Obx(
                                                () => Text(
                                                  'Add ₹ ${(int.parse(homeController.productDetail.value.sizes?[selectedIndex.value].price.toString() ?? "") * homeController.quantity.value) + totalAddonsPrice}.00',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        AppThemeData.extraBold,
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                          ),
                          SizedBox(height: 200),
                        ],
                      ),
                    ),
                  ),
                ),
      ),
    );
  }

  int get totalAddonsPrice {
    return (homeController.productDetail.value.addons ?? []).fold(
      0,
      (sum, addon) => sum + (addon.totalPrice),
    );
  }

  Widget _buildShimmerEffect() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 16),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(height: 20, width: 200, color: Colors.white),
            ),
            SizedBox(height: 8),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(height: 20, width: 100, color: Colors.white),
            ),
            SizedBox(height: 16),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Column(
                children: List.generate(3, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      height: 15,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 16),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(height: 20, width: 200, color: Colors.white),
            ),
            SizedBox(height: 8),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(height: 20, width: 100, color: Colors.white),
            ),
            SizedBox(height: 16),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Column(
                children: List.generate(3, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      height: 15,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 16),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(height: 20, width: 200, color: Colors.white),
            ),
            SizedBox(height: 8),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(height: 20, width: 100, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50 : Colors.white,
          border: Border.all(
            color: isSelected ? AppThemeData.primary300 : AppThemeData.grey300,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? AppThemeData.primary300 : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

class CouponListView extends StatelessWidget {
  final RestaurantDetailsController controller;

  const CouponListView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return SizedBox(
      height: Responsive.height(9, context),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color:
                    themeChange.getThem()
                        ? AppThemeData.grey900
                        : AppThemeData.grey50,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color:
                        themeChange.getThem()
                            ? AppThemeData.grey800
                            : AppThemeData.grey100,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: SizedBox(
                  width: Responsive.width(80, context),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 60,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/offer_gif.gif"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "100 %",
                            style: TextStyle(
                              color:
                                  themeChange.getThem()
                                      ? AppThemeData.grey50
                                      : AppThemeData.grey50,
                              fontFamily: AppThemeData.semiBold,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "offerModel.description.toString()",
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
                          InkWell(
                            onTap: () {
                              Clipboard.setData(
                                ClipboardData(text: "100"),
                              ).then((value) {
                                ShowToastDialog.showToast("Copied".tr);
                              });
                            },
                            child: Row(
                              children: [
                                Text(
                                  "offerModel.code.toString()",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color:
                                        themeChange.getThem()
                                            ? AppThemeData.grey400
                                            : AppThemeData.grey500,
                                    fontFamily: AppThemeData.semiBold,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                SvgPicture.asset("assets/icons/ic_copy.svg"),
                                const SizedBox(
                                  height: 10,
                                  child: VerticalDivider(),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "12:00 AM",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color:
                                        themeChange.getThem()
                                            ? AppThemeData.grey400
                                            : AppThemeData.grey500,
                                    fontFamily: AppThemeData.semiBold,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProductListView extends StatelessWidget {
  const ProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Container(
      color: themeChange.getThem() ? AppThemeData.grey900 : AppThemeData.grey50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: 2,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return ExpansionTile(
            childrenPadding: EdgeInsets.zero,
            tilePadding: EdgeInsets.zero,
            shape: const Border(),
            initiallyExpanded: true,
            title: Text(
              "Burger",
              style: TextStyle(
                fontSize: 18,
                fontFamily: AppThemeData.semiBold,
                fontWeight: FontWeight.w600,
                color:
                    themeChange.getThem()
                        ? AppThemeData.grey50
                        : AppThemeData.grey900,
              ),
            ),
            children: [
              ListView.builder(
                itemCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset("assets/icons/ic_veg.svg"),
                                  const SizedBox(width: 5),
                                  Text(
                                    "Pure veg.".tr,
                                    style: TextStyle(
                                      color: AppThemeData.success400,
                                      fontFamily: AppThemeData.semiBold,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Burger",
                                style: TextStyle(
                                  fontSize: 18,
                                  color:
                                      themeChange.getThem()
                                          ? AppThemeData.grey50
                                          : AppThemeData.grey900,
                                  fontFamily: AppThemeData.semiBold,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "100",
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
                                  const SizedBox(width: 5),
                                  Text(
                                    "100",
                                    style: TextStyle(
                                      fontSize: 14,
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor:
                                          themeChange.getThem()
                                              ? AppThemeData.grey500
                                              : AppThemeData.grey400,
                                      color:
                                          themeChange.getThem()
                                              ? AppThemeData.grey500
                                              : AppThemeData.grey400,
                                      fontFamily: AppThemeData.semiBold,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/ic_star.svg",
                                    colorFilter: const ColorFilter.mode(
                                      AppThemeData.warning300,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "${Constant.calculateReview(reviewCount: "200", reviewSum: "200")} (${"40"})",
                                    style: TextStyle(
                                      color:
                                          themeChange.getThem()
                                              ? AppThemeData.grey50
                                              : AppThemeData.grey900,
                                      fontFamily: AppThemeData.regular,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "We are providing all types of food items",
                                maxLines: 2,
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color:
                                      themeChange.getThem()
                                          ? AppThemeData.grey50
                                          : AppThemeData.grey900,
                                  fontFamily: AppThemeData.regular,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 5),
                              InkWell(
                                onTap: () {},
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.info,
                                      color:
                                          themeChange.getThem()
                                              ? AppThemeData.secondary300
                                              : AppThemeData.secondary300,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Info".tr,
                                      maxLines: 2,
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 16,
                                        color:
                                            themeChange.getThem()
                                                ? AppThemeData.secondary300
                                                : AppThemeData.secondary300,
                                        fontFamily: AppThemeData.regular,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(16),
                          ),
                          child: Stack(
                            children: [
                              NetworkImageWidget(
                                imageUrl:
                                    "https://static.vecteezy.com/system/resources/thumbnails/023/809/530/small/a-flying-burger-with-all-the-layers-ai-generative-free-photo.jpg",
                                fit: BoxFit.cover,
                                height: Responsive.height(16, context),
                                width: Responsive.width(34, context),
                              ),
                              Container(
                                height: Responsive.height(16, context),
                                width: Responsive.width(34, context),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: const Alignment(-0.00, -1.00),
                                    end: const Alignment(0, 1),
                                    colors: [
                                      Colors.black.withOpacity(0),
                                      const Color(0xFF111827),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 10,
                                top: 10,
                                child: InkWell(
                                  onTap: () async {},
                                  child: SvgPicture.asset(
                                    "assets/icons/ic_like.svg",
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                left: 20,
                                right: 20,
                                child: RoundedButtonFill(
                                  title: "Add".tr,
                                  width: 10,
                                  height: 4,
                                  color:
                                      themeChange.getThem()
                                          ? AppThemeData.grey900
                                          : AppThemeData.grey50,
                                  textColor: AppThemeData.primary300,
                                  onPress: () async {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  productDetailsBottomSheet(BuildContext context) {
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
            heightFactor: 0.85,
            child: StatefulBuilder(
              builder: (context1, setState) {
                return ProductDetailsView();
              },
            ),
          ),
    );
  }

  infoDialog(RestaurantDetailsController controller, themeChange) {
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Food Information's".tr,
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
                ),
                const SizedBox(height: 5),
                Text(
                  "productModel.description.toString()",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: AppThemeData.regular,
                    fontWeight: FontWeight.w400,
                    color:
                        themeChange.getThem()
                            ? AppThemeData.grey50
                            : AppThemeData.grey900,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "Gram".tr,
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
                      "productModel.grams.toString()",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: AppThemeData.bold,
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
                        "Calories".tr,
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
                      "productModel.calories.toString()",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: AppThemeData.bold,
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
                        "Proteins".tr,
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
                      "productModel.proteins.toString()",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: AppThemeData.bold,
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
                        "Fats".tr,
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
                      "productModel.fats.toString()",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: AppThemeData.bold,
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
                const SizedBox(height: 20),
                RoundedButtonFill(
                  title: "Back".tr,
                  color: AppThemeData.primary300,
                  textColor: AppThemeData.grey50,
                  onPress: () async {
                    Get.back();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return GetX(
      init: RestaurantDetailsController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor:
              themeChange.getThem()
                  ? AppThemeData.surfaceDark
                  : AppThemeData.surface,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color:
                      themeChange.getThem()
                          ? AppThemeData.grey900
                          : AppThemeData.grey50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(16),
                          ),
                          child: Stack(
                            children: [
                              NetworkImageWidget(
                                imageUrl: "productModel.photo.toString()",
                                height: Responsive.height(11, context),
                                width: Responsive.width(22, context),
                                fit: BoxFit.cover,
                              ),
                              Container(
                                height: Responsive.height(11, context),
                                width: Responsive.width(22, context),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: const Alignment(-0.00, -1.00),
                                    end: const Alignment(0, 1),
                                    colors: [
                                      Colors.black.withOpacity(0),
                                      const Color(0xFF111827),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "productModel.name.toString()",
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 16,
                                        overflow: TextOverflow.ellipsis,
                                        fontFamily: AppThemeData.semiBold,
                                        fontWeight: FontWeight.w600,
                                        color:
                                            themeChange.getThem()
                                                ? AppThemeData.grey50
                                                : AppThemeData.grey900,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {},
                                    child: SvgPicture.asset(
                                      "assets/icons/ic_like.svg",
                                      colorFilter: const ColorFilter.mode(
                                        AppThemeData.grey500,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "productModel.description.toString()",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: AppThemeData.regular,
                                  fontWeight: FontWeight.w400,
                                  color:
                                      themeChange.getThem()
                                          ? AppThemeData.grey50
                                          : AppThemeData.grey900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 5,
                      ),
                      child: Container(
                        decoration: ShapeDecoration(
                          color:
                              themeChange.getThem()
                                  ? AppThemeData.grey900
                                  : AppThemeData.grey50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Offstage(),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: Wrap(
                                  spacing: 6.0,
                                  runSpacing: 6.0,
                                  children:
                                      List.generate(3, (i) {
                                        return InkWell(
                                          onTap: () async {},
                                          child: Chip(
                                            shape: const RoundedRectangleBorder(
                                              side: BorderSide(
                                                color: Colors.transparent,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                            ),
                                            label: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  "ahsgdjahdbak",
                                                  style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontFamily:
                                                        AppThemeData.medium,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        themeChange.getThem()
                                                            ? AppThemeData
                                                                .grey600
                                                            : AppThemeData
                                                                .grey300,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            backgroundColor:
                                                themeChange.getThem()
                                                    ? AppThemeData.grey800
                                                    : AppThemeData.grey100,
                                            elevation: 6.0,
                                            padding: const EdgeInsets.all(8.0),
                                          ),
                                        );
                                      }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 5,
                  ),
                  child: Container(
                    decoration: ShapeDecoration(
                      color:
                          themeChange.getThem()
                              ? AppThemeData.grey900
                              : AppThemeData.grey50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              "Addons".tr,
                              style: TextStyle(
                                fontSize: 16,
                                overflow: TextOverflow.ellipsis,
                                fontFamily: AppThemeData.semiBold,
                                fontWeight: FontWeight.w600,
                                color:
                                    themeChange.getThem()
                                        ? AppThemeData.grey100
                                        : AppThemeData.grey800,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Divider(),
                          ),
                          ListView.builder(
                            itemCount: 5,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "title",
                                        textAlign: TextAlign.start,
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 16,
                                          overflow: TextOverflow.ellipsis,
                                          fontFamily: AppThemeData.medium,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              themeChange.getThem()
                                                  ? AppThemeData.grey100
                                                  : AppThemeData.grey800,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "1000",
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 16,
                                        overflow: TextOverflow.ellipsis,
                                        fontFamily: AppThemeData.medium,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            themeChange.getThem()
                                                ? AppThemeData.grey100
                                                : AppThemeData.grey800,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Obx(
                                      () => SizedBox(
                                        height: 24.0,
                                        width: 24.0,
                                        child: Checkbox(
                                          value: true,
                                          activeColor: AppThemeData.primary300,
                                          onChanged: (value) {},
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      width: Responsive.width(100, context),
                      height: Responsive.height(5.5, context),
                      decoration: ShapeDecoration(
                        color:
                            themeChange.getThem()
                                ? AppThemeData.grey700
                                : AppThemeData.grey200,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(200),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: const Icon(Icons.remove),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "10",
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 16,
                                overflow: TextOverflow.ellipsis,
                                fontFamily: AppThemeData.medium,
                                fontWeight: FontWeight.w500,
                                color:
                                    themeChange.getThem()
                                        ? AppThemeData.grey100
                                        : AppThemeData.grey800,
                              ),
                            ),
                          ),
                          InkWell(onTap: () {}, child: const Icon(Icons.add)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: RoundedButtonFill(
                      title: "Add item ${1000}".tr,
                      height: 5.5,
                      color: AppThemeData.primary300,
                      textColor: AppThemeData.grey50,
                      fontSizes: 16,
                      onPress: () async {
                        Get.back();
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
}
