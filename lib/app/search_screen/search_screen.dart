import 'package:air_menu_ai_app/app/restaurant_details_screen/restaurant_details_screen.dart';
import 'package:air_menu_ai_app/controllers/home_controller.dart';
import 'package:air_menu_ai_app/themes/app_them_data.dart';
import 'package:air_menu_ai_app/themes/text_field_widget.dart';
import 'package:air_menu_ai_app/utils/dark_theme_provider.dart';
import 'package:air_menu_ai_app/widget/no_data_found.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final HomeController homeController = Get.find();

  @override
  void initState() {
    homeController.searchProduct();
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
        backgroundColor:
            themeChange.getThem()
                ? AppThemeData.surfaceDark
                : AppThemeData.surface,
        centerTitle: false,
        titleSpacing: 0,
        title: Text(
          "Search Food & Restaurant".tr,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: AppThemeData.medium,
            fontSize: 16,
            color:
                themeChange.getThem()
                    ? AppThemeData.grey50
                    : AppThemeData.grey900,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(55),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFieldWidget(
              suffix: Image.asset("assets/icons/ai.png", height: 3, width: 3),
              hintText: 'Search the dish, restaurant, food, meals'.tr,
              prefix: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SvgPicture.asset("assets/icons/ic_search.svg"),
              ),
              controller: null,
              onchange: (value) {
                homeController.searchProduct(searchValue: value);
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () =>
              homeController.isSearchLoading.value
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
                  : homeController.searchProductList.value.isEmpty
                  ? NoDataFound()
                  : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: childAspectRatio,
                    ),
                    itemCount: homeController.searchProductList.value.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.to(
                            RestaurantDetailsScreen(),
                            arguments: {
                              "productId":
                                  homeController
                                      .searchProductList
                                      .value[index]
                                      .sId,
                            },
                          );
                        },
                        child: FoodCard(
                          image:
                              homeController
                                  .searchProductList
                                  .value[index]
                                  .image,
                          title:
                              homeController
                                  .searchProductList
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
