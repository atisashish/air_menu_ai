import 'package:air_menu_ai_app/app/cart_screen/cart_screen.dart';
import 'package:air_menu_ai_app/app/restaurant_details_screen/restaurant_details_screen.dart';
import 'package:air_menu_ai_app/constant/show_toast_dialog.dart';
import 'package:air_menu_ai_app/controllers/home_controller.dart';
import 'package:air_menu_ai_app/themes/app_them_data.dart';
import 'package:air_menu_ai_app/utils/dark_theme_provider.dart';
import 'package:air_menu_ai_app/widget/no_data_found.dart';
import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CategoryRestaurantScreen extends StatefulWidget {
  const CategoryRestaurantScreen({super.key});

  @override
  State<CategoryRestaurantScreen> createState() =>
      _CategoryRestaurantScreenState();
}

class _CategoryRestaurantScreenState extends State<CategoryRestaurantScreen> {
  final HomeController homeController = Get.find();
  String categoryID = '';
  String name = '';

  @override
  void initState() {
    dynamic argumentData = Get.arguments;
    categoryID = argumentData["categoryID"];
    name = argumentData["name"];
    print("--->>>${categoryID}");
    homeController.getCategoryProduct(categoryID: categoryID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth < 600 ? 2 : 3;
    double childAspectRatio = (screenWidth / crossAxisCount) / 280;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Obx(
            () => badges.Badge(
              showBadge: true,
              badgeContent: Text(
                homeController.cartList.value.data?.items?.length.toString() ??
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
              child: InkWell(
                onTap: () async {
                  if (homeController.cartList.value.data?.items?.isEmpty ??
                      false) {
                    ShowToastDialog.showToast(
                      "Your Cart Looks Empty",
                      position: EasyLoadingToastPosition.bottom,
                    );
                  } else {
                    Get.to(CartScreen());
                  }
                },
                child: ClipOval(
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color:
                              themeChange.getThem()
                                  ? AppThemeData.grey700
                                  : AppThemeData.grey200,
                        ),
                        borderRadius: BorderRadius.circular(120),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        "assets/icons/ic_shoping_cart.svg",
                        colorFilter: ColorFilter.mode(
                          themeChange.getThem()
                              ? AppThemeData.grey50
                              : AppThemeData.grey900,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 15),
        ],
        title: Text(
          name,
          style: TextStyle(
            fontFamily: AppThemeData.extraBold,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color:
                themeChange.getThem()
                    ? AppThemeData.grey50
                    : AppThemeData.grey900,
          ),
        ),
        backgroundColor:
            themeChange.getThem()
                ? AppThemeData.surfaceDark
                : AppThemeData.surface,
        centerTitle: true,
        titleSpacing: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () =>
              homeController.isProductCategoryLoading.value
                  ? GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: childAspectRatio,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return _buildShimmerEffect();
                    },
                  )
                  : homeController.categoryProductList.value.isEmpty
                  ? NoDataFound()
                  : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: childAspectRatio,
                    ),
                    itemCount: homeController.categoryProductList.value.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.to(
                            RestaurantDetailsScreen(),
                            arguments: {
                              "productId":
                                  homeController
                                      .categoryProductList
                                      .value[index]
                                      .sId,
                            },
                          );
                        },
                        child: FoodCard(
                          image:
                              homeController
                                  .categoryProductList
                                  .value[index]
                                  .image,
                          title:
                              homeController
                                  .categoryProductList
                                  .value[index]
                                  .name,
                          price: "₹ 500",
                        ),
                      );
                    },
                  ),
        ),
      ),
    );
  }

  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image Placeholder
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                color: Colors.grey.shade300,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Title Placeholder
                    Container(
                      height: 14,
                      width: double.infinity,
                      color: Colors.grey.shade300,
                    ),
                    SizedBox(height: 6),

                    /// Price Placeholder
                    Container(
                      height: 12,
                      width: 50,
                      color: Colors.grey.shade300,
                    ),

                    /// Add Button Placeholder
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 35,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FoodCard extends StatelessWidget {
  String? image;
  String? title;
  String? price;

  FoodCard({super.key, this.image, this.title, this.price});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          color:
              themeChange.getThem()
                  ? AppThemeData.grey900
                  : AppThemeData.grey50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                child: CachedNetworkImage(
                  imageUrl: image ?? "",
                  height: constraints.maxHeight * 0.5,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorWidget:
                      (context, url, error) =>
                          Container(color: Colors.grey.withOpacity(0.1)),
                  placeholder:
                      (context, url) =>
                          Container(color: Colors.grey.withOpacity(0.1)),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween, // Prevent overflow
                    children: [
                      Text(
                        title ?? "",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        price ?? "",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.red.shade300,
                                Colors.red.shade400,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 8,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.shopping_bag,
                                  size: 15,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 7),
                                Text(
                                  'Add',
                                  style: TextStyle(
                                    fontFamily: AppThemeData.medium,
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
